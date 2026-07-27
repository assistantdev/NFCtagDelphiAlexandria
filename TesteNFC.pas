unit TesteNFC;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo,
  uNFC;

type
  TfrmPrincipal = class(TForm)
    btnVerifique: TButton;
    MemoLog: TMemo;
    procedure btnVerifiqueClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    NFC: TNFC;
    procedure OnTagDetectada(const AUID, ATechs, AConteudo: string);
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  if not Assigned(NFC) then
    NFC := TNFC.Create(procedure(AUID, ATechs, AConteudo: string)
    begin
      OnTagDetectada(AUID, ATechs, AConteudo);
    end);
  if NFC.Suportado and NFC.Habilitado then
    NFC.Ativar
  else
    MemoLog.Lines.Add('NFC nao disponivel ou desligado.');
end;

procedure TfrmPrincipal.FormDeactivate(Sender: TObject);
begin
  if Assigned(NFC) then
    NFC.Desativar;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NFC);
end;

procedure TfrmPrincipal.btnVerifiqueClick(Sender: TObject);
begin
  MemoLog.Lines.Clear;
  if not Assigned(NFC) then
    NFC := TNFC.Create(procedure(AUID, ATechs, AConteudo: string)
    begin
      OnTagDetectada(AUID, ATechs, AConteudo);
    end);

  if not NFC.Suportado then
  begin
    MemoLog.Lines.Add('Hardware NFC: AUSENTE');
    Exit;
  end;

  MemoLog.Lines.Add('Hardware NFC: PRESENTE');

  if not NFC.Habilitado then
  begin
    MemoLog.Lines.Add('NFC DESLIGADO - ative nas configuracoes.');
    Exit;
  end;

  MemoLog.Lines.Add('NFC LIGADO');
  NFC.Ativar;
  MemoLog.Lines.Add('Aguardando tag...');
end;

procedure TfrmPrincipal.OnTagDetectada(const AUID, ATechs, AConteudo: string);
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
