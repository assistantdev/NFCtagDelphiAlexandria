unit uNFC;

interface

uses
  System.SysUtils,
  System.Classes,
  Androidapi.JNIBridge,
  Androidapi.JNI.NFC,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
  FMX.Helpers.Android;

type
  TNFCTagDetectadaProc = TProc<string, string, string>;

  TNFCReaderCallback = class(TJavaLocal, JNfcAdapter_ReaderCallback)
  private
    FOnTag: TProc<JTag>;
  public
    constructor Create(AOnTag: TProc<JTag>);
    procedure onTagDiscovered(tag: JTag); cdecl;
  end;

  TNFC = class
  private
    FReaderCallback: TNFCReaderCallback;
    FAtivoReaderMode: Boolean;
    FOnTagDetectada: TNFCTagDetectadaProc;
    function GetAdapter: JNfcAdapter;
    function BytesParaHex(const ABytes: TJavaArray<Byte>): string;
    function DecodificarTextoNdef(const APayload: TJavaArray<Byte>): string;
    procedure ProcessarTag(ATag: JTag);
  public
    constructor Create(AOnTagDetectada: TNFCTagDetectadaProc);
    destructor Destroy; override;
    procedure Ativar;
    procedure Desativar;
    function Suportado: Boolean;
    function Habilitado: Boolean;
  end;

implementation

constructor TNFCReaderCallback.Create(AOnTag: TProc<JTag>);
begin
  inherited Create;
  FOnTag := AOnTag;
end;

procedure TNFCReaderCallback.onTagDiscovered(tag: JTag); cdecl;
begin
  if Assigned(FOnTag) then
    FOnTag(tag);
end;

constructor TNFC.Create(AOnTagDetectada: TNFCTagDetectadaProc);
begin
  inherited Create;
  FOnTagDetectada := AOnTagDetectada;
  FAtivoReaderMode := False;
  FReaderCallback := nil;
end;

destructor TNFC.Destroy;
begin
  Desativar;
  FreeAndNil(FReaderCallback);
  inherited;
end;

function TNFC.GetAdapter: JNfcAdapter;
begin
  Result := TJNfcAdapter.JavaClass.getDefaultAdapter(TAndroidHelper.Context);
end;

function TNFC.Suportado: Boolean;
var
  Adapter: JNfcAdapter;
begin
  Adapter := GetAdapter;
  Result := Assigned(Adapter);
end;

function TNFC.Habilitado: Boolean;
var
  Adapter: JNfcAdapter;
begin
  Adapter := GetAdapter;
  Result := Assigned(Adapter) and Adapter.isEnabled;
end;

function TNFC.BytesParaHex(const ABytes: TJavaArray<Byte>): string;
var
  i: Integer;
begin
  Result := '';
  if ABytes = nil then Exit;
  for i := 0 to ABytes.Length - 1 do
    Result := Result + IntToHex(ABytes[i] and $FF, 2);
end;

function TNFC.DecodificarTextoNdef(const APayload: TJavaArray<Byte>): string;
var
  LangLen: Integer;
  TextBytes: TBytes;
  i: Integer;
begin
  Result := '';
  if (APayload = nil) or (APayload.Length < 2) then Exit;
  LangLen := APayload[0] and $3F;
  if APayload.Length <= (1 + LangLen) then Exit;
  SetLength(TextBytes, APayload.Length - 1 - LangLen);
  for i := 0 to High(TextBytes) do
    TextBytes[i] := APayload[1 + LangLen + i];
  Result := TEncoding.UTF8.GetString(TextBytes);
end;

procedure TNFC.ProcessarTag(ATag: JTag);
var
  TagId: TJavaArray<Byte>;
  TechList: TJavaObjectArray<JString>;
  NdefTech: JNdef;
  NdefMsg: JNdefMessage;
  Records: TJavaObjectArray<JNdefRecord>;
  Rec: JNdefRecord;
  i: Integer;
  UID, Techs, Conteudo: string;
begin
  UID := '';
  Techs := '';
  Conteudo := '';

  try
    TagId := ATag.getId;
    UID := BytesParaHex(TagId);
  except
  end;

  try
    TechList := ATag.getTechList;
    if Assigned(TechList) then
      for i := 0 to TechList.Length - 1 do
      begin
        if Techs <> '' then Techs := Techs + ', ';
        Techs := Techs + JStringToString(TechList[i]);
      end;
  except
  end;

  try
    NdefTech := TJNdef.JavaClass.get(ATag);
    if Assigned(NdefTech) then
    begin
      NdefTech.connect;
      try
        NdefMsg := NdefTech.getNdefMessage;
        if Assigned(NdefMsg) then
        begin
          Records := NdefMsg.getRecords;
          if Assigned(Records) then
            for i := 0 to Records.Length - 1 do
            begin
              Rec := Records[i];
              if not Assigned(Rec) then Continue;
              if Rec.getTnf = 1 then
                Conteudo := Conteudo + DecodificarTextoNdef(Rec.getPayload) + ' '
              else
                Conteudo := Conteudo + '[TNF=' + IntToStr(Rec.getTnf) + ':' + BytesParaHex(Rec.getPayload) + '] ';
            end;
        end;
      finally
        NdefTech.close;
      end;
    end;
  except
  end;

  if Assigned(FOnTagDetectada) then
    TThread.Queue(nil, procedure
    begin
      FOnTagDetectada(UID, Techs, Trim(Conteudo));
    end);
end;

procedure TNFC.Ativar;
var
  Adapter: JNfcAdapter;
begin
  if FAtivoReaderMode then Exit;

  Adapter := GetAdapter;
  if not Assigned(Adapter) then Exit;
  if not Adapter.isEnabled then Exit;

  if not Assigned(FReaderCallback) then
    FReaderCallback := TNFCReaderCallback.Create(ProcessarTag);

  try
    Adapter.enableReaderMode(
      TAndroidHelper.Activity,
      FReaderCallback,
      1 or 2 or 4 or 8,
      nil);
    FAtivoReaderMode := True;
  except
  end;
end;

procedure TNFC.Desativar;
var
  Adapter: JNfcAdapter;
begin
  if not FAtivoReaderMode then Exit;
  Adapter := GetAdapter;
  if Assigned(Adapter) then
  begin
    try
      Adapter.disableReaderMode(TAndroidHelper.Activity);
    except
    end;
  end;
  FAtivoReaderMode := False;
end;

end.
