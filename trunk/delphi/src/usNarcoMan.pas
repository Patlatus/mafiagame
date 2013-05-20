unit usNarcoMan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usNarcoDiler, StdCtrls, ExtCtrls;

type
  TUserNarcoMan = class(TUserNarcoDiler)
    procedure Button1Click(Sender: TObject); override;
    procedure Button2Click(Sender: TObject); override;
  private
    { Private declarations }
  public
//    Narcoman:TMafiaRole;
    NarcomanString:String;
    { Public declarations }
  end;

var
  UserNarcoMan: TUserNarcoMan;

implementation

uses umsg, MafiaDef, uEventList;

{$R *.dfm}

procedure TUserNarcoMan.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  AccusedPlayer.Shoot(Player);
  if AccusedPlayer.Attempted then
    InfoString := NarcomanString + ' being crazy without drugs killed someone'
  else
    if AccusedPlayer.DeathImmune then
      InfoString := NarcomanString + ' tried to kill somebody but didn''t succeed because VICTIM was DEATHIMMUNE'
    else
      if AccusedPlayer.NightShield then
        InfoString := NarcomanString + ' tried to kill somebody but didn''t succeed because VICTIM was under a spell NightShield'
      else
        InfoString := NarcomanString + ' tried to kill somebody but didn''t succeed for unknown reason';
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, 'Drugs', InfoString);
  Hide
end;

procedure TUserNarcoMan.Button2Click(Sender: TObject);
begin
  MSG.Memo1.Lines.Add(NarcomanString + ' decided to take a rest and leave people alone');
  EventList.AddMoveMiss(Player, 'Decision', NarcomanString + ' decided to take a rest and leave people alone');
  Hide
end;

end.
