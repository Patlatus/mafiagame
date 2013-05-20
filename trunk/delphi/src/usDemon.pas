unit usDemon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usPolice, StdCtrls, ExtCtrls;

type
  TUserDemon = class(TUserPolice)
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject); override;
    procedure ACClick(Sender: TObject);
  private
    { Private declarations }
  public
    function WayOfKill: string;
    { Public declarations }
  end;

var
  UserDemon: TUserDemon;

implementation

uses MafiaDef, umsg, uEventList;

{$R *.dfm}

procedure TUserDemon.ACClick(Sender: TObject);
begin
  EnableButton;
  case AC.ItemIndex of
  0, 1: PrepareLivePlayersList;
  2: PrepareDeadPlayersList;
  end;
end;

procedure TUserDemon.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  case ac.itemindex of
  0:
    AccusedPlayer.DemonicAttack(Player);
  1:
    AccusedPlayer.Shoot(Player);
  else
    ChosenDeadPlayer.MakeZombie(Player);
  end;

  if ac.itemindex < 2 then
    if AccusedPlayer.Attempted then
      InfoString := Mafia.ClassName + ' has made her dark duty ' + WayOfKill
    else
    if AccusedPlayer.DeathImmune then
      InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was DEATHIMMUNE'
    else
    if AccusedPlayer.NightShield then
      InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was under a spell NightShield'
    else
      InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed for unknown reason (internal program error)'
  else
    if ChosenDeadPlayer.Zombie then
      InfoString := Mafia.ClassName + ' made a new ZOMBIE!!!'
    else
      InfoString := Mafia.ClassName + ' tried to make a new ZOMBIE but didn''t succeed for unknown reason (internal program error. Bug?)';


  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide;
end;

function TUserDemon.WayOfKill: string;
begin
  if ac.itemindex = 0 then
    Result:='Demonical death'
  else
    Result:='Just to shoot'
end;

procedure TUserDemon.FormCreate(Sender: TObject);
begin
  Mafia := TDemon;
  Player := Demon;
end;

end.
