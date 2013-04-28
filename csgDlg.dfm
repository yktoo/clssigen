object csgBaseDialog: TcsgBaseDialog
  Left = 526
  Top = 109
  BorderStyle = bsDialog
  ClientHeight = 271
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bvBottom: TBevel
    Left = 0
    Top = 228
    Width = 392
    Height = 2
    Align = alBottom
    Shape = bsBottomLine
  end
  object pMain: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 228
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
  end
  object pBottom: TPanel
    Left = 0
    Top = 230
    Width = 392
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      392
      41)
    object bOK: TButton
      Left = 228
      Top = 10
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = bOKClick
    end
    object bCancel: TButton
      Left = 308
      Top = 10
      Width = 75
      Height = 23
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = bCancelClick
    end
  end
end
