object dFAProps: TdFAProps
  Left = 406
  Top = 126
  ActiveControl = eExt
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072': '#1072#1089#1089#1086#1094#1080#1072#1094#1080#1103' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 119
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    441
    119)
  PixelsPerInch = 96
  TextHeight = 13
  object pMain: TPanel
    Left = 8
    Top = 8
    Width = 425
    Height = 69
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      425
      69)
    object lApp: TLabel
      Left = 88
      Top = 16
      Width = 182
      Height = 13
      Caption = '&'#1055#1088#1080#1083#1086#1078#1077#1085#1080#1077', '#1086#1090#1082#1088#1099#1074#1072#1102#1097#1077#1077' '#1092#1072#1081#1083#1099':'
      FocusControl = eApp
    end
    object lExt: TLabel
      Left = 12
      Top = 16
      Width = 66
      Height = 13
      Caption = '&'#1056#1072#1089#1096#1080#1088#1077#1085#1080#1077':'
      FocusControl = eExt
    end
    object eExt: TEdit
      Left = 12
      Top = 32
      Width = 73
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 10
      TabOrder = 0
      OnChange = AdjustOKCancel
      OnKeyPress = eExtKeyPress
    end
    object eApp: TFilenameEdit
      Left = 88
      Top = 32
      Width = 324
      Height = 21
      Filter = #1055#1088#1086#1075#1088#1072#1084#1084#1099' (*.exe;*.com;*.bat)|*.exe;*.com;*.bat'
      DialogTitle = #1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077', '#1086#1090#1082#1088#1099#1074#1072#1102#1097#1077#1077' '#1092#1072#1081#1083#1099
      Anchors = [akLeft, akTop, akRight]
      NumGlyphs = 1
      TabOrder = 1
      OnChange = AdjustOKCancel
    end
  end
  object bOK: TButton
    Left = 278
    Top = 88
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Default = True
    Enabled = False
    TabOrder = 1
    OnClick = bOKClick
  end
  object bCancel: TButton
    Left = 358
    Top = 88
    Width = 75
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end
