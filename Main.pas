unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, XPMan, VirtualShellUtilities, ConsVarsTypes, GraphicEx,
  VirtualTrees, Menus, TB2Item, TBX, TB2MRU, TBXExtItems, Placemnt,
  ImgList, ActnList, TBXDkPanels, TB2Dock, TB2Toolbar, ComCtrls,
  TBXStatusBars, VirtualExplorerTree, ExtCtrls;

type
  TfMain = class(TForm)
    aFileEditFile: TAction;
    aFileExit: TAction;
    aFileNew: TAction;
    aFileOpen: TAction;
    aFileSave: TAction;
    aFileSaveAs: TAction;
    aFileSettings: TAction;
    aFileUpFolder: TAction;
    aHelpAbout: TAction;
    aHelpContents: TAction;
    aHelpWebsite: TAction;
    alMain: TActionList;
    aProjectOptions: TAction;
    aProjectRun: TAction;
    aViewRefresh: TAction;
    bFileEditFile: TTBXItem;
    bFileExit: TTBXItem;
    bFileNew: TTBXItem;
    bFileOpen: TTBXSubmenuItem;
    bFileSave: TTBXItem;
    bFileSaveAs: TTBXItem;
    bFileUpFolder: TTBXItem;
    bHelpAbout: TTBXItem;
    bHelpContents: TTBXItem;
    bOpenMRU: TTBXMRUListItem;
    bProjectRun: TTBXItem;
    bViewRefresh: TTBXItem;
    dkBottom: TTBXDock;
    dkLeft: TTBXDock;
    dkRight: TTBXDock;
    dkTop: TTBXDock;
    dpFolders: TTBXDockablePanel;
    dpOutput: TTBXDockablePanel;
    dpPreview: TTBXDockablePanel;
    fsMain: TFormStorage;
    iAbout: TTBXItem;
    iFileEditFile: TTBXItem;
    iFileExit: TTBXItem;
    iFileMRU: TTBXMRUListItem;
    iFileSettings: TTBXItem;
    iFileUpFolder: TTBXItem;
    iHelpContents: TTBXItem;
    iHelpSep: TTBXSeparatorItem;
    ilMain: TTBImageList;
    iNew: TTBXItem;
    iOpen: TTBXItem;
    ipmOpenFile: TTBXItem;
    iPreview: TImage;
    iProjectOptions: TTBXItem;
    iProjectRun: TTBXItem;
    iSave: TTBXItem;
    iSaveAs: TTBXItem;
    iSepFileEditFile: TTBXSeparatorItem;
    iSepFileExit: TTBXSeparatorItem;
    iSepFileMRU: TTBXSeparatorItem;
    iSepProjectOptions: TTBXSeparatorItem;
    iViewRefresh: TTBXItem;
    iViewRefreshSep: TTBXSeparatorItem;
    iViewToggleOutput: TTBXVisibilityToggleItem;
    iViewTogglePreview: TTBXVisibilityToggleItem;
    iViewToggleStatusbar: TTBXVisibilityToggleItem;
    iViewToggleToolbar: TTBXVisibilityToggleItem;
    iWebsite: TTBXItem;
    mdkBottom: TTBXMultiDock;
    mdkLeft: TTBXMultiDock;
    mdkRight: TTBXMultiDock;
    mdkTop: TTBXMultiDock;
    mruOpen: TTBXMRUList;
    pbMain: TProgressBar;
    pmFiles: TTBXPopupMenu;
    pmView: TTBXPopupMenu;
    smFile: TTBXSubmenuItem;
    smHelp: TTBXSubmenuItem;
    smProject: TTBXSubmenuItem;
    smView: TTBXSubmenuItem;
    tbMain: TTBXToolbar;
    tbMenu: TTBXToolbar;
    tbSepFileExit: TTBXSeparatorItem;
    tbSepFileUpFolder: TTBXSeparatorItem;
    tbSepHelpAbout: TTBXSeparatorItem;
    tbSepProjectRun: TTBXSeparatorItem;
    tbSepViewRefresh: TTBXSeparatorItem;
    TheStatusBar: TTBXStatusBar;
    tvFiles: TVirtualExplorerTree;
    tvFolders: TVirtualExplorerTree;
    tvLog: TVirtualStringTree;
    procedure aaFileNew(Sender: TObject);
    procedure aaFileOpen(Sender: TObject);
    procedure aaFileSave(Sender: TObject);
    procedure aaFileSaveAs(Sender: TObject);
    procedure aaFileExit(Sender: TObject);
    procedure aaFileSettings(Sender: TObject);
    procedure aaFileEditFile(Sender: TObject);
    procedure aaProjectOptions(Sender: TObject);
    procedure aaProjectRun(Sender: TObject);
    procedure aaViewRefresh(Sender: TObject);
    procedure aaHelpContents(Sender: TObject);
    procedure aaHelpWebsite(Sender: TObject);
    procedure aaHelpAbout(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure fsMainSavePlacement(Sender: TObject);
    procedure fsMainRestorePlacement(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mruOpenClick(Sender: TObject; const Filename: String);
    procedure tvFoldersInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure tvFoldersChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvFoldersFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvFoldersChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvFilesChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvFilesDblClick(Sender: TObject);
    procedure tvLogFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tvLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure tvFilesFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure dpPreviewVisibleChanged(Sender: TObject);
    procedure aaFileUpFolder(Sender: TObject);
  private
     // Текущий проект Client SSI Generator
    FCSGProject: TCSGProject;
     // Проверяет, что файл проекта сохранён
    function  CheckSave: Boolean;
     // Настраивает Caption формы и приложения
    procedure UpdateCaption;
     // Разрешает/запрещает Actions
    procedure EnableActions;
     // Настраивает информацию, отображаему на StatusBar
    procedure UpdateStatusbar;
     // Загружает дерево папок, начиная с текущего базового каталога
    procedure ReloadTree;
     // Настраивает отметки в дереве папок
    procedure UpdateTreeChecks;
     // Настраивает отметки в списке файлов
    procedure UpdateFileChecks;
     // Обновляет окно предпросмотра изображения
    procedure UpdatePreview;
     // Загрузка файла проекта
    procedure DoLoad(const sFileName: String);
     // Выполняет файл Namespace: если есть подходящая ассоциация - то по ней, иначе по умолчанию
    procedure DoExecFile(Namespace: TNamespace);
     // Application events
    procedure AppHint(Sender: TObject);
     // FCSGProject events
    procedure Project_AddLog(Sender: TObject; const sLogRec: String);
    procedure Project_FileListChanged(Sender: TObject);
    procedure Project_GenerationProgress(Sender: TObject; dProgress: Double);
    procedure Project_StatusChanged(Sender: TObject);
  end;

var
  fMain: TfMain;

implementation
{$R *.dfm}
uses
  ShellAPI, Masks, ChmHlp,
  udAbout, udSettings, udProjectOptions, Registry;

   //===================================================================================================================
   //  TfMain
   //===================================================================================================================

  procedure TfMain.aaFileEditFile(Sender: TObject);
  var
    n: PVirtualNode;
    NS: TNamespace;
  begin
    n := tvFiles.FocusedNode;
    if (n<>nil) and tvFiles.ValidateNamespace(n, NS) then
       // При двойном клике на папке заходим в папку
      if NS.Folder then
        tvFolders.BrowseTo(NS.NameParseAddress, False, True, False, False)
       // При двойном клике на файле выполняем файл
      else
        DoExecFile(NS);
  end;

  procedure TfMain.aaFileExit(Sender: TObject);
  begin
    Close;
  end;

  procedure TfMain.aaFileNew(Sender: TObject);
  begin
    if CheckSave then begin
      tvLog.Clear;
      FCSGProject.MakeNew;
      ReloadTree;
      UpdateStatusbar;
    end;
  end;

  procedure TfMain.aaFileOpen(Sender: TObject);
  begin
    with TOpenDialog.Create(Self) do
      try
        DefaultExt := SDefaultExt;
        Filter     := SCSGFileFilter;
        Options    := [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing];
        Title      := SDlgTitleOpenProject;
        if Execute then DoLoad(FileName);
      finally
        Free;
      end
  end;

  procedure TfMain.aaFileSave(Sender: TObject);
  begin
    with FCSGProject do
      if FileName='' then aFileSaveAs.Execute else SaveToFile(FileName);
  end;

  procedure TfMain.aaFileSaveAs(Sender: TObject);
  begin
    with TSaveDialog.Create(Self) do
      try
        DefaultExt := SDefaultExt;
        Filter     := SCSGFileFilter;
        Options    := [ofHideReadOnly, ofPathMustExist, ofOverwritePrompt, ofEnableSizing];
        Title      := SDlgTitleSaveProject;
        FileName   := FCSGProject.FileName;
        if Execute then begin
          FCSGProject.SaveToFile(FileName);
          mruOpen.Add(FileName);
        end;
      finally
        Free;
      end
  end;

  procedure TfMain.aaFileSettings(Sender: TObject);
  begin
    EditSettings;
  end;

  procedure TfMain.aaFileUpFolder(Sender: TObject);
  begin
    ActivateVTNode(tvFolders, tvFolders.FocusedNode.Parent);
  end;

  procedure TfMain.aaHelpAbout(Sender: TObject);
  begin
    ShowAbout;
  end;

  procedure TfMain.aaHelpContents(Sender: TObject);
  begin
    HtmlHelpShowContents;
  end;

  procedure TfMain.aaHelpWebsite(Sender: TObject);
  begin
    ShellExecute(Handle, SOpOpen, PChar(SInternetWebsite), nil, nil, SW_SHOWNORMAL);
  end;

  procedure TfMain.aaProjectOptions(Sender: TObject);
  begin
    if EditProjectOptions(FCSGProject) then begin
      if not AnsiSameText(FCSGProject.BasePath, tvFolders.RootFolderCustomPath) then ReloadTree;
      EnableActions;
    end;
  end;

  procedure TfMain.aaProjectRun(Sender: TObject);
  begin
    if not FCSGProject.CheckGenerationPossible then Exit;
    tvLog.Clear;
    with pbMain do begin
      Position := 0;
      Show;
      try
        FCSGProject.Generate;
      finally
        Hide;
      end;
    end;
  end;

  procedure TfMain.aaViewRefresh(Sender: TObject);
  begin
     // Обновляем список файлов
    FCSGProject.ValidateSelFiles;
     // Перечитываем дерево
    ReloadTree;
  end;

  procedure TfMain.AppHint(Sender: TObject);
  begin
    TheStatusBar.Panels[0].Caption := Application.Hint;
  end;

  function TfMain.CheckSave: Boolean;
  begin
    Result := not FCSGProject.Modified;
    if not Result then
      case Application.MessageBox(PChar(Format(SFileNotSavedMsg, [FCSGProject.DisplayFileName])), SDlgTitleConfirm, MB_YESNOCANCEL or MB_ICONEXCLAMATION) of
        IDYES: begin
          aFileSave.Execute;
          Result := not FCSGProject.Modified;
        end;
        IDNO:  Result := True;
        else   Result := False;
      end;
  end;

  procedure TfMain.DoExecFile(Namespace: TNamespace);
  var
    i, iCode: Integer;
    bMatches: Boolean;
    sParams: String;
  begin
     // Ищем подходящую ассоциацию
    bMatches := False;
    for i := 0 to FileAssociations.Count-1 do begin
      with TMask.Create(FileAssociations.Names[i]) do
        try
          bMatches := Matches(Namespace.NameParseAddressInFolder);
        finally
          Free;
        end;
       // Если нашли - запускаем
      if bMatches then begin
         // Берём в кавычки и преобразуем WideString в AnsiString
        sParams := '"'+Namespace.NameParseAddress+'"';
        iCode := ShellExecute(Handle, nil, PChar(FileAssociations.ValueFromIndex[i]), PChar(sParams), nil, SW_SHOWNORMAL);
        if iCode<=32 then Error(SysErrorMessage(iCode));
        Break;
      end;
    end;
     // Если не нашли - выполняем действие по умолчанию
    if not bMatches then Namespace.ShellExecuteNamespace('', '', False, False); 
  end;

  procedure TfMain.DoLoad(const sFileName: String);
  begin
    if CheckSave then begin
      FCSGProject.LoadFromFile(sFileName);
      mruOpen.Add(sFileName);
      ReloadTree;
    end;
  end;

  procedure TfMain.dpPreviewVisibleChanged(Sender: TObject);
  begin
    UpdatePreview;
  end;

  procedure TfMain.EnableActions;
  begin
    if csDestroying in ComponentState then Exit;
    aFileEditFile.Enabled := tvFiles.FocusedNode<>nil;
    aFileUpFolder.Enabled := tvFolders.NodeParent[tvFolders.FocusedNode]<>nil;
    aProjectRun.Enabled   := (FCSGProject.BasePath<>'') and (FCSGProject.OutputPath<>'') and (FCSGProject.SelFilesCount>0);
  end;

  procedure TfMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  begin
    CanClose := CheckSave;
  end;

  procedure TfMain.FormCreate(Sender: TObject);
  begin
     // Узлы дерева папок будут хранить TStringList со списком файлов этой папки
    tvFolders.NodeDataSize := SizeOf(TObject);
     // Создаём и настраиваем проект
    FCSGProject := TCSGProject.Create;
    with FCSGProject do begin
      OnAddLog             := Project_AddLog;
      OnFileListChanged    := Project_FileListChanged;
      OnGenerationProgress := Project_GenerationProgress;
      OnStatusChanged      := Project_StatusChanged;
    end;
    tvLog.NodeDataSize := SizeOf(PAnsiString);
    Application.OnHint := AppHint;
     // Подбираем Help-файл по языку пользователя
    Application.HelpFile := iif(GetUserDefaultLangID=$419, SHelpFileRU, SHelpFileEN);
  end;

  procedure TfMain.FormDestroy(Sender: TObject);
  begin
    FCSGProject.Free;
  end;

  procedure TfMain.fsMainRestorePlacement(Sender: TObject);
  begin
    with fsMain.RegIniFile do begin
      sLastBasePath := ReadString(SRegPreferences, 'LastBasePath', 'C:\');
      if KeyExists(SRegFileAssociations) then begin
        FileAssociations.Clear;
        ReadSectionValues(SRegFileAssociations, FileAssociations);
      end;
    end;
    TBRegLoadPositions(Self, HKEY_CURRENT_USER, fsMain.IniFileName);
    mruOpen.LoadFromRegIni(fsMain.RegIniFile, SRegOpenMRU);
     // Создаём новый или открываем переданный в командной строке файл
    if ParamCount=0 then aFileNew.Execute else DoLoad(ParamStr(1));
  end;

  procedure TfMain.fsMainSavePlacement(Sender: TObject);
  var i: Integer;
  begin
    with fsMain.RegIniFile do begin
      WriteString (SRegPreferences, 'LastBasePath', sLastBasePath);
      EraseSection(SRegFileAssociations);
      for i := 0 to FileAssociations.Count-1 do WriteString(SRegFileAssociations, FileAssociations.Names[i], FileAssociations.ValueFromIndex[i]);
    end;
    TBRegSavePositions(Self, HKEY_CURRENT_USER, fsMain.IniFileName);
    mruOpen.SaveToRegIni(fsMain.RegIniFile, SRegOpenMRU);
  end;

  procedure TfMain.mruOpenClick(Sender: TObject; const Filename: String);
  begin
    DoLoad(Filename);
  end;

  procedure TfMain.Project_AddLog(Sender: TObject; const sLogRec: String);
  var p: PAnsiString;
  begin
    New(p);
    p^ := sLogRec;
    tvLog.ScrollIntoView(tvLog.AddChild(nil, p), False, False);
    tvLog.Update;
  end;

  procedure TfMain.Project_FileListChanged(Sender: TObject);
  begin
    UpdateStatusbar;
  end;

  procedure TfMain.Project_GenerationProgress(Sender: TObject; dProgress: Double);
  begin
    pbMain.Position := Trunc(dProgress*1000);
  end;

  procedure TfMain.Project_StatusChanged(Sender: TObject);
  begin
    UpdateCaption;
    EnableActions;
  end;

  procedure TfMain.ReloadTree;
  begin
    tvFolders.BeginUpdate;
    try
       // Если базовая папка существует - загружаем папки
      if (FCSGProject.BasePath<>'') and DirectoryExists(FCSGProject.BasePath) then begin
        tvFolders.RootFolderCustomPath := FCSGProject.BasePath;
        tvFolders.Active := True;
        tvFolders.InitAllNodes;
        ActivateVTNode(tvFolders, tvFolders.GetFirst);
       // Иначе выключаем деревья
      end else
        tvFolders.Active := False;
       // Настраиваем птицы 
      UpdateTreeChecks;
    finally
      tvFolders.EndUpdate;
    end;
    EnableActions;
  end;

  procedure TfMain.tvFilesChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
  var
    NS: TNamespace;
    sPath: String;
  begin
    if tsUpdating in Sender.TreeStates then Exit;
    if tvFiles.ValidateNamespace(Node, NS) then begin
      sPath := NS.NameParseAddress;
       // Папка
      if NS.Folder then
        if Node.CheckState=csCheckedNormal then FCSGProject.FolderAddSelFilesAbsolute(sPath) else FCSGProject.FolderRemoveSelFilesAbsolute(sPath)
       // Файл
      else
        if Node.CheckState=csCheckedNormal then FCSGProject.AddSelFileAbsolute(sPath) else FCSGProject.RemoveSelFileAbsolute(sPath);
      UpdateTreeChecks;
    end;
  end;

  procedure TfMain.tvFilesDblClick(Sender: TObject);
  begin
    aFileEditFile.Execute;
  end;

  procedure TfMain.tvFilesFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
  begin
    UpdatePreview;
    EnableActions;
  end;

  procedure TfMain.tvFoldersChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
  begin
    tvFiles.BeginUpdate;
    try
      tvFiles.RootFolderCustomPath := tvFolders.SelectedPath;
      tvFiles.Active := tvFiles.RootFolderCustomPath<>'';
      UpdateFileChecks;
    finally
      tvFiles.EndUpdate;
    end;
    EnableActions;
  end;

  procedure TfMain.tvFoldersChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
  var
    NS: TNamespace;
    sPath: String;
  begin
    if tsUpdating in Sender.TreeStates then Exit;
    if tvFiles.ValidateNamespace(Node, NS) then begin
      sPath := NS.NameParseAddress;
      if Node.CheckState=csCheckedNormal then FCSGProject.FolderAddSelFilesAbsolute(sPath) else FCSGProject.FolderRemoveSelFilesAbsolute(sPath);
      UpdateTreeChecks;
      UpdateFileChecks;
    end;
  end;

  procedure TfMain.tvFoldersFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
  begin
     // Уничтожаем список файлов узла
    PStringList(Sender.GetNodeData(Node))^.Free;
  end;

  procedure TfMain.tvFoldersInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  var
    p: PStringList;
    NS: TNamespace;

    procedure LoadNodeFiles;
    var
      sr: TSearchRec;
      iRes: Integer;
      sPath: String;
    begin
       // Создаём список файлов в узле (пути - относительно базовой папки)
      p^ := TStringList.Create;
      sPath := IncludeTrailingPathDelimiter(NS.NameParseAddress);
       // Цикл по файлам папки
      iRes := FindFirst(sPath+'*.*', faAnyFile, sr);
      Delete(sPath, 1, Length(FCSGProject.BasePath));
      try
        while iRes=0 do begin
          if sr.Attr and faDirectory=0 then p^.Add(sPath+sr.Name);
          iRes := FindNext(sr);
        end;
      finally
        FindClose(sr);
      end;
    end;

  begin
    Node.CheckType := ctTriStateCheckBox;
     // Читаем список файлов папки
    p := Sender.GetNodeData(Node);
    if tvFolders.ValidateNamespace(Node, NS) then LoadNodeFiles;
  end;

  procedure TfMain.tvLogFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
  begin
    Dispose(PPAnsiString(Sender.GetNodeData(Node))^);
  end;

  procedure TfMain.tvLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  begin
    CellText := PPAnsiString(Sender.GetNodeData(Node))^^;
  end;

  procedure TfMain.UpdateCaption;
  const asMod: Array[Boolean] of String[1] = ('', '*');
  begin
    Caption := Format('[%s%s] - %s', [FCSGProject.DisplayFileName, asMod[FCSGProject.Modified], SAppTitle]);
    Application.Title := Caption;
  end;

  procedure TfMain.UpdateFileChecks;
  var
    n: PVirtualNode;
    NS: TNamespace;
    cs: TCheckState;
    ct: TCheckType;

    procedure FindFolderCheckState;
    var
      nFolder: PVirtualNode;
      NSFolder: TNamespace;
    begin
       // Ищем соответствующую папку в дереве tvFolders (среди детей текущего узла)
      nFolder := tvFolders.FocusedNode;
      if nFolder<>nil then begin
        nFolder := tvFolders.GetFirstChild(nFolder);
        while nFolder<>nil do begin
           // Если нашли - копируем с неё птицу
          if tvFolders.ValidateNamespace(nFolder, NSFolder) and
             AnsiSameText(NS.NameParseAddressInFolder, NSFolder.NameParseAddressInFolder) then begin
            ct := nFolder.CheckType;
            cs := nFolder.CheckState;
            Break;
          end;
          nFolder := tvFolders.GetNextSibling(nFolder);
        end;
      end;
    end;

    procedure FindFileCheckState;
    begin
      ct := ctCheckBox;
       // Если файл присутствует в списке выбранных - птица есть, иначе нет
      if FCSGProject.IndexOfSelFile(FCSGProject.AbsPathToRelative(NS.NameParseAddress))<0 then cs := csUncheckedNormal else cs := csCheckedNormal;
    end;

  begin
    tvFiles.BeginUpdate;
    try
       // Цикл по всем элементам списка
      n := tvFiles.GetFirst;
      while n<>nil do begin
        cs := csUncheckedNormal;
        ct := ctNone;
        if tvFiles.ValidateNamespace(n, NS) then
          if NS.Folder then FindFolderCheckState else FindFileCheckState;
        tvFiles.CheckType[n]  := ct;
        tvFiles.CheckState[n] := cs;
        n := tvFiles.GetNext(n);
      end;
    finally
      tvFiles.EndUpdate;
    end;
  end;

  procedure TfMain.UpdatePreview;
  var
    n: PVirtualNode;
    NS: TNamespace;
  begin
    NS := nil;
    n := tvFiles.FocusedNode;
    if dpPreview.Visible and
       (n<>nil) and
       tvFiles.ValidateNamespace(n, NS) and
       not NS.Folder and
       (FileFormatList.GraphicFromExtension(ExtractFileExt(NS.NameParseAddress))<>nil) then
      iPreview.Picture.LoadFromFile(NS.NameParseAddress)
    else
      iPreview.Picture := nil;
  end;

  procedure TfMain.UpdateStatusbar;
  begin
    TheStatusBar.Panels[2].Caption := Format('%d files', [FCSGProject.SelFilesCount]);
  end;

  procedure TfMain.UpdateTreeChecks;
  var n: PVirtualNode;

    procedure DoSync(n: PVirtualNode);
    var
      nChild: PVirtualNode;
      iChecked, iMixed, iUnchecked, i: Integer;
      FileList: TStringList;
      cs: TCheckState;
    begin
      iChecked   := 0;
      iMixed     := 0;
      iUnchecked := 0;
       // Сначала отрабатываем детей узла
      nChild := tvFolders.GetFirstChild(n);
      while nChild<>nil do begin
         // Устанавливаем птицу у узла
        DoSync(nChild);
         // Подсчитываем количество разных птиц
        if nChild.CheckType=ctTriStateCheckBox then
          case nChild.CheckState of
            csCheckedNormal:   Inc(iChecked);
            csMixedNormal:     Inc(iMixed);
            csUncheckedNormal: Inc(iUnchecked);
          end;
        nChild := tvFolders.GetNextSibling(nChild);
      end;
       // Если ситуация неясна, также проверяем список файлов
      if (iMixed=0) and ((iChecked=0) or (iUnchecked=0)) then begin
        FileList := PStringList(tvFolders.GetNodeData(n))^;
        for i := 0 to FileList.Count-1 do begin
          if FCSGProject.IndexOfSelFile(FileList[i])<0 then Inc(iUnchecked) else Inc(iChecked);
          if (iUnchecked>0) and (iChecked>0) then Break;
        end;
      end;
       // Настраиваем сам узел
       // -- Если детей с птицами у узла нет - удаляем птицу и у узла
      if iChecked+iMixed+iUnchecked=0 then
        tvFolders.CheckType[n] := ctNone
       // -- Иначе определяем, какую птицу ставить 
      else begin
        tvFolders.CheckType[n] := ctTriStateCheckBox;
        if (iMixed>0) or ((iChecked>0) and (iUnchecked>0)) then cs := csMixedNormal
        else if iChecked>0 then                                 cs := csCheckedNormal
        else                                                    cs := csUncheckedNormal;
        tvFolders.CheckState[n] := cs;
      end;
    end;

  begin
    n := tvFolders.GetFirst;
    if n<>nil then begin
      tvFolders.BeginUpdate;
      try
        DoSync(n);
      finally
        tvFolders.EndUpdate;
      end;
    end;
  end;

end.
