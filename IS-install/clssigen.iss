[Setup]
  MinVersion             = 4.0,4.0
  AppName                = Client SSI Generator
  AppVersion             = 1.11
  AppVerName             = Client SSI Generator v1.11
  AppCopyright           = Copyright ©2001-2004 DK Software
  AppPublisher           = DK Software
  AppPublisherURL        = http://www.dk-soft.org/
  AppSupportURL          = mailto:devtools@narod.ru?Subject=ClientSSIGenerator
  AppUpdatesURL          = http://www.dk-soft.org/
  AllowNoIcons           = yes
  ChangesAssociations    = yes
  DisableStartupPrompt   = yes
  DefaultDirName         = {pf}\DK Software\Client SSI Generator
  DefaultGroupName       = Client SSI Generator
  OutputDir              = .
  OutputBaseFilename     = clssigen-setup-1.11
  VersionInfoVersion     = 1.11
  VersionInfoTextVersion = 1.11
  ; -- Compression
  SolidCompression       = yes
  Compression            = lzma



[Languages]
  Name: "en"; MessagesFile: compiler:Default.isl;           LicenseFile: eula-eng.rtf
  Name: "ru"; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: eula-rus.rtf

[Tasks]
  Name: desktopicon;        Description: {cm:CreateDesktopIcon};             GroupDescription: {cm:AdditionalIcons};
  Name: desktopicon\common; Description: {cm:IconsAllUsers};                 GroupDescription: {cm:AdditionalIcons}; Flags: exclusive
  Name: desktopicon\user;   Description: {cm:IconsCurUser};                  GroupDescription: {cm:AdditionalIcons}; Flags: exclusive unchecked
  Name: quicklaunchicon;    Description: {cm:CreateQuickLaunchIcon};         GroupDescription: {cm:AdditionalIcons};
  Name: associate;          Description: {cm:AssocFileExtension,Client SSI Generator,.cssip};

[Components]
;English entries
  Name: main;    Languages: en; Description: "Main Files";               Types: full compact custom; Flags: fixed
  Name: help;    Languages: en; Description: "Help Files";               Types: full
  Name: help\en; Languages: en; Description: "English";                  Types: full
  Name: help\ru; Languages: en; Description: "Russian";                  Types: full
  Name: sample;  Languages: en; Description: "Sample files";             Types: full
;Russian entries
  Name: main;    Languages: ru; Description: "Основные файлы";           Types: full compact custom; Flags: fixed
  Name: help;    Languages: ru; Description: "Файлы Справочной системы"; Types: full
  Name: help\en; Languages: ru; Description: "Английский язык";          Types: full
  Name: help\ru; Languages: ru; Description: "Русский язык";             Types: full
  Name: sample;  Languages: ru; Description: "Примеры файлов";           Types: full

[Files]
;Application files
  Source: "..\clssigen.exe";       DestDir: "{app}";              Components: main
  Source: "..\cssigen-en.chm";     DestDir: "{app}";              Components: help\en
  Source: "..\cssigen-ru.chm";     DestDir: "{app}";              Components: help\ru
;Sample content
  Source: "..\Example\bottom.ihtml";  DestDir: "{app}\Sample album"; Components: sample
  Source: "..\Example\index.html";    DestDir: "{app}\Sample album"; Components: sample
  Source: "..\Example\top.ihtml";     DestDir: "{app}\Sample album"; Components: sample

[INI]
  Filename: "{app}\clssigen.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://www.dk-soft.org/"

[Icons]
;English entries
  Name: "{group}\Client SSI Generator help (Russian)";       Languages: en; Filename: "{app}\cssigen-ru.chm"; Components: help\ru;
  Name: "{group}\Client SSI Generator help (English)";       Languages: en; Filename: "{app}\cssigen-en.chm"; Components: help\en;
;Russian entries
  Name: "{group}\Справка по Client SSI Generator (Русская)"; Languages: ru; Filename: "{app}\cssigen-ru.chm"; Components: help\ru;
  Name: "{group}\Справка по Client SSI Generator (English)"; Languages: ru; Filename: "{app}\cssigen-en.chm"; Components: help\en;
;Common entries
  Name: "{group}\{cm:UninstallProgram,Client SSI Generator}"; Filename: "{uninstallexe}";     Components: main;
  Name: "{group}\{cm:ProgramOnTheWeb,Client SSI Generator}";  Filename: "{app}\clssigen.url"; Components: main;
  Name: "{group}\Client SSI Generator";                       Filename: "{app}\clssigen.exe"; Components: main;
  Name: "{commondesktop}\Client SSI Generator";               Filename: "{app}\clssigen.exe"; Components: main; Tasks: desktopicon\common
  Name: "{userdesktop}\Client SSI Generator";                 Filename: "{app}\clssigen.exe"; Components: main; Tasks: desktopicon\user
  Name: "{code:QuickLaunch|{pf}}\Client SSI Generator";       Filename: "{app}\clssigen.exe"; Components: main; Tasks: quicklaunchicon

[Registry]
  Root: HKCR; Subkey: ".cssip";                              ValueType: string; ValueData: "clssigen.project";              Flags: uninsdeletevalue uninsdeletekeyifempty; Tasks: associate
  Root: HKCR; Subkey: "clssigen.project";                    ValueType: string; ValueData: "Client SSI Generator Project";  Flags: uninsdeletevalue uninsdeletekeyifempty; Tasks: associate
  Root: HKCR; Subkey: "clssigen.project\shell\open\command"; ValueType: string; ValueData: """{app}\clssigen.exe"" ""%1"""; Flags: uninsdeletevalue uninsdeletekeyifempty; Tasks: associate
  Root: HKCR; Subkey: "clssigen.project\DefaultIcon";        ValueType: string; ValueData: """{app}\clssigen.exe"",1";      Flags: uninsdeletevalue uninsdeletekeyifempty; Tasks: associate

[Run]
  Filename: "{app}\clssigen.exe"; Description: {cm:LaunchProgram,Client SSI Generator}; Flags: nowait postinstall skipifsilent

[UninstallDelete]
  Type: files; Name: "{app}\clssigen.url"
  Type: dirifempty; Name: "{app}"

[CustomMessages]
; English
en.IconsAllUsers=For all users
en.IconsCurUser=For the current user only
; Russian
ru.IconsAllUsers=Для всех пользователей
ru.IconsCurUser=Только для текущего пользователя

[Code]

  function QuickLaunch(Default: String): String;
  begin
    Result := ExpandConstant('{userappdata}')+'\Microsoft\Internet Explorer\Quick Launch';
  end;
