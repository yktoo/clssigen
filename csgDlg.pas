unit csgDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TcsgBaseDialog = class(TForm)
    pMain: TPanel;
    pBottom: TPanel;
    bvBottom: TBevel;
    bOK: TButton;
    bCancel: TButton;
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
     // TNotifyEvent, изменяющий Modified в True - для использования в потомках
    procedure DlgDataChanged(Sender: TObject);
  private
     // Счётчик блокировки изменения Modified
    FUpdateLockCounter: Integer;
     // Prop storage
    FHasUpdates: Boolean;
    FOKIgnoresModified: Boolean;
    FModified: Boolean;
     // Настраивает кнопки
    procedure UpdateButtons;
     // Prop handlers
    procedure SetHasUpdates(Value: Boolean);
    procedure SetModified(Value: Boolean);
    procedure SetOKIgnoresModified(Value: Boolean);
    function  GetUpdateLocked: Boolean;
  protected
     // Вызывается по нажатию пользователем кнопки OK. В базовом классе закрывает диалог с возвратом результата mrOK
    procedure ButtonClick_OK; virtual;
     // Вызывается по нажатию пользователем кнопки Cancel. В базовом классе закрывает диалог с возвратом результата mrCancel
    procedure ButtonClick_Cancel; virtual;
     // Инициализация/финализация диалога. В базовом классе не делают ничего
    procedure InitializeDialog; virtual;
    procedure FinalizeDialog; virtual;
     // Prop handlers
     // -- В базовом классе всегда возвращает True
    function  GetDataValid: Boolean; virtual;
  public
     // Вызывает модальный показ диалога. Возвращает HasUpdates
    function Execute: Boolean;
     // Блокировка/разблокировка возможности изменить Modified
    procedure BeginUpdate;
    procedure EndUpdate;
     // Props
     // -- True, если данные, отображаемые в диалоге, корректны и диалог можно закрыть нажатием кнопки ОК
    property DataValid: Boolean read GetDataValid;
     // -- Должно присваиваться в True, если диалог изменил какие-либо данные. Значение свойства возвращается из Execute()
    property HasUpdates: Boolean read FHasUpdates write SetHasUpdates;
     // -- True, если данные, отображаемые в диалоге, изменены
    property Modified: Boolean read FModified write SetModified;
     // -- True, если разрешённость кнопки OK не зависит от значения свойства Modified. По умолчанию False
    property OKIgnoresModified: Boolean read FOKIgnoresModified write SetOKIgnoresModified;
     // -- True, если присваивания значения свойству Modified игнорируются
    property UpdateLocked: Boolean read GetUpdateLocked;
  end;

implementation
{$R *.dfm}
uses ConsVarsTypes;

  procedure TcsgBaseDialog.bCancelClick(Sender: TObject);
  begin
    ButtonClick_Cancel;
  end;

  procedure TcsgBaseDialog.BeginUpdate;
  begin
    Inc(FUpdateLockCounter);
  end;

  procedure TcsgBaseDialog.bOKClick(Sender: TObject);
  begin
    ButtonClick_OK;
  end;

  procedure TcsgBaseDialog.ButtonClick_Cancel;
  begin
    ModalResult := mrCancel;
  end;

  procedure TcsgBaseDialog.ButtonClick_OK;
  begin
    ModalResult := mrOK;
  end;

  procedure TcsgBaseDialog.DlgDataChanged(Sender: TObject);
  begin
    Modified := True;
  end;

  procedure TcsgBaseDialog.EndUpdate;
  begin
    if FUpdateLockCounter>0 then Dec(FUpdateLockCounter);
    if FUpdateLockCounter=0 then UpdateButtons;
  end;

  function TcsgBaseDialog.Execute: Boolean;
  begin
    try
      BeginUpdate;
      try
        InitializeDialog;
      finally
        EndUpdate;
      end;
      ShowModal;
      Result := HasUpdates;
    finally
      FinalizeDialog;
    end;
  end;

  procedure TcsgBaseDialog.FinalizeDialog;
  begin
    { does nothing }
  end;

  function TcsgBaseDialog.GetDataValid: Boolean;
  begin
    Result := True;
  end;

  function TcsgBaseDialog.GetUpdateLocked: Boolean;
  begin
    Result := FUpdateLockCounter>0;
  end;

  procedure TcsgBaseDialog.InitializeDialog;
  begin
    { does nothing }
  end;

  procedure TcsgBaseDialog.SetHasUpdates(Value: Boolean);
  begin
    if FHasUpdates<>Value then begin
      FHasUpdates := Value;
      UpdateButtons;
    end;
  end;

  procedure TcsgBaseDialog.SetModified(Value: Boolean);
  begin
    if FUpdateLockCounter>0 then Exit;
    FModified := Value;
    UpdateButtons;
  end;

  procedure TcsgBaseDialog.SetOKIgnoresModified(Value: Boolean);
  begin
    if FOKIgnoresModified<>Value then begin
      FOKIgnoresModified := Value;
      UpdateButtons;
    end;
  end;

  procedure TcsgBaseDialog.UpdateButtons;
  begin
    if FUpdateLockCounter>0 then Exit;
    bOK.Enabled := (OKIgnoresModified or Modified) and DataValid;
    bCancel.Caption := iif(HasUpdates, 'Close', 'Cancel');
  end;

end.
