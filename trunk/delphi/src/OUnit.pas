unit OUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TOForm = class(TForm)
    MAC: TRadioGroup;
    Label1: TLabel;
    BackB: TButton;
    Button2: TButton;
    NextB: TButton;
    RC: TRadioGroup;
    procedure MACClick(Sender: TObject);
    Function GetRCIndex:byte;
    procedure NextBClick(Sender: TObject);
    procedure BackBClick(Sender: TObject);
    procedure NextBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OForm: TOForm;

implementation

uses MafiaDef, uinfo, uCheat;

{$R *.dfm}

procedure TOForm.MACClick(Sender: TObject);
begin
  NextB.Enabled:=true;
end;

Function TOForm.GetRCIndex:byte;
begin
  case rc.ItemIndex of
    0: result:=1;
    1: result:=4;
    else
       result:=rc.ItemIndex+5
  end
end;

procedure TOForm.NextBClick(Sender: TObject);
begin
  if RC.Visible then
    begin
      User:=Roles[GetRCIndex].Create;
      DeleteRole(GetRCIndex);
      User.RoleIndex := GetRCIndex;
      ManualChoose;

    //Ручний добір всіх решти
      NextB.Caption:='Ok';
      Mac.Hide;
      RC.Hide;
      BackB.Hide;
      Label1.Caption:='Click Ok to start the game';
      User.RoleInfo := RolesInfo[GetRCIndex];
      Info.Memo2.Text := User.RoleInfo;
      Info.ShowModal;
      NextB.ModalResult:=mrOk
    end
  else
  if MAC.Visible then
  if MAC.ItemIndex=0 then
    begin
      RC.show;
      BackB.Enabled:=true;
      NextB.Enabled:=false
    end
  else
    begin
    //Auto Choose
      User.RoleInfo := RolesInfo[AutoChoose];
      Info.Memo2.Text := User.RoleInfo;

      Mac.Hide;
      NextB.Caption:='Ok';
      BackB.Hide;
      Label1.Caption:='Click Ok to start the game';
      Info.ShowModal;
      NextB.ModalResult:=mrOk
    end
end;

procedure TOForm.NextBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssShift in Shift) and (ssCtrl in Shift) and (Char(Key)='C')) then begin
    CheatsEnabled := True;
    //CheatForm.Show;
  end;
end;

procedure TOForm.BackBClick(Sender: TObject);
begin
  if RC.Visible then
    begin
      RC.Hide;
      BackB.Enabled:=false
    end

end;

end.
