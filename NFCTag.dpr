program NFCTag;

uses
  System.StartUpCopy,
  FMX.Forms,
  TesteNFC in 'TesteNFC.pas' {Form1},
  Androidapi.JNI.NFC in 'Androidapi.JNI.NFC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
