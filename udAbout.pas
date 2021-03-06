unit udAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls;

type
  TdAbout = class(TForm)
    iMain: TImage;
    lTitle: TLabel;
    lVersion: TLabel;
    lEmailTitle: TLabel;
    lEmail: TLabel;
    lWebsiteTitle: TLabel;
    lWebsite: TLabel;
    lOK: TLabel;
    procedure lEmailClick(Sender: TObject);
    procedure lOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lWebsiteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ApplyWindowRgn;
    procedure Fadeout;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
  end;

  procedure ShowAbout;

implementation
{$R *.dfm}
uses ShellAPI, ConsVarsTypes;

const
  RSolid: TRect = (Left: 29; Top: 0; Right: 294; Bottom: 191); // ������������� �������� ������� ��������
  CTransp = clYellow;                                          // ���������� ����

  procedure ShowAbout;
  begin
    with TdAbout.Create(Application) do
      try
        ShowModal;
      finally
        Free;
      end;
  end;

  procedure TdAbout.ApplyWindowRgn;
  var
    hr: HRGN;
    ih, iw: Integer;
    cnv: TCanvas;

    procedure ProcessRect(ix1, iy1, ix2, iy2: Integer);
    var
      ixL, ixR, iy: Integer;
      _hr: HRGN;
    begin
      ixR := 0; // satisfy the compiler
      for iy := iy1 to iy2 do begin
        ixL := ix1;
        repeat
           // ���� ������ ����������� �����
          while (ixL<=ix2) and (cnv.Pixels[ixL, iy]<>CTransp) do Inc(ixL);
          if ixL<=ix2 then begin
             // ���� ��������� ����������� �����
            ixR := ixL;
            while (ixR<=ix2) and (cnv.Pixels[ixR, iy]=CTransp) do Inc(ixR);
             // �������� ������
            if ixL<ixR then begin
              _hr := CreateRectRgn(ixL, iy, ixR, iy+1);
              CombineRgn(hr, hr, _hr, RGN_DIFF);
              DeleteObject(_hr);
            end;
            ixL := ixR;
          end else
            Break;
        until ixR>=ix2;
      end;
    end;

  begin
    iw := ClientWidth;
    ih := ClientHeight;
    hr := CreateRectRgn(0, 0, iw, ih);
    cnv := iMain.Picture.Bitmap.Canvas;
     // ������������ ������� ����� ��������� ����
    ProcessRect(0, RSolid.Top, RSolid.Left, RSolid.Bottom);
     // ������������ ������� ������ ��������� ����
    ProcessRect(RSolid.Right, RSolid.Top, iw, RSolid.Bottom);
    SetWindowRgn(Handle, hr, False);
  end;

  procedure TdAbout.Fadeout;
  var b: Byte;
  begin
     // Enable fadeout effect on Win2K+
    if (Win32Platform=VER_PLATFORM_WIN32_NT) and (Win32MajorVersion>=5) then begin
      AlphaBlend := True;
      Update;
      for b := 12 downto 1 do begin
        AlphaBlendValue := b*20;
        Sleep(20);
      end;
    end;
    Close;
  end;

  procedure TdAbout.FormCreate(Sender: TObject);
  begin
    lVersion.Caption := 'Version '+SAppVersion;
    ApplyWindowRgn;
  end;

  procedure TdAbout.FormKeyPress(Sender: TObject; var Key: Char);
  begin
    if Key in [#13, #27] then Fadeout;
  end;

  procedure TdAbout.lEmailClick(Sender: TObject);
  begin
    ShellExecute(Handle, SOpOpen, PChar(SInternetEmail), nil, nil, SW_SHOWNORMAL);
  end;

  procedure TdAbout.lOKClick(Sender: TObject);
  begin
    Fadeout;
  end;

  procedure TdAbout.lWebsiteClick(Sender: TObject);
  begin
    ShellExecute(Handle, SOpOpen, PChar(SInternetWebsite), nil, nil, SW_SHOWNORMAL);
  end;

  procedure TdAbout.WMNCHitTest(var Msg: TWMNCHitTest);
  var c: TControl;
  begin
    c := ControlAtPos(ScreenToClient(Point(Msg.XPos, Msg.YPos)), False);
    if (c<>nil) and (c is TLabel) and (TLabel(c).Cursor=crHandPoint) then inherited else Msg.Result := HTCAPTION;
  end;

end.
