unit usMorokun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, usDemon;

type
  TUserMorokun = class(TUserDemon)
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function WayOfKill: string;
    { Public declarations }
  end;

var
  UserMorokun: TUserMorokun;

implementation

uses MafiaDef, umsg, uEventList;

{$R *.dfm}

procedure TUserMorokun.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  if ac.itemindex = 1 then
    AccusedPlayer.MorokunAttack(Player)
  else
    AccusedPlayer.Shoot(Player);
  if AccusedPlayer.Attempted then
    InfoString := Mafia.ClassName + ' has made her dark duty ' + WayOfKill
  else
  if AccusedPlayer.DeathImmune then
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was DEATHIMMUNE'
  else
  if AccusedPlayer.NightShield then
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was under a spell NightShield'
  else
  if ac.itemindex = 1 then
    InfoString := Mafia.ClassName+' didn''t succeed because victim wasn''t whitelighter'
  else
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed for unknown reason (internal program error)';

  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide;
end;

function TUserMorokun.WayOfKill: string;
begin
  if ac.itemindex = 1 then
    Result:='Morokunical death'
  else
    Result:='Just to shoot'
end;

procedure TUserMorokun.FormCreate(Sender: TObject);
begin
  Mafia := TMorokun;
  Player := Morokun;
end;

end.
