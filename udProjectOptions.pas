unit udProjectOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ConsVarsTypes,
  csgDlg, StdCtrls, ExtCtrls;

type
  TdProjectOptions = class(TcsgBaseDialog)
    gbBaseFolder: TGroupBox;
    eBaseFolder: TEdit;
    bBrowseBaseFolder: TButton;
    gbOutFolder: TGroupBox;
    eOutFolder: TEdit;
    bBrowseOutFolder: TButton;
    cbRunUponCompletion: TCheckBox;
    eRunUponCompletion: TEdit;
    lSSIExtensions: TLabel;
    mSSIExtensions: TMemo;
    procedure cbRunUponCompletionClick(Sender: TObject);
    procedure bBrowseBaseFolderClick(Sender: TObject);
    procedure bBrowseOutFolderClick(Sender: TObject);
  private
     // Проект, чьи свойства редактируем
    FProject: TCSGProject;
     // Разрешает или запрещает eRunUponCompletion в зависимости от состояния cbRunUponCompletion
    procedure UpdateRunOnCompletionEdit;
  protected
    procedure ButtonClick_OK; override;
    procedure InitializeDialog; override;
    function  GetDataValid: Boolean; override;
  end;

  function EditProjectOptions(AProject: TCSGProject): Boolean;

implementation
{$R *.dfm}
uses FileCtrl;

  function EditProjectOptions(AProject: TCSGProject): Boolean;
  begin
    with TdProjectOptions.Create(Application) do
      try
        FProject := AProject;
        Result := Execute;
      finally
        Free;
      end;
  end;

   //===================================================================================================================
   // TdProjectOptions
   //===================================================================================================================

  procedure TdProjectOptions.bBrowseBaseFolderClick(Sender: TObject);
  var s: String;
  begin
    s := eBaseFolder.Text;
    if s='' then s := sLastBasePath;
    if SelectDirectory('Select base HTML folder', '', s) then eBaseFolder.Text := s;
  end;

  procedure TdProjectOptions.bBrowseOutFolderClick(Sender: TObject);
  var s: String;
  begin
    s := eOutFolder.Text;
    if SelectDirectory('Select output folder', '', s) then eOutFolder.Text := s;
  end;

  procedure TdProjectOptions.ButtonClick_OK;
  begin
     // Сохраняем опции в проект
    FProject.BasePath      := eBaseFolder.Text;
    FProject.OutputPath    := eOutFolder.Text;
    FProject.Autorun       := cbRunUponCompletion.Checked;
    FProject.AutorunFile   := eRunUponCompletion.Text;
    FProject.SSIExtensions := mSSIExtensions.Lines;
    inherited ButtonClick_OK;
  end;

  procedure TdProjectOptions.cbRunUponCompletionClick(Sender: TObject);
  begin
    UpdateRunOnCompletionEdit;
    Modified := True;
  end;

  function TdProjectOptions.GetDataValid: Boolean;
  begin
    Result :=
      (Trim(eBaseFolder.Text)<>'') and
      (Trim(eOutFolder.Text)<>'') and
      (not cbRunUponCompletion.Checked or (Trim(eRunUponCompletion.Text)<>''));
  end;

  procedure TdProjectOptions.InitializeDialog;
  begin
    inherited InitializeDialog;
     // Загружаем данные в контролы
    eBaseFolder.Text            := ExcludeTrailingPathDelimiter(FProject.BasePath);
    eOutFolder.Text             := ExcludeTrailingPathDelimiter(FProject.OutputPath);
    cbRunUponCompletion.Checked := FProject.Autorun;
    eRunUponCompletion.Text     := FProject.AutorunFile;
    UpdateRunOnCompletionEdit;
    mSSIExtensions.Lines.Assign(FProject.SSIExtensions); 
  end;

  procedure TdProjectOptions.UpdateRunOnCompletionEdit;
  begin
    EnableWndCtl(eRunUponCompletion, cbRunUponCompletion.Checked);
  end;

end.
