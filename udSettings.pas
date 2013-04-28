unit udSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  csgDlg, Menus, ActnList, VirtualTrees, StdCtrls, ExtCtrls;

type
  TdSettings = class(TcsgBaseDialog)
    lFileAssoc: TLabel;
    alMain: TActionList;
    aAssociationDelete: TAction;
    aAssociationEdit: TAction;
    pmAssociations: TPopupMenu;
    ipmDeleteFA: TMenuItem;
    ipmEditFA: TMenuItem;
    ipmSep: TMenuItem;
    tvAssociations: TVirtualStringTree;
    odApp: TOpenDialog;
    procedure aaAssociationDelete(Sender: TObject);
    procedure aaAssociationEdit(Sender: TObject);
    procedure tvAssociationsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvAssociationsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure tvAssociationsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure tvAssociationsNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure tvAssociationsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvAssociationsFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
  private
     // Проверяет наличие пустой строки в конце списка асоциаций
    procedure CheckLastFreeLine;
     // Настраивает доступность Actions
    procedure EnableActions;
  protected
    procedure InitializeDialog; override;
    procedure ButtonClick_OK; override;
  end;

  function EditSettings: Boolean;

implementation
{$R *.DFM}
uses ConsVarsTypes;

  function EditSettings: Boolean;
  begin
    with TdSettings.Create(Application) do
      try
        Result := Execute;
      finally
        Free;
      end;
  end;

   //===================================================================================================================
   // TdSettings
   //===================================================================================================================

  procedure TdSettings.aaAssociationDelete(Sender: TObject);
  begin
    with tvAssociations do DeleteNode(FocusedNode);
    Modified := True;
  end;

  procedure TdSettings.aaAssociationEdit(Sender: TObject);
  begin
    with tvAssociations do EditNode(FocusedNode, FocusedColumn);
  end;

  procedure TdSettings.ButtonClick_OK;
  var
    n: PVirtualNode;
    p: PAnsiString;
  begin
     // Переписываем ассоциации из tvAssociations в FileAssociations
    FileAssociations.Clear;
    n := tvAssociations.GetFirst;
    while n<>nil do begin
      p := PPAnsiString(tvAssociations.GetNodeData(n))^;
      if p<>nil then FileAssociations.Add(p^);
      n := tvAssociations.GetNextSibling(n);
    end;
    inherited ButtonClick_OK;
  end;

  procedure TdSettings.CheckLastFreeLine;
  var n: PVirtualNode;
  begin
    n := tvAssociations.GetLast;
    if (n=nil) or (PPAnsiString(tvAssociations.GetNodeData(n))^<>nil) then tvAssociations.AddChild(nil, nil);
  end;

  procedure TdSettings.EnableActions;
  var n: PVirtualNode;
  begin
    n := tvAssociations.FocusedNode;
    aAssociationDelete.Enabled := (n<>nil) and (PPAnsiString(tvAssociations.GetNodeData(n))^<>nil);
    aAssociationEdit.Enabled   := n<>nil;
  end;

  procedure TdSettings.InitializeDialog;
  var
    i: Integer;
    p: PAnsiString;
  begin
    inherited InitializeDialog;
     // Переписываем ассоциации файлов в дерево
    tvAssociations.NodeDataSize := SizeOf(Pointer); 
    for i := 0 to FileAssociations.Count-1 do begin
      New(p);
      p^ := FileAssociations[i];
      tvAssociations.AddChild(nil, p);
    end;
     // Добавляем пустую строку
    CheckLastFreeLine;
  end;

  procedure TdSettings.tvAssociationsChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
  var p: PAnsiString;
  begin
    p := PPAnsiString(Sender.GetNodeData(Node))^;
    if p=nil then odApp.FileName := '' else odApp.FileName := Copy(p^, Pos('=', p^)+1, MaxInt);
    if odApp.Execute then tvAssociations.Text[Node, 1] := odApp.FileName;
  end;

  procedure TdSettings.tvAssociationsFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
  begin
    EnableActions;
  end;

  procedure TdSettings.tvAssociationsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
  var p: PAnsiString;
  begin
    p := PPAnsiString(Sender.GetNodeData(Node))^;
    if p<>nil then Dispose(p);
  end;

  procedure TdSettings.tvAssociationsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  var
    p: PAnsiString;
    i: Integer;
  begin
    p := PPAnsiString(Sender.GetNodeData(Node))^;
    if p<>nil then begin
      i := Pos('=', p^);
      if i>0 then
        case Column of
          0: CellText := Copy(p^, 1, i-1);
          1: CellText := Copy(p^, i+1, MaxInt);
        end;
    end;
  end;

  procedure TdSettings.tvAssociationsInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  begin
     // Рисуем кнопку у пути к приложению
    Node.CheckType := ctButton;
  end;

  procedure TdSettings.tvAssociationsNewText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
  var
    p: PPAnsiString;
    s1, s2: String;
    i: Integer;
  begin
     // Создаём данные узла, если надо
    p := Sender.GetNodeData(Node);
    if p^=nil then New(p^);
     // Выделяем маску/приложение
    i := Pos('=', p^^);
    if i>0 then begin
      s1 := Copy(p^^, 1, i-1);
      s2 := Copy(p^^, i+1, MaxInt);
    end else begin
      s1 := '*.*';
      s2 := '';
    end;
     // Составляем новую строку данных
    case Column of
      0: p^^ := NewText+'='+s2;
      1: p^^ := s1+'='+NewText;
    end;
     // Добавляем пустую строку
    CheckLastFreeLine;
    Modified := True;
  end;

end.

