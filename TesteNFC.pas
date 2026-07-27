unit TesteNFC;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo,
  uNFC;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MemoLog: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FNFC: TNFC;
    procedure OnTagDetectada(const AUID, ATechs, AConteudo: string);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormActivate(Sender: TObject);
begin
  if not Assigned(FNFC) then
    FNFC := TNFC.Create(OnTagDetectada);
  if FNFC.Suportado and FNFC.Habilitado then
    FNFC.Ativar
  else
    MemoLog.Lines.Add('NFC nao disponivel ou desligado.');
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
  if Assigned(FNFC) then
    FNFC.Desativar;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FNFC);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  if not Assigned(FNFC) then
    FNFC := TNFC.Create(OnTagDetectada);

  if not FNFC.Suportado then
  begin
    MemoLog.Lines.Add('Hardware NFC: AUSENTE');
    Exit;
  end;

  MemoLog.Lines.Add('Hardware NFC: PRESENTE');

  if not FNFC.Habilitado then
  begin
    MemoLog.Lines.Add('NFC DESLIGADO - ative nas configuracoes.');
    Exit;
  end;

  MemoLog.Lines.Add('NFC LIGADO');
  FNFC.Ativar;
  MemoLog.Lines.Add('Aguardando tag...');
end;

procedure TForm1.OnTagDetectada(const AUID, ATechs, AConteudo: string);
begin
  MemoLog.Lines.Add('--- Tag detectada ---');
  MemoLog.Lines.Add('UID: ' + AUID);
  MemoLog.Lines.Add('Techs: ' + ATechs);
  if AConteudo <> '' then
    MemoLog.Lines.Add('Conteudo: ' + AConteudo)
  else
    MemoLog.Lines.Add('Sem conteudo NDEF.');
end;

end.
