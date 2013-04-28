unit udFAProps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, ToolEdit, ComCtrls;

type
  TdFAProps = class(TForm)
    pMain: TPanel;
    bOK: TButton;
    bCancel: TButton;
    lApp: TLabel;
    lExt: TLabel;
    eExt: TEdit;
    eApp: TFilenameEdit;
    procedure AdjustOKCancel(Sender: TObject);
    procedure eExtKeyPress(Sender: TObject; var Key: Char);
    procedure bOKClick(Sender: TObject);
  private
    HostLV: TListView;
    LICur: TListItem;
  end;

  function EditFA(var sExt, sApp: String; _HostLV: TListView; _LICur: TListItem): Boolean;

implementation
{$R *.DFM}
uses ConsVarsTypes;

  function EditFA(var sExt, sApp: String; _HostLV: TListView; _LICur: TListItem): Boolean;
  begin
    with TdFAProps.Create(Application) do
      try
        HostLV := _HostLV;
        LICur  := _LICur;
        eExt.Text := sExt;
        eApp.Text := sApp;
        Result := ShowModal=mrOK;
        if Result then begin
          sExt := eExt.Text;
          sApp := eApp.FileName;
        end;
      finally
        Free;
      end;
  end;

  procedure TdFAProps.AdjustOKCancel(Sender: TObject);
  begin
    if Visible then begin
      bOK.Enabled := (Trim(eExt.Text)<>'') and (Trim(eApp.Text)<>'');
      bCancel.Caption := 'Отмена';
    end;
  end;

  procedure TdFAProps.eExtKeyPress(Sender: TObject; var Key: Char);
  begin
    if not (Key in ['a'..'z', 'А'..'Z', 'А'..'я', '0'..'9', #8]) then Key := #0;
  end;

  procedure TdFAProps.bOKClick(Sender: TObject);
  var
    i: Integer;
    li: TListItem;
  begin
    for i := 0 to HostLV.Items.Count-1 do begin
      li := HostLV.Items[i];
      if (li<>LICur) and (AnsiCompareText(li.Caption, eExt.Text)=0) then begin
        Error(Format('Расширение «%s» уже присутствует в списке.', [eExt.Text]));
        Exit;
      end;
    end;
    ModalResult := mrOK;
  end;

end.

