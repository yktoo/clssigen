inherited dSettings: TdSettings
  ActiveControl = tvAssociations
  Caption = 'Program settings'
  ClientHeight = 435
  ClientWidth = 492
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvBottom: TBevel
    Top = 392
    Width = 492
  end
  inherited pMain: TPanel
    Width = 492
    Height = 392
    object lFileAssoc: TLabel
      Left = 12
      Top = 12
      Width = 81
      Height = 13
      Caption = '&File associations:'
    end
    object tvAssociations: TVirtualStringTree
      Left = 12
      Top = 28
      Width = 469
      Height = 353
      Anchors = [akLeft, akTop, akRight, akBottom]
      EditDelay = 0
      Header.AutoSizeIndex = 1
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'MS Shell Dlg 2'
      Header.Font.Style = []
      Header.MainColumn = 1
      Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      ParentBackground = False
      PopupMenu = pmAssociations
      TabOrder = 0
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toExtendedFocus, toRightClickSelect]
      OnChecked = tvAssociationsChecked
      OnFocusChanged = tvAssociationsFocusChanged
      OnFreeNode = tvAssociationsFreeNode
      OnGetText = tvAssociationsGetText
      OnInitNode = tvAssociationsInitNode
      OnNewText = tvAssociationsNewText
      Columns = <
        item
          Options = [coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
          Position = 0
          Width = 75
          WideText = 'Mask'
        end
        item
          Options = [coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible]
          Position = 1
          Width = 390
          WideText = 'Application'
        end>
      WideDefaultText = ''
    end
  end
  inherited pBottom: TPanel
    Top = 394
    Width = 492
    inherited bOK: TButton
      Left = 328
    end
    inherited bCancel: TButton
      Left = 408
    end
  end
  object alMain: TActionList
    Left = 56
    Top = 60
    object aAssociationDelete: TAction
      Caption = '&Delete'
      OnExecute = aaAssociationDelete
    end
    object aAssociationEdit: TAction
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100'...'
      OnExecute = aaAssociationEdit
    end
  end
  object pmAssociations: TPopupMenu
    Left = 28
    Top = 60
    object ipmDeleteFA: TMenuItem
      Action = aAssociationDelete
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000130B0000130B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777799999997777777791111111977777779111111197777777911111119
        7777777799999997777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      ShortCut = 46
    end
    object ipmSep: TMenuItem
      Caption = '-'
    end
    object ipmEditFA: TMenuItem
      Action = aAssociationEdit
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777777777777777777777777777777777780000000000000008FFFFFFFFFFF
        FFF08FF4444F444FF0F08F44F44F44F4F0F08F44F44F44F4F0F08FF4444F44F4
        F0F08FFFF44F444FF0F08FF444FF44FFF0F08FFFFFFF44FFF0F08FFFFFFF44FF
        F0F08FFFFFFFFFFFFFF088888888888888887777777777777777}
      Default = True
      ShortCut = 32781
    end
  end
  object odApp: TOpenDialog
    DefaultExt = 'exe'
    Filter = 
      'Applications (*.exe;*.com;*.bat;*.cmd;*.pif)|*.exe;*.com;*.bat;*' +
      '.cmd;*.pif|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Select an application'
    Left = 12
    Top = 384
  end
end
