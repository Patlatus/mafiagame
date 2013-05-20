unit usAdvo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usWL, StdCtrls, ExtCtrls;

type
  TUserAdvocat = class(TUserWL)
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserAdvocat: TUserAdvocat;

implementation

uses MafiaDef, umsg, uEventList;

{$R *.dfm}

procedure TUserAdvocat.FormCreate(Sender: TObject);
begin
  Mafia := TAdvocat;
  Player := Advocat;
end;

procedure TUserAdvocat.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  if AccusedPlayer.Attempted then
    begin
      Doctor.Heal(AccusedPlayer);
      if AccusedPlayer.Attempted then
        InfoString := Mafia.ClassName + ' couldn''t heal this person'
      else
        InfoString := Mafia.ClassName + ' healed some person'
    end
  else
    InfoString := Mafia.ClassName + ' decided to heal alive person';
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddHealTry(Player, AccusedPlayer, 'Court Lawyer Heal', InfoString);
  Hide;
end;

end.
