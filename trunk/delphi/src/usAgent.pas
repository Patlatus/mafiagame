unit usAgent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usPolice, StdCtrls, ExtCtrls;

type
  TUserAgentFBI = class(TUserPolice)
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function WayOfKill: string;
    { Public declarations }
  end;

var
  UserAgentFBI: TUserAgentFBI;

implementation

uses umsg, MafiaDef, uEventList;

{$R *.dfm}

procedure TUserAgentFBI.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  Case ac.itemindex of
    0:
      AccusedPlayer.Imprison(Player);
    1:
      AccusedPlayer.Shoot(Player);
    else
      Mafia.AvatarDeath(AccusedPlayer);
  end;
  if AccusedPlayer.Dead then
    InfoString := Mafia.ClassName+' has made her holy dark duty ' + WayOfKill
  else
    if AccusedPlayer.DeathImmune then
      InfoString := Mafia.ClassName+' tried to kill somebody but didn''t succeed because VICTIM was DEATHIMMUNE'
    else
     if AccusedPlayer.NightShield then
       InfoString := Mafia.ClassName+' tried to kill somebody but didn''t succeed because VICTIM was under a spell NightShield'
     else
      if not AccusedPlayer.MafiaOrManiac and (ac.itemindex = 0) then
        InfoString := Mafia.ClassName+' didn''t succeed to imprison VICTIM because she was INNOCENT and nor a mafia neither a maniac'
      else
        if not AccusedPlayer.Avatar and (ac.itemindex = 2) then
          InfoString := Mafia.ClassName+' didn''t succeed using poison AVATARDEATH because VICTIM wasn''t an AVATAR'
        else
          InfoString := Mafia.ClassName+' tried to kill somebody but didn''t succeed for unknown reason';
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide
end;

function TUserAgentFBI.WayOfKill: string;
begin
  Case ac.itemindex of
    0:
      Result:='imprison';
    1:
      Result:='Just to shoot';
    else
      Result:='Die avator'
  end;
end;

procedure TUserAgentFBI.FormCreate(Sender: TObject);
begin
  Mafia := TAgentFBI;
  Player := Agent;
end;

end.
