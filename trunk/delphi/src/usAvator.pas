unit usAvator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uWitch, StdCtrls, ExtCtrls, MafiaDef, uEventList;

type
  TUserAvator = class(TWitchForm)
    procedure Button2Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject); override;
    procedure ACClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Renew; override;
    { Public declarations }
  end;

var
  UserAvator: TUserAvator;
  Actions:array [1..6] of record
    Action:String;Proc: TMafiaProc; EventProc: TMafiaEventProc; Power:byte end =
    ((Action:'JoinUs';Proc:TMafiaRole.AvatorJoinUs;Power:1),
    (Action:'HealDead';Proc:TMafiaRole.AvatorHeal;Power:2),
    (Action:'ChangeEventInPast (not enabled yet)';EventProc: TAdvancedAvatar.AvatorChangeEventInPast;Power:3),
    (Action:'RewindBack (not enabled yet)';EventProc: TAdvancedAvatar.AvatorRewindEventsBack;Power:5),
    (Action:'MakeUtopy';Proc:TMafiaRole.AvatorMakeUtopy;Power:10),
    (Action:'Clear (not enabled yet)';Proc:TMafiaRole.AvatorClear;Power:10));

implementation

uses umsg;

{$R *.dfm}

procedure TUserAvator.Renew;
VAR
  j:byte;
begin
  Inherited;
  power.Caption:='Avators count (power): '+inttostr(CountOfAliveAvatars);
  AC.Items.Clear;
  for j:=1 to 5 do
    if CountOfAliveAvatars>=Actions[j].Power then
      AC.Items.Add(Actions[j].Action);
  if Utopy and (CountOfAliveAvatars>=10) then
      AC.Items.Add(Actions[6].Action);
  Button2.Enabled := Player.AvatorNumber > 1//not (Player is TAvatar);
end;

procedure TUserAvator.Button2Click(Sender: TObject);
begin
  Player.LeaveAvators
end;

procedure TUserAvator.FormCreate(Sender: TObject);
begin
  Player := MainAvatar;
  Mafia := TAvatar;

    Actions[1].Proc := TMafiaRole.AvatorJoinUs;
    Actions[2].Proc := TMafiaRole.AvatorHeal;
    Actions[3].EventProc := TAdvancedAvatar.AvatorChangeEventInPast;
    Actions[4].EventProc := TAdvancedAvatar.AvatorRewindEventsBack;
    Actions[5].Proc := TMafiaRole.AvatorMakeUtopy;
    Actions[6].Proc := TMafiaRole.AvatorClear;

end;

procedure TUserAvator.ACClick(Sender: TObject);
begin
  EnableButton;
  case AC.ItemIndex of
  0, 5: PrepareLivePlayersList;
  1: PrepareDeadPlayersList;
  2, 3: PrepareEventsList;
  4: begin
    AP.Items.Text := '';
    AP.Enabled := False;
    AP.Visible := False;
  end;
  end;
end;

procedure TUserAvator.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  MSG.Memo1.Lines.Add('Avators used a power '+Actions[ac.itemindex+1].Action);
  case AC.ItemIndex of
  0, 5: Actions[ac.itemindex+1].Proc(ChosenLivePlayer);
  1: Actions[ac.itemindex+1].Proc(ChosenDeadPlayer);
  2, 3: Actions[ac.itemindex+1].EventProc(ChosenEvent);//PrepareEventsList;
  4:  Actions[ac.itemindex+1].Proc(Nil);
  end;

  case ac.itemindex of
    0:
      if ChosenLivePlayer.Avatar then
        InfoString := 'Somebody joins avators'
      else
        InfoString := 'Somebody reject avators'' offer';
    1:
      if ChosenDeadPlayer.Alive then
        InfoString := 'Avatars ressurected someone from deads!'
      else
        InfoString := 'Avatars haven''t managed to ressurect someone from deads!';
    4:
      InfoString := 'Avators made UTOPY!!!';
    5:
      InfoString := 'Avators cleared someone';
  end;
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player, AccusedPlayer, WayOfKill, InfoString);
  Hide

end;

end.
