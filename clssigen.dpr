program clssigen;

uses
  Forms,
  Main in 'Main.pas' {fMain},
  udAbout in 'udAbout.pas' {dAbout},
  udSettings in 'udSettings.pas' {dSettings},
  ConsVarsTypes in 'ConsVarsTypes.pas',
  csgDlg in 'csgDlg.pas' {csgBaseDialog},
  udProjectOptions in 'udProjectOptions.pas' {dProjectOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
