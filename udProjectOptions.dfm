inherited dProjectOptions: TdProjectOptions
  Caption = 'Project options'
  ClientHeight = 366
  ClientWidth = 503
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvBottom: TBevel
    Top = 323
    Width = 503
  end
  inherited pMain: TPanel
    Width = 503
    Height = 323
    object lSSIExtensions: TLabel
      Left = 12
      Top = 200
      Width = 75
      Height = 13
      Caption = '&SSI Extensions:'
    end
    object gbBaseFolder: TGroupBox
      Left = 12
      Top = 12
      Width = 480
      Height = 61
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Base HTML folder'
      TabOrder = 0
      DesignSize = (
        480
        61)
      object eBaseFolder: TEdit
        Left = 16
        Top = 24
        Width = 368
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = DlgDataChanged
      end
      object bBrowseBaseFolder: TButton
        Left = 391
        Top = 24
        Width = 75
        Height = 23
        Anchors = [akTop, akRight]
        Caption = '&Browse...'
        TabOrder = 1
        OnClick = bBrowseBaseFolderClick
      end
    end
    object gbOutFolder: TGroupBox
      Left = 12
      Top = 80
      Width = 480
      Height = 61
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Output folder'
      TabOrder = 1
      DesignSize = (
        480
        61)
      object eOutFolder: TEdit
        Left = 16
        Top = 24
        Width = 368
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = DlgDataChanged
      end
      object bBrowseOutFolder: TButton
        Left = 391
        Top = 24
        Width = 75
        Height = 23
        Anchors = [akTop, akRight]
        Caption = 'B&rowse...'
        TabOrder = 1
        OnClick = bBrowseOutFolderClick
      end
    end
    object cbRunUponCompletion: TCheckBox
      Left = 12
      Top = 152
      Width = 129
      Height = 17
      Caption = 'Run upon completion:'
      TabOrder = 2
      OnClick = cbRunUponCompletionClick
    end
    object eRunUponCompletion: TEdit
      Left = 12
      Top = 172
      Width = 480
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      OnChange = DlgDataChanged
    end
    object mSSIExtensions: TMemo
      Left = 12
      Top = 216
      Width = 480
      Height = 93
      Anchors = [akLeft, akTop, akRight, akBottom]
      ScrollBars = ssVertical
      TabOrder = 4
      OnChange = DlgDataChanged
    end
  end
  inherited pBottom: TPanel
    Top = 325
    Width = 503
    inherited bOK: TButton
      Left = 339
    end
    inherited bCancel: TButton
      Left = 419
    end
  end
end
