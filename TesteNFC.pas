unit TesteNFC;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Messaging,
  Androidapi.JNIBridge,
  Androidapi.JNI.NFC,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App,
  Androidapi.JNI.Os,
  FMX.Helpers.Android,
  Androidapi.Helpers,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo;

type
  // Callback chamado pelo Android quando uma tag NFC e aproximada
  TNFCReaderCallback = class(TJavaLocal, JNfcAdapter_ReaderCallback)
  private
    FOnTagDiscovered: TProc<JTag>;
  public
    constructor Create(AOnTagDiscovered: TProc<JTag>);
    procedure onTagDiscovered(tag: JTag); cdecl;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    MemoLog: TMemo;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FDispatchActive: Boolean;
    FReaderCallback: TNFCReaderCallback;
    procedure CheckNFCSupport;
    procedure EnableForegroundDispatch;
    procedure DisableForegroundDispatch;
    procedure HandleIntent(const Sender: TObject; const M: TMessage);
    procedure ProcessNdefMessages(Intent: JIntent);
    procedure OnTagDiscovered(Tag: JTag);
    function BytesToHex(const Bytes: TJavaArray<Byte>): string;
    function DecodeNdefText(const Payload: TJavaArray<Byte>): string;
    function GetAdapter: JNfcAdapter;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

// ===== TNFCReaderCallback =====

constructor TNFCReaderCallback.Create(AOnTagDiscovered: TProc<JTag>);
begin
  inherited Create;
  FOnTagDiscovered := AOnTagDiscovered;
end;

procedure TNFCReaderCallback.onTagDiscovered(tag: JTag); cdecl;
begin
  if Assigned(FOnTagDiscovered) then
    FOnTagDiscovered(tag);
end;

// ===== TForm1 =====

function TForm1.GetAdapter: JNfcAdapter;
begin
  Result := TJNfcAdapter.JavaClass.getDefaultAdapter(TAndroidHelper.Context);
end;

function TForm1.BytesToHex(const Bytes: TJavaArray<Byte>): string;
var
  i: Integer;
begin
  Result := '';
  if Bytes = nil then Exit;
  for i := 0 to Bytes.Length - 1 do
    Result := Result + IntToHex(Bytes[i] and $FF, 2);
end;

function TForm1.DecodeNdefText(const Payload: TJavaArray<Byte>): string;
var
  LangLen: Integer;
  TextBytes: TBytes;
  i: Integer;
begin
  Result := '';
  if (Payload = nil) or (Payload.Length < 2) then Exit;
  LangLen := Payload[0] and $3F;
  if Payload.Length <= (1 + LangLen) then Exit;
  SetLength(TextBytes, Payload.Length - 1 - LangLen);
  for i := 0 to High(TextBytes) do
    TextBytes[i] := Payload[1 + LangLen + i];
  Result := TEncoding.UTF8.GetString(TextBytes);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if not FDispatchActive then
    EnableForegroundDispatch;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDispatchActive := False;
  FReaderCallback := nil;
  TMessageManager.DefaultManager.SubscribeToMessage(
    TMessageReceivedNotification, HandleIntent);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DisableForegroundDispatch;
  FreeAndNil(FReaderCallback);
  TMessageManager.DefaultManager.Unsubscribe(
    TMessageReceivedNotification, HandleIntent);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CheckNFCSupport;
end;

procedure TForm1.CheckNFCSupport;
var
  NfcAdapter: JNfcAdapter;
begin
  NfcAdapter := GetAdapter;

  if not Assigned(NfcAdapter) then
  begin
    MemoLog.Lines.Add('Erro: dispositivo nao suporta NFC.');
    Exit;
  end;

  MemoLog.Lines.Add('Hardware NFC: PRESENTE');

  if not NfcAdapter.isEnabled then
  begin
    MemoLog.Lines.Add('NFC DESLIGADO - ative nas configuracoes.');
    Exit;
  end;

  MemoLog.Lines.Add('NFC LIGADO - ativando leitura em foreground...');
  EnableForegroundDispatch;
  MemoLog.Lines.Add('Pronto! Aproxime uma tag NFC.');
end;

procedure TForm1.EnableForegroundDispatch;
var
  NfcAdapter: JNfcAdapter;
  Flags: Integer;
begin
  if FDispatchActive then Exit;

  NfcAdapter := GetAdapter;
  if not Assigned(NfcAdapter) then Exit;

  // Cria o callback apontando para OnTagDiscovered
  if not Assigned(FReaderCallback) then
    FReaderCallback := TNFCReaderCallback.Create(OnTagDiscovered);

  try
    // NFC_A=1, NFC_B=2, NFC_F=4, NFC_V=8
    Flags := 1 or 2 or 4 or 8;

    NfcAdapter.enableReaderMode(
      TAndroidHelper.Activity,
      FReaderCallback,
      Flags,
      nil);

    MemoLog.Lines.Add('ReaderMode: OK');
    FDispatchActive := True;
  except
    on E: Exception do
      MemoLog.Lines.Add('ReaderMode ERRO: ' + E.Message);
  end;
end;

procedure TForm1.DisableForegroundDispatch;
var
  NfcAdapter: JNfcAdapter;
begin
  if not FDispatchActive then Exit;
  NfcAdapter := GetAdapter;
  if Assigned(NfcAdapter) then
  begin
    try
      NfcAdapter.disableReaderMode(TAndroidHelper.Activity);
    except
    end;
  end;
  FDispatchActive := False;
end;

procedure TForm1.HandleIntent(const Sender: TObject; const M: TMessage);
var
  Notification: TMessageReceivedNotification;
  Action: string;
begin
  if not (M is TMessageReceivedNotification) then Exit;
  Notification := TMessageReceivedNotification(M);
  if Notification.Value = nil then Exit;

  Action := JStringToString(Notification.Value.getAction);

  if (Action = 'android.nfc.action.NDEF_DISCOVERED') or
     (Action = 'android.nfc.action.TAG_DISCOVERED') or
     (Action = 'android.nfc.action.TECH_DISCOVERED') then
    ProcessNdefMessages(Notification.Value);
end;

// Chamado pelo Android via callback - vem de thread Java
procedure TForm1.OnTagDiscovered(Tag: JTag);
var
  TagId: TJavaArray<Byte>;
  TechList: TJavaObjectArray<JString>;
  NdefTech: JNdef;
  NdefMsg: JNdefMessage;
  Records: TJavaObjectArray<JNdefRecord>;
  Rec: JNdefRecord;
  Tnf: SmallInt;
  Payload: TJavaArray<Byte>;
  i: Integer;
  Techs, Texto: string;
begin
  // Leitura NDEF fora do Synchronize - operacao de IO nao pode ser na UI thread
  try
    // Conecta na tech Ndef da tag
    NdefTech := TJNdef.JavaClass.get(Tag);
    if Assigned(NdefTech) then
    begin
      NdefTech.connect;
      try
        NdefMsg := NdefTech.getNdefMessage;
      finally
        NdefTech.close;
      end;
    end
    else
      NdefMsg := nil;
  except
    NdefMsg := nil;
  end;

  // Leitura do UID e techs (sem IO)
  TagId := Tag.getId;
  TechList := Tag.getTechList;
  Techs := '';
  if Assigned(TechList) then
    for i := 0 to TechList.Length - 1 do
    begin
      if Techs <> '' then Techs := Techs + ', ';
      Techs := Techs + JStringToString(TechList[i]);
    end;

  // Decodifica registros NDEF antes de sincronizar
  Texto := '';
  if Assigned(NdefMsg) then
  begin
    Records := NdefMsg.getRecords;
    if Assigned(Records) then
      for i := 0 to Records.Length - 1 do
      begin
        Rec := Records[i];
        if not Assigned(Rec) then Continue;
        Tnf := Rec.getTnf;
        Payload := Rec.getPayload;
        if Tnf = 1 then
          Texto := Texto + 'Texto: ' + DecodeNdefText(Payload) + sLineBreak
        else
          Texto := Texto + Format('TNF=%d Hex: %s', [Tnf, BytesToHex(Payload)]) + sLineBreak;
      end;
  end;

  // Atualiza UI
  TThread.Queue(nil, procedure
  begin
    MemoLog.Lines.Add('--- Tag detectada ---');
    MemoLog.Lines.Add('UID: ' + BytesToHex(TagId));
    MemoLog.Lines.Add('Techs: ' + Techs);
    if Texto <> '' then
      MemoLog.Lines.Add(Texto)
    else
      MemoLog.Lines.Add('Sem conteudo NDEF.');
  end);
end;

procedure TForm1.ProcessNdefMessages(Intent: JIntent);
var
  RawMessages: TJavaObjectArray<JParcelable>;
  NdefMsg: JNdefMessage;
  Records: TJavaObjectArray<JNdefRecord>;
  Rec: JNdefRecord;
  i, j: Integer;
  Tnf: SmallInt;
  Payload: TJavaArray<Byte>;
  TagId: TJavaArray<Byte>;
  Tag: JTag;
begin
  MemoLog.Lines.Add('--- Tag detectada (Intent) ---');

  Tag := TJTag.Wrap(
    Intent.getParcelableExtra(
      TJNfcAdapter.JavaClass.EXTRA_TAG));
  if Assigned(Tag) then
  begin
    TagId := Tag.getId;
    MemoLog.Lines.Add('Tag UID: ' + BytesToHex(TagId));
  end;

  RawMessages := Intent.getParcelableArrayExtra(
    TJNfcAdapter.JavaClass.EXTRA_NDEF_MESSAGES);

  if (RawMessages = nil) or (RawMessages.Length = 0) then
  begin
    MemoLog.Lines.Add('Sem conteudo NDEF na tag.');
    Exit;
  end;

  for i := 0 to RawMessages.Length - 1 do
  begin
    NdefMsg := TJNdefMessage.Wrap(RawMessages[i]);
    if not Assigned(NdefMsg) then Continue;

    Records := NdefMsg.getRecords;
    if (Records = nil) or (Records.Length = 0) then Continue;

    MemoLog.Lines.Add(Format('Mensagem %d - %d registro(s):', [i + 1, Records.Length]));

    for j := 0 to Records.Length - 1 do
    begin
      Rec := Records[j];
      if not Assigned(Rec) then Continue;
      Tnf := Rec.getTnf;
      Payload := Rec.getPayload;

      if Tnf = 1 then
        MemoLog.Lines.Add('  Texto: ' + DecodeNdefText(Payload))
      else
        MemoLog.Lines.Add(Format('  TNF=%d  Hex: %s', [Tnf, BytesToHex(Payload)]));
    end;
  end;
end;

end.
