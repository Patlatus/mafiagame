unit usMafia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uac, MafiaDef, StdCtrls, ExtCtrls;

type
  TUserMafia = class(TAccuse)
    procedure Button1Click(Sender: TObject); override;
    procedure Button2Click(Sender: TObject); override;
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserMafia: TUserMafia;

implementation

uses umsg, uEventList;

{$R *.dfm}

procedure TUserMafia.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
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
    InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed for unknown reason (internal program error)';

  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide
end;

procedure TUserMafia.Button2Click(Sender: TObject);
begin
  MSG.Memo1.Lines.Add(Mafia.ClassName+' decided to take a rest and leave people alone');
  EventList.AddMoveMiss(Player, 'Decision', Mafia.ClassName+' decided to take a rest and leave people alone');
  Hide
end;

procedure TUserMafia.FormHide(Sender: TObject);
begin
  StopHide;
end;

end.
