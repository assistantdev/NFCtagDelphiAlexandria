program NFCTag;

uses
  System.StartUpCopy,
  FMX.Forms,
  TesteNFC in 'TesteNFC.pas' {frmPrincipal},
  Androidapi.JNI.NFC in 'Androidapi.JNI.NFC.pas',
  uNFC in 'uNFC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
