unit usANCop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usPolice, StdCtrls, ExtCtrls;

type
  TUserANCop = class(TUserPolice)
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function WayOfKill: string;
  end;

var
  UserANCop: TUserANCop;

implementation

uses MafiaDef, umsg, uEventList;

{$R *.dfm}

procedure TUserANCop.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
    Case ac.itemindex of
    0:
      if AccusedPlayer.HasDrugs then
        begin
          InfoString := 'ANCop takes off drugs from narcodiler';
          AccusedPlayer.TakeOffDrugs;
        end
      else
        InfoString := 'ANCop tries to take off drugs from someone, but she doesn''t have it';
    1:
      begin
        AccusedPlayer.Shoot(Player);

        if AccusedPlayer.Attempted then
        if AccusedPlayer.Narcoman then
          InfoString := Mafia.ClassName + ' shooted at somebody. Was she a narcoman? Yep'
        else
          InfoString := Mafia.ClassName + ' shooted at somebody. Was she a narcoman? Nope'
        else
        if AccusedPlayer.DeathImmune then
          InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was DEATHIMMUNE'
        else
        if AccusedPlayer.NightShield then
          InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed because VICTIM was under a spell NightShield'
        else
          InfoString := Mafia.ClassName + ' tried to kill somebody but didn''t succeed for unknown reason (internal program error)';
      end
    else
      if AccusedPlayer.Narcoman then
        begin
          ANCop.HealNarcoman(AccusedPlayer);
          if AccusedPlayer.Narcoman then
            InfoString := 'ANCop tries to heal from drugs smb, but didn''t succeed'
          else
            InfoString := 'ANCop heals somebody from drugs-adiction';
        end
      else
        InfoString := 'ANCop tries to heal from drugs not drugs-adicted person';
  end;
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide
end;

function TUserANCop.WayOfKill: string;
begin
  Case ac.itemindex of
    0:
      Result:='take off drugs';
    1:
      Result:='Just to shoot';
    else
      Result:='heal'
  end;
end;

procedure TUserANCop.FormCreate(Sender: TObject);
begin
  Mafia := TAntiNarcoCop;
  Player := ANCop;
end;

end.
