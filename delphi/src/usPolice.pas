unit usPolice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usMafia, StdCtrls, ExtCtrls;

type
  TUserPolice = class(TUserMafia)
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject); override;
  private
    { Private declarations }
  public
    function WayOfKill: string;
    { Public declarations }
  end;

var
  UserPolice: TUserPolice;

implementation

uses MafiaDef, umsg, uEventList;

{$R *.dfm}

procedure TUserPolice.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  if ac.itemindex = 0 then
    AccusedPlayer.Imprison(Player)
  else
    AccusedPlayer.Shoot(Player);
  if AccusedPlayer.Attempted then
    InfoString := Mafia.ClassName + ' has made her holy dark duty ' + WayOfKill
  else
  if AccusedPlayer.DeathImmune then
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was DEATHIMMUNE'
  else
  if AccusedPlayer.NightShield then
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was under a spell NightShield'
  else
  if not AccusedPlayer.MafiaOrManiac then
    InfoString := Mafia.ClassName+' didn''t succeed to imprison VICTIM because she was INNOCENT and nor a mafia neither a maniac'
  else
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed for unknown reason (internal program error)';

  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide
end;

function TUserPolice.WayOfKill: string;
begin
  if ac.itemindex = 0 then
    Result:='imprison'
  else
    Result:='Just to shoot'
end;

procedure TUserPolice.Button2Click(Sender: TObject);
begin
  MSG.Memo1.Lines.Add(Mafia.ClassName + ' decided to take a rest');
  EventList.AddMoveMiss(Player, 'Decision', Mafia.ClassName + ' decided to take a rest');
  Hide
end;

procedure TUserPolice.FormCreate(Sender: TObject);
begin
  Mafia:=TPolice
end;

end.
