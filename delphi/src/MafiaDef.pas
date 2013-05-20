unit MafiaDef;

interface
Uses SysUtils{for inttostr}, Windows, Dialogs;
type
  TMafiaRole = class;
  TMafiaProc = Procedure (Sender:TMafiaRole) of object;
  TAA = class
  end;
  TMafiaRole = class
    Private
      FUser, FDead, FAttempted, FNarcoman,FAvatar,FZombie,
      FNarcoImmune,FDeathImmune,FHangImmune,
      FFreezed,FNightShield,FDayShield,FSilent,
      FShooted,FKilledByZombie, FCleared,FHanged,FDemonicKilled,FKilledByPolice,FDiedForSpell,FDiedForPoison,FKilledByMorokun,FDiedForDrugs,
      FUnSleep,FHasDrugs:boolean;
      FRoleInfo: String;
      FOnDead, {FOnHang,} FOnAttempt: TMafiaProc;
      FLifeSpan,FNarcoNumber,FAvatorNumber, FZombieIndex:byte;
      FKiller: TMafiaRole;

    Protected

      Property IsNarcoman:boolean read FNarcoman write FNarcoman;
      Property IsAvatar:boolean read FAvatar write FAvatar;
      Property IsZombie:boolean read FZombie write FZombie;
      Property IsNarcoImmune:boolean read FNarcoImmune write FNarcoImmune;
      Property IsDeathImmune:boolean read FDeathImmune write FDeathImmune;
      Property IsHangImmune:boolean read FHangImmune write FHangImmune;
      Property IsDead:boolean read FDead write FDead;
      Property KilledByPolice:boolean read FKilledByPolice write FKilledByPolice;
      Property KilledByDemon:boolean read FDemonicKilled write FDemonicKilled;
      Property KilledByShot:boolean read FShooted write FShooted;
      Property KilledByHang:boolean read FHanged write FHanged;
      Property IsUser:boolean read FUser write FUser;
      Property IsFreezed:boolean read FFreezed write FFreezed;
      Property IsDayShield:boolean read FDayShield write FDayShield;
      Property IsNightShield:boolean read FNightShield write FNightShield;
      Property IsSilent:boolean read FSilent write FSilent;
      Property LifeSpan:byte read FLifeSpan write FLifeSpan;
      //Procedure Murder(Sender: TMafiaRole);virtual;
      Procedure Heal(Sender: TMafiaRole);virtual;
    Public
      Name, NickName, AvatarName: String;
      Index, RoleIndex: Integer;
      Class Procedure AvatorHeal(Sender: TMafiaRole);virtual;
      Class Procedure AvatorJoinUs(Sender: TMafiaRole);virtual;
      //Class Procedure AvatorChangeEventInPast(Sender: TMafiaRole);virtual;
      //Class Procedure AvatorRewindEventsBack(Sender: TMafiaRole);virtual;
      Class Procedure AvatorMakeUtopy(Sender: TMafiaRole);virtual;
      Class Procedure AvatorClear(Sender: TMafiaRole);virtual;
      Procedure MakeNarcoman(Sender: TMafiaRole);virtual;
      Procedure MakeAvatarsNarcomans;virtual;
      Procedure HealNarcoman(Sender: TMafiaRole);virtual;
      Procedure LeaveAvators;virtual;
      procedure MakeZombie(AKiller: TMafiaRole);
      Property UnSleep:boolean read FUnSleep write FUnSleep default false;
      Procedure TryToKill(AKiller: TMafiaRole); virtual;
      //Procedure NightKill;virtual;
      procedure Morning;
      procedure Death;
      Procedure Shoot(AKiller: TMafiaRole); virtual;
      Procedure Clear(AKiller: TMafiaRole); virtual;
      Procedure DemonicAttack(AKiller: TMafiaRole); virtual;
      Procedure MorokunAttack(AKiller: TMafiaRole); virtual;
      Procedure ZombieAttack(AKiller: TMafiaRole); virtual;
      Procedure TakeOffDrugs; virtual;
      Procedure Hang;virtual;
      Procedure BeAvator;virtual;
      Procedure JoinAvators;virtual;
      Procedure Imprison(AKiller: TMafiaRole); virtual;
      function Info:string; virtual;
      function ShortInfo: String; virtual;
      Procedure MafiaRoleOnDead(sender: TMafiaRole);virtual;
      Function Alive:boolean;
      Class procedure AvatarDeath(Target: TMafiaRole);virtual;
      Function MafiaOrManiac: boolean;virtual;
      Function IfJoinAvators: boolean; virtual;
      Function Aim: string; virtual;
    function Status: string;
    //Published
      Property OnDead:TMafiaProc read FOnDead write FOnDead;
      //Property OnHang:TMafiaProc read FOnHang write FOnHang;
      Property OnAttempt:TMafiaProc read FOnAttempt write FOnAttempt;
      property Attempted: Boolean read FAttempted write FAttempted;
      Property Dead:boolean read FDead;
      Property UserControlled:boolean read FUser;
      Property Narcoman:boolean read FNarcoman;
      Property Avatar:boolean read FAvatar;
      Property Zombie:boolean read FZombie;
      Property NarcoImmune:boolean read FNarcoImmune;
      Property DeathImmune:boolean read FDeathImmune;
      Property HangImmune:boolean read FHangImmune;
      Property Freezed:boolean read FFreezed;
      Property DayShield:boolean read FDayShield;
      Property NightShield:boolean read FNightShield;
      Property Silent:boolean read FSilent;
      Property HasDrugs:boolean read FHasDrugs;
      Property NarcoNumber:byte read FNarcoNumber;
      Property AvatorNumber:byte read FAvatorNumber;
      property RoleInfo: String read FRoleInfo write FRoleInfo;
      Constructor Create;virtual;
      Class Function WinningCondition:boolean;virtual;abstract;
      Class Function LosingCondition:boolean;virtual;abstract;
  end;

  TRole = class of TMafiaRole;

  TMafiaRoleArray = array [1..19] of TMafiaRole;

  TMafiaManiac = class (TMafiaRole)
    Public
      Function MafiaOrManiac: boolean;override;
      //Procedure Murder(Sender: TMafiaRole);//override;
  end;

  TMafia = class (TMafiaManiac)
  end;

  TMafias = array[1..3] of TMafia;

  TBlackMafia = class (TMafia)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Procedure MafiaRoleOnDead(sender: TMafiaRole);override;
  end;

  TBlackMafia1 = class (TBlackMafia)
    Public
      Constructor Create;override;
  end;

  TBlackMafia2 = class (TBlackMafia)
    Public
      Constructor Create;override;
  end;

  TBlackMafia3 = class (TBlackMafia)
    Public
      Constructor Create;override;
  end;

  TRedMafia = class (TMafia)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Procedure MafiaRoleOnDead(sender: TMafiaRole);override;
  end;

  TRedMafia1 = class (TRedMafia)
    Public
      Constructor Create;override;
  end;

  TRedMafia2 = class (TRedMafia)
    Public
      Constructor Create;override;
  end;

  TRedMafia3 = class (TRedMafia)
    Public
      Constructor Create;override;
  end;

  TManiac = class (TMafiaManiac)
  end;

  TBlackManiac = class (TManiac)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
  end;

  TRedManiac = class (TManiac)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
  end;

  TAdvocat = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
      Procedure Heal(Sender: TMafiaRole);override;
    function Aim: string; override;
  end;

  TDoctor = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
      Procedure Heal(Sender: TMafiaRole);override;

  end;

  TPolice = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;

  end;

  TDemon = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;

  end;

  TWitch = class (TMafiaRole)
    Private
      FPower,FDif:byte;
    Protected
      Property PPower:byte read FPower write FPower;
    Public
      Property Power:byte read FPower;
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
      Class Procedure Freeze(Target:TMafiaRole);
      Procedure Skip;
      Class Procedure SpellDayShield(Target: TMafiaRole);
      Class Procedure SpellNightShield(Target: TMafiaRole);
      Class Procedure SpellTruth(Target: TMafiaRole);
      Class Procedure SpellSilent(Target: TMafiaRole);
      Class Procedure DemonDie(Target: TMafiaRole);
      Class Procedure AvatarDeath(Target: TMafiaRole);override;
  end;

  TWhiteLighter = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
      Procedure Heal(Sender: TMafiaRole);override;

  end;

  TMorokun = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;

  end;

  TAvatar = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
      Procedure Heal(Sender: TMafiaRole);override;

  end;

  TAgentFBI = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;

  end;

  TNarcoman = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;
      Procedure MakeNarcoman(Sender: TMafiaRole);override;
      Function IfJoinAvators: boolean;override;

  end;

  TAntiNarcoCop = class (TMafiaRole)
    Public
      Class Function WinningCondition:boolean;override;
      Class Function LosingCondition:boolean;override;
      Constructor Create;override;

  end;
const
  cMafia = 'Kill all your opponents and enemies';
  cBlackMafia1 = 'You are black mafia ¹1'#13#10'It is up to you to choose whom visit in the night'#13#10+cMafia;
  cBlackMafia2 = 'You are black mafia ¹2'#13#10'If clan leader dies, it will be up to you to choose whom visit in the night'#13#10+cMafia;
  cBlackMafia3 = 'You are black mafia ¹3'#13#10'If the rest of clan dies, it will be up to you to choose whom visit in the night'#13#10+cMafia;
  cRedMafia1 = 'You are Red mafia ¹1'#13#10'It is up to you to choose whom visit in the night'#13#10+cMafia;
  cRedMafia2 = 'You are Red mafia ¹2'#13#10'If clan leader dies, it will be up to you to choose whom visit in the night'#13#10+cMafia;
  cRedMafia3 = 'You are Red mafia ¹3'#13#10'If the rest of clan dies, it will be up to you to choose whom visit in the night'#13#10+cMafia;
  cBlackManiac = 'You are black Maniac'#13#10'You can go your own way so it is up to you to choose whom visit in the night.'#13#10'You must find and destroy the other maniac and all mafia';
  cRedManiac = 'You are Red Maniac'#13#10'You can go your own way so it is up to you to choose whom visit in the night.'#13#10'You must find and destroy the other maniac and all mafia';
  cAdvocat = 'You are advocat'#13#10'Free from prisons your friends';
  cDoctor = 'You are doctor'#13#10'You can save players'' lifes';
  cPolice = 'You are policeman'#13#10'Find and destroy all those mafiozi and maniacs';
  cDemon = 'You are DEMON!!!!'#13#10'You are lucky one. What will you do?';
  cWitch = 'You are WITCH!!!!'#13#10'You are lucky one. What will you do?';
  cWhiteLighter = 'You are WhiteLighter. Heal people and take care about witch';
  cMorokun = 'You are Morokun. Take care about whitelighter';
  cAvatar = 'You are AVATAR!!!!'#13#10'You are lucky one. Will you make an UTOPY?';
  cAgentFBI = 'You are agent FBI'#13#10'You have opportunity to kill avatars';
  cNarcoman = 'you are narco... Will you make all others also narcos?';
  cAntiNarcoCop = 'You are AntiDrugsCop. Take care about Narcomans';
var
  PlayersRoles: array [1..19] of TRole;
  RolesPlayers: array [1..19] of TMafiaRole;
  Roles : array [1..19] of TRole = (
    TBlackMafia1, TBlackMafia2, TBlackMafia3,
    TRedMafia1, TRedMafia2, TRedMafia3,
    TBlackManiac, TRedManiac, TAdvocat, TDoctor,
    TPolice, TDemon, TWitch, TWhiteLighter, TMorokun,
     TAvatar, TAgentFBI, TNarcoman, TAntiNarcoCop);
  RolesInfo : array [1..19] of string = (
    cBlackMafia1, cBlackMafia2, cBlackMafia3,
    cRedMafia1, cRedMafia2, cRedMafia3,
    cBlackManiac, cRedManiac, cAdvocat, cDoctor,
    cPolice, cDemon, cWitch, cWhiteLighter, cMorokun,
     cAvatar, cAgentFBI, cNarcoman, cAntiNarcoCop);
  CountOfRolesLeft:byte=19;
  CountOfAliveMembersOfBlackMafia,
  CountOfAliveMembersOfRedMafia, CountOfAliveAvatars,
  CountOfAlivePlayers, CountOfAliveNarcomans, CountOfZombies
  {,CountOfKilledPersons}:byte;
  {KilledPersons, }Players, NarcoMans, Avatars, Zombies: TMafiaRoleArray;
  BlackMafia, RedMafia: TMafias;
  MainRedMafia:TRedMafia;
  MainBlackMafia:TBlackMafia;
  BlackManiac:TBlackManiac;
  RedManiac:TRedManiac;
  Advocat:TAdvocat;
  Doctor:TDoctor;
  Policeman:TPolice;
  Demon:TDemon;
  Morokun:TMorokun;
  Agent:TAgentFBI;
  ANCop:TAntiNarcoCop;
  MainAvatar,NarcoDiler:TMafiaRole;
  Witch:TWitch;
  WhiteLighter:TWhiteLighter;
  User:TMafiaRole absolute Players[1];
  UseAvatarWinningConditions, UseNarcomanWinningConditions: Boolean;
Procedure DeleteRole(i:byte);
Function AutoChoose:byte;
Procedure ManualChoose;
Procedure DeFreeze;
Procedure DeSilent;
Procedure UnSpellNight;
Procedure UnSpellDay;

Procedure winlose;
Procedure EveryNight;
Procedure NarcoDilerEnable;
Procedure DelNarco(i: byte);
Procedure DelAvator(i: byte);
Function Utopy: boolean;
function FirstNotAvatarPerson: TMafiaRole;

function GetAlivePlayersNames: String;
function GetFullInfo: String;
function GetFullShortInfo: String;
implementation

uses umsg, uGoals, uObjectives, uCheat, uEventList;

var
  FUtopy:boolean=false;

constructor TMafiaRole.Create;
begin
  FDead := False;
  FNarcoman := False;
  FAvatar := False;
  FZombie := False;
  FNarcoImmune := False;
  FDeathImmune := False;
  FHangImmune := False;
  FUser := False;
  FShooted := False;
  FHanged := False;
  FDemonicKilled := False;
  FKilledByPolice := False;
  FDiedForSpell := False;
  FDiedForPoison := False;
  FKilledByMorokun := False;
  FDiedForDrugs := False;
  FFreezed := False;
  FSilent := False;
  FDayShield := False;
  FNightShield := False;
  FHasDrugs := False;
  FKiller := Nil;
  FOnDead := MafiaRoleOnDead
end;

{procedure TMafiaRole.NightKill;
begin
  if not FDeathImmune and not NightShield and not FDead then
    TryToKill
end;  }

procedure TMafiaRole.TryToKill;
begin
  FAttempted := True;
  FKiller := AKiller;
  If @FOnAttempt <> Nil then
    FOnAttempt(Self);
  //Inc(CountOfKilledPersons);
  //KilledPersons[CountOfKilledPersons]:=Self
end;

procedure TMafiaRole.ZombieAttack(AKiller: TMafiaRole);
begin
  if not NightShield and not FDead then begin
    FKilledByZombie := True;
    TryToKill(AKiller);
  end;
end;

procedure TMafiaRole.Hang;
begin
  if not FHangImmune and not DayShield and not FDead then
    begin
      FHanged := True;
      Death;
      {If @OnHang<>nil then
        OnHang(Self)}
    end
end;

procedure TMafiaRole.Imprison;
begin
  if MafiaOrManiac and not NightShield and not FDead then
    begin
      FKilledByPolice := True;
      TryToKill(AKiller);
//      FDead := True;
{      If @OnHang<>nil then
        OnHang(Self)}
    end
end;

procedure TMafiaRole.Shoot;
begin
  if not NightShield and not FDeathImmune and not FDead then
    begin
      FShooted := True;
      TryToKill(AKiller)
    end
end;

procedure TMafiaRole.Death;
begin
  FAttempted  := False;
  FDead := True;
  if @OnDead<>nil then
    OnDead(Self)
end;

procedure TMafiaRole.DemonicAttack;
begin
  if not NightShield and not FDeathImmune and not FDead then
    begin
      FDemonicKilled := True;
      TryToKill(AKiller)
    end
end;

procedure TMafiaRole.Morning;
var
  InfoString: String;
begin
  if Dead then
    Exit;
  if FAttempted and not FDead then begin
    Death;
    InfoString := Name + ' was killed and not healed in the night. ' + Info;
    EventList.AddDeath(FKiller, Self, 'Morning comes', InfoString);
    Msg.Memo1.Lines.Add(InfoString);
    if FUser then
      ShowMessage('You lost. You were killed and not healed in the night. ');
    Exit;
  end;
  if Narcoman or Zombie then begin
    if LifeSpan > 0 then
      Dec(FLifeSpan);
    if FLifeSpan = 0 then begin
      if Narcoman then begin
        FDiedForDrugs := True;
        DelNarco(NarcoNumber)
      end;
      Death;
    end
  end
end;

procedure TMafiaRole.MorokunAttack;
begin
  if not NightShield and not FDead and (self is TWhiteLighter) then
    begin
      FKilledByMorokun := True;
      TryToKill(AKiller)
    end

end;

procedure TMafiaRole.MakeNarcoman(Sender: TMafiaRole);
begin
  if not Sender.FDead and not Sender.FNarcoImmune then
    begin
      Sender.FNarcoman := True;
      Inc(CountOfAliveNarcomans);
      Sender.FNarcoNumber := CountOfAliveNarcomans;
      NarcoMans[CountOfAliveNarcomans] := Sender;
      Sender.FHasDrugs := True;
      Sender.LifeSpan := 5;

      PlayersGoals[Sender.Index].AdditionalNarcomansGoals.Assign(NarcomanGoals.PrimaryGoals);
      PlayersGoals[Sender.Index].FriendList.AddAcquaintances(Narcomans, 1, CountOfAliveNarcomans, 'Narcoman', True, True);
      ObjectivesForm.Memo3.Lines.Text := PlayersGoals[1].Info;
      if Sender.FAvatar then
        Inc(FLifeSpan, 2)
      else
        Inc(FLifeSpan, 1)
{      if Sender.FAvatar then
        MakeAvatarsNarcomans;}
    end
end;

procedure TMafiaRole.MakeZombie;
begin
  if not FDead then
    Exit;
  FDead := True;
  FZombie := True;
  FNarcoImmune := True;
  FDeathImmune := True;
  FHangImmune := True;
  FLifeSpan := 5;
  Inc(CountOfZombies);
  FZombieIndex := CountOfZombies;
  Zombies[CountOfZombies] := Self;
end;

procedure TMafiaRole.HealNarcoman(Sender: TMafiaRole);
begin
  if not Sender.FDead and Sender.FNarcoman and not (Sender is TNarcoman) then
    begin
      Sender.FNarcoman := False;
      DelNarco(Sender.NarcoNumber)
    end
end;

procedure TMafiaRole.MakeAvatarsNarcomans;
var
  j:byte;
begin
  for j := 1 to CountOfAliveAvatars do
    if not Avatars[j].FNarcoman then
      MakeNarcoman(Avatars[j]);
end;

{procedure TMafiaRole.Murder(Sender: TMafiaRole);
begin
  Sender.Kill
end;   }

procedure TMafiaRole.Heal(Sender: TMafiaRole);
begin
  if Sender.FDead then begin
    Inc(CountOfAlivePlayers);
  end;

  Sender.FAttempted  := False;
  Sender.FDead  := False;
  Sender.FKilledByPolice  := False;
  Sender.FShooted  := False;
  Sender.FHanged  := False;
  Sender.FDemonicKilled  := False;
  Sender.FDiedForSpell  := False;
  Sender.FDiedForPoison  := False;
  Sender.FDiedForDrugs  := False;
  Sender.FKilledByMorokun  := False;
end;


function TMafiaManiac.MafiaOrManiac: boolean;
begin
  result:=true
end;

{Procedure TMafiaManiac.Murder(Sender: TMafiaRole);
begin
  Sender.FShooted := True;
  Sender.Kill;
end;   }

Procedure TAdvocat.Heal(Sender: TMafiaRole);
begin
  if Sender.FKilledByPolice and not Sender.FShooted and not Sender.FDemonicKilled and not Sender.FHanged
   and not Sender.FDiedForSpell and not Sender.FDiedForPoison and not Sender.FKilledByMorokun then
    Inherited
end;

Procedure TDoctor.Heal(Sender: TMafiaRole);
begin
  if not Sender.FKilledByPolice and Sender.FShooted and not Sender.FDemonicKilled and not Sender.FHanged
   and not Sender.FDiedForSpell and not Sender.FDiedForPoison and not Sender.FKilledByMorokun then
    Inherited
end;

Procedure TWhiteLighter.Heal(Sender: TMafiaRole);
begin
  if not Sender.FHanged and not Sender.FDiedForSpell and not Sender.FDiedForPoison then
  Inherited
end;

Procedure TAvatar.Heal(Sender: TMafiaRole);
begin
  Inherited
end;

procedure TNarcoman.MakeNarcoman(Sender: TMafiaRole);
begin
  Inherited
end;

Procedure DeleteRole(i:byte);
var
  j:byte;
begin
  Dec(CountOfRolesLeft);
  for j:=i to CountOfRolesLeft do
    Roles[j]:=Roles[j+1]
end;


Function AutoChoose;
var
  i: byte;
begin
  i := Random(19)+1;
  User := Roles[i].Create;
  DeleteRole(i);
  Result := i;
  User.RoleIndex := i;
  ManualChoose;
end;

Procedure ManualChoose;
var
  i, j: byte;
begin
  User.Name := 'User';
  User.FUser := True;
  CountOfAliveMembersOfBlackMafia := 3;
  CountOfAliveMembersOfRedMafia := 3;
  CountOfAliveAvatars := 1;
  CountOfAlivePlayers := 19;
  CountOfAliveNarcomans := 1;
  CountOfZombies := 0;
  PlayersRoles[1] := TRole(User.ClassType);
//  RolesPlayers[1]:=TRole(User.ClassType);
  PlayersGoals[1] := TPlayerGoals.Create;
  PlayersGoals[1].MafiaRole := User;
  User.Index := 1;

  for j := 2 to 19 do begin
    i := Random(CountOfRolesLeft) + 1;
    Players[j] := Roles[i].Create;
    Players[j].Name := 'Player'+inttostr(j);
    Players[j].Index := j;
    Players[j].RoleIndex := i;
    PlayersRoles[j] := Roles[i];
    PlayersGoals[j] := TPlayerGoals.Create;
    PlayersGoals[j].MafiaRole := Players[j];
    DeleteRole(i)
  end;
  GoalsInit;
end;

constructor TBlackMafia1.Create;
begin
  inherited;
  MainBlackMafia:=Self;
  BlackMafia[1]:=Self
end;

constructor TBlackMafia2.Create;
begin
  inherited;
  BlackMafia[2]:=Self
end;

constructor TBlackMafia3.Create;
begin
  inherited;
  BlackMafia[3]:=Self
end;

constructor TRedMafia1.Create;
begin
  inherited;
  MainRedMafia:=Self;
  RedMafia[1]:=Self
end;

constructor TRedMafia2.Create;
begin
  inherited;
  RedMafia[2]:=Self
end;

constructor TRedMafia3.Create;
begin
  inherited;
  RedMafia[3]:=Self
end;

constructor TBlackManiac.Create;
begin
  inherited;
  BlackManiac:=Self
end;

constructor TRedManiac.Create;
begin
  inherited;
  RedManiac:=Self
end;

constructor TAdvocat.Create;
begin
  inherited;
  Advocat:=Self
end;

constructor TDoctor.Create;
begin
  inherited;
  Doctor:=Self
end;

constructor TPolice.Create;
begin
  inherited;
  PoliceMan:=Self
end;

constructor TDemon.Create;
begin
  inherited;
  FNarcoImmune := True;
  FDeathImmune := True;
  FHangImmune := True;
  NickName := 'Demon';
  Demon:=Self
end;

class procedure TWitch.AvatarDeath(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,20);
  inherited
end;

constructor TWitch.Create;
begin
  inherited;
  FDif := 1;
  FNarcoImmune := True;
  FDayShield := True;
  FNightShield := True;
  FPower := 0;
  NickName := 'Witch';
  if CheatsEnabled then
    FPower := 255;
  Witch := Self
end;

constructor TWhiteLighter.Create;
begin
  inherited;
  FNarcoImmune := True;
  FDeathImmune := True;
  FDayShield := True;
  NickName := 'WhiteLighter';
  WhiteLighter := Self
end;

constructor TMorokun.Create;
begin
  inherited;
  FNarcoImmune := True;
  NickName := 'Morokun';
  Morokun := Self
end;

constructor TAvatar.Create;
begin
  inherited;
  FAvatar := True;
  FDeathImmune := True;
  FHangImmune := True;
  MainAvatar:=Self;
  FAvatorNumber:=1;
  NickName := 'Avatar Leader';
  AvatarName := 'Avatar Leader';
  Avatars[1] := Self
end;

constructor TAgentFBI.Create;
begin
  inherited;
  Agent:=Self
end;

constructor TNarcoman.Create;
begin
  inherited;
  FNarcoman := True;
  FHasDrugs := True;
  FNarcoNumber:=1;
  FLifeSpan := 5;
  Narcodiler:=self;
  NickName := 'NarcoDiler';
  Narcomans[1]:=Self
end;

constructor TAntiNarcoCop.Create;
begin
  inherited;
  ANCop:=Self
end;

class function TBlackMafia.LosingCondition: boolean;
begin
  result:=CountOfAliveMembersOfBlackMafia=0
end;

Function NextAliveBlackMafia: TBlackMafia;
var
  j:byte;
begin
  Result:=nil;
  for j:=1 to 3 do
    if BlackMafia[j].Alive then
      begin
        Result := BlackMafia[j] as TBlackMafia;
        Exit
      end
end;

procedure TBlackMafia.MafiaRoleOnDead(Sender: TMafiaRole);
begin
  Inherited;
  Dec(CountOfAliveMembersOfBlackMafia);
  if Sender=MainBlackMafia then
    MainBlackMafia:=NextAliveBlackMafia
end;

class function TBlackMafia.WinningCondition: boolean;
begin
//  if  then

  result:=(CountOfAliveMembersOfRedMafia=0)
  and BlackManiac.FDead and RedManiac.FDead and Policeman.fdead
end;

class function TRedMafia.LosingCondition: boolean;
begin
  result:=CountOfAliveMembersOfRedMafia=0
end;

Function NextAliveRedMafia:TRedMafia;
var
  j:byte;
begin
  Result:=nil;
  for j:=1 to 3 do
    if RedMafia[j].Alive then
      begin
        Result := RedMafia[j] as TRedMafia;
        Exit
      end
end;

procedure TRedMafia.MafiaRoleOnDead(sender: TMafiaRole);
begin
  Inherited;
  Dec(CountOfAliveMembersOfRedMafia);
  if Sender=MainRedMafia then
    MainRedMafia:=NextAliveRedMafia
end;

class function TRedMafia.WinningCondition: boolean;
begin
  result:=(CountOfAliveMembersOfBlackMafia=0)
  and BlackManiac.FDead and RedManiac.FDead and Policeman.fdead
end;

class function TBlackManiac.LosingCondition: boolean;
begin
  result:=BlackManiac.FDead
end;

class function TBlackManiac.WinningCondition: boolean;
begin
  result:=(CountOfAliveMembersOfRedMafia=0)
  and (CountOfAliveMembersOfBlackMafia=0)
  and RedManiac.FDead
end;

class function TRedManiac.LosingCondition: boolean;
begin
  result:=RedManiac.FDead
end;

class function TRedManiac.WinningCondition: boolean;
begin
  result:=(CountOfAliveMembersOfRedMafia=0)
  and (CountOfAliveMembersOfBlackMafia=0)
  and BlackManiac.FDead
end;

Function AllMafiaManiacsDead:boolean;
begin
  result:=(CountOfAliveMembersOfRedMafia=0)and
  (CountOfAliveMembersOfBlackMafia=0)
  and BlackManiac.FDead and RedManiac.FDead
end;

class function TAdvocat.LosingCondition: boolean;
begin
  result:=Advocat.Dead or AllMafiaManiacsDead
end;

class function TAdvocat.WinningCondition: boolean;
begin
  result:=not LosingCondition and
   Policeman.FDead and Doctor.FDead
end;

class function TDoctor.WinningCondition: boolean;
begin
  Result:=AllMafiaManiacsDead and not LosingCondition
end;

class function TDoctor.LosingCondition: boolean;
begin
  Result:=Doctor.Dead or Agent.Dead or ANCop.Dead
end;

class function TAgentFBI.LosingCondition: boolean;
begin
  Result:=Agent.Dead or (CountOfAliveAvatars>9)
end;

class function TAgentFBI.WinningCondition: boolean;
begin
  result:=not LosingCondition and AllMafiaManiacsDead and
  (CountOfAliveAvatars=0)
end;

class function TAntiNarcoCop.LosingCondition: boolean;
begin
  result:=ANCop.Dead or ANCop.FNarcoman
end;

class function TAntiNarcoCop.WinningCondition: boolean;
begin
  result:=not LosingCondition and (CountOfAliveNarcomans=0)
end;

class function TAvatar.WinningCondition: boolean;
begin
  result:=CountOfAlivePlayers=CountOfAliveAvatars
end;

class function TAvatar.LosingCondition: boolean;
begin
  result:=CountOfAliveAvatars=0
end;

class function TDemon.LosingCondition: boolean;
begin
  result:=Demon.Dead
end;

class function TDemon.WinningCondition: boolean;
begin
  result:=(Not Demon.FAvatar and (CountOfAliveAvatars=0))
  or (Demon.FAvatar and TAvatar.WinningCondition)
end;

class function TMorokun.LosingCondition: boolean;
begin
  result:=Morokun.Dead
end;

class function TMorokun.WinningCondition: boolean;
begin
  result:=WhiteLighter.Dead
end;

class function TPolice.LosingCondition: boolean;
begin
  result:=Policeman.Dead
end;

class function TPolice.WinningCondition: boolean;
begin
  result:=not LosingCondition and AllMafiaManiacsDead
end;

class function TWhiteLighter.WinningCondition: boolean;
begin
  result := Morokun.Dead and Demon.Dead and not LosingCondition
end;

class procedure TWitch.DemonDie(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,10);
  if Target is TDemon then
    begin
      Target.FDiedForSpell := True;
      Target.TryToKill(Witch);
    end
end;

class procedure TWitch.Freeze(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,2);
  Target.FFreezed:=true
end;

class function TWitch.LosingCondition: boolean;
begin
  result := Witch.Dead
end;

procedure TWitch.Skip;
begin
  if FPower+FDif>255 then
    FPower:=255
  else
    Inc(FPower,FDif);
  if 2*FDif>255 then
    FDif:=255
  else
    FDif:=2*FDif;
end;

class procedure TWitch.SpellDayShield(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,7);
  Target.FDayShield:=true
end;

class procedure TWitch.SpellNightShield(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,5);
  Target.FNightShield:=true
end;

class procedure TWitch.SpellSilent(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,1);
  Target.FSilent:=true
end;

class procedure TWitch.SpellTruth(Target: TMafiaRole);
begin
  Witch.FDif:=1;
  Dec(Witch.FPower,3);
  {if FUser then
    Target.Info}
end;

class function TWitch.WinningCondition: boolean;
begin
  result:=not LosingCondition and
  (Not Witch.FAvatar and (CountOfAliveAvatars=0) and Demon.Dead)
  or (Witch.FAvatar and TAvatar.WinningCondition)
end;

class function TWhiteLighter.LosingCondition: boolean;
begin
  result:=WhiteLighter.Dead or Witch.Dead
end;

class function TNarcoman.WinningCondition: boolean;
begin
  result:=CountOfAlivePlayers=CountOfAliveNarcomans
end;

class function TNarcoman.LosingCondition: boolean;
begin
  result:=(CountOfAliveNarcomans=0)and(CountOfAlivePlayers>0)
end;

function TMafiaRole.Alive: boolean;
begin
  result := not FDead
end;

procedure DeFreeze;
var
  j:byte;
begin
  for j:=1 to 19 do
    Players[j].FFreezed := False
end;

procedure DeSilent;
var
  j:byte;
begin
  for j:=1 to 19 do
    Players[j].FSilent := False
end;

procedure UnSpellDay;
var
  j:byte;
begin
  for j:=1 to 19 do
    Players[j].FDayShield := False
end;

procedure UnSpellNight;
var
  j:byte;
begin
  for j:=1 to 19 do
    Players[j].FNightShield := False
end;

Function TMafiaRole.Info;
var
  s:string;
begin
  s:=Name;
  if FUser then
    s:=s+' is user controlled, '
  else
    s:=s+' is computer controlled, ';
  if FAttempted then
    s:=s+'attempted, ';
  if FFreezed then
    s:=s+'freezed, ';
  if FDayShield then
    s:=s+'under day shield, ';
  if FNightShield then
    s:=s+'under night shield, ';
  if FSilent then
    s:=s+'under silence spell, ';
  if FCleared then
    s:=s+'cleared, ';
  if FKilledByMorokun then
    s:=s+'killed by morokun, ';
  if FUnSleep then
    s:=s+'doesn''t sleep now, ';
  if FHasDrugs then
    s:=s+'has drugs, ';
  if FNarcoman and not FHasDrugs then
    s:=s+'doesn''t have drugs, ';
  if FLifeSpan > 0 then
    s:=Format('%s has %d days left, ', [s, FLifeSpan]);
  if FShooted then
    s:=s+'shooted, ';
  if FHanged then
    s:=s+'hanged, ';
  if FDemonicKilled then
    s:=s+'died by demonical death, ';
  if FKilledByPolice then
    s:=s+'killed by police, ';
  if FDiedForSpell then
    s:=s+'killed by witch, ';
  if FDiedForPoison then
    s:=s+'killed by antiavatar poison, ';
  if FDiedForDrugs then
    s:=s+'killed by her passion (drugs), ';
  if FDead then
    s:=s+'dead, '
  else
    s:=s+'alive, ';
  if FNarcoman then
    s:=s+'drugs adicted, ';
  if FAvatar then
    s:=s+'avatar, ';
  if FZombie then
    s:=s+'zombie, ';
  if FNarcoImmune then
    s:=s+'has immunity for drugs, ';
  if FDeathImmune then
    s:=s+'has immunity for night deaths, ';
  if FHangImmune then
    s:=s+'has immunity for day deaths, ';
  result:=s+' her classtype is '+ClassName
end;

function TMafiaRole.ShortInfo;
var
  s:string;
begin
  s := Name + '[' + ClassName + ']';
  if FUser then
    s := s + 'user, '
  else
    s := s + ' comp, ';
  if FDead then
    s := s + 'dead, '
  else
    s := s + 'alive, ';
  if FAttempted then
    s := s + 'attempted, ';
  if FFreezed then
    s := s + 'freezed, ';
  if FDayShield then
    s := s + 'under day shield, ';
  if FNightShield then
    s := s + 'under night shield, ';
  if FSilent then
    s := s + 'silent, ';
  if FCleared then
    s := s + 'cleared, ';
  if FKilledByMorokun then
    s := s + 'killed by morokun, ';
  if FUnSleep then
    s := s + 'doesn''t sleep now, ';
  if FHasDrugs then
    s := s + 'has drugs, ';
  if FNarcoman and not FHasDrugs then
    s := s + 'doesn''t have drugs, ';
  if FLifeSpan > 0 then
    s := Format('%s has %d days left, ', [s, FLifeSpan]);
  if FShooted then
    s := s + 'shooted, ';
  if FHanged then
    s := s + 'hanged, ';
  if FDemonicKilled then
    s := s + 'died by demon, ';
  if FKilledByPolice then
    s := s + 'killed by police, ';
  if FDiedForSpell then
    s := s + 'killed by witch, ';
  if FDiedForPoison then
    s := s + 'killed by antiavatar poison, ';
  if FDiedForDrugs then
    s := s + 'killed by drugs, ';
  if FNarcoman then
    s := s + 'drugs adicted, ';
  if FAvatar then
    s := s + 'avatar, ';
  if FZombie then
    s := s + 'zombie, ';
  if FNarcoImmune then
    s := s + 'has immunity for drugs, ';
  if FDeathImmune then
    s := s + 'has immunity for night deaths, ';
  if FHangImmune then
    s := s + 'has immunity for day deaths, ';
  Result := s;
end;

class procedure TMafiaRole.AvatarDeath(Target: TMafiaRole);
begin
  if Target.FAvatar then
    begin
      Target.FDiedForPoison := True;
      Target.Death;
    end
end;

procedure NarcoDilerEnable;
begin
  if NarcoDiler<>nil then
    if NarcoDiler.Alive then
      NarcoDiler.FHasDrugs:=true
end;

procedure winlose;
begin
//  if
end;

function TMafiaRole.MafiaOrManiac: boolean;
begin
  result := False
end;

procedure TMafiaRole.MafiaRoleOnDead(sender: TMafiaRole);
var
  InfoString: String;
begin
  if FNarcoman then begin
    DelNarco(FNarcoNumber);
    if Assigned(FKiller) then
      if FKiller.Alive then begin
        MakeNarcoman(FKiller);
        if FKiller.FUser then
          InfoString := 'Vendetta!!! You killed a narcoman. Take a repent! Welcome to drugs-addicted community!'
        else
          InfoString := 'Vendetta!!! Someone killed a narcoman and takes a repent and is welcomed to drugs-addicted community!';
        MSG.Memo1.Lines.Add(InfoString);
        EventList.AddDeath(Self, FKiller, 'Vendetta!!!', InfoString);
      end;
  end;
  if FAvatar then
    DelAvator(FAvatorNumber);
  if CountOfAlivePlayers = 0 then
    raise Exception.Create('Are you trying to kill a dead man?');
  
  Dec(CountOfAlivePlayers)
end;

procedure EveryNight;
var
  i: byte;
begin
  for i := 1 to 19 do
    Players[i].Morning;

end;

procedure DelNarco(i: byte);
var
  j:byte;
begin
  if CountOfAliveNarcomans = 0 then
    ShowMessage('Error - Probably all narcomans are already dead and you are trying to kill a dead narco???');


  if NarcoMans[i] = NarcoDiler then
    if i < CountOfAliveNarcomans then
      NarcoDiler := NarcoMans[i + 1]
    else
      NarcoDiler := Nil;
  if CountOfAliveNarcomans > 0 then
    Dec(CountOfAliveNarcomans);
  for j := i to CountOfAliveNarcomans do
    NarcoMans[j] := NarcoMans[j + 1];
  for j := i to CountOfAliveNarcomans do
    NarcoMans[j].FNarcoNumber := j
end;

procedure DelAvator(i: byte);
var
  j:byte;
begin
  if Avatars[i]=MainAvatar then
    if i<CountOfAliveAvatars then
      MainAvatar:=Avatars[i+1]
    else
      MainAvatar:=nil;
  Dec(CountOfAliveAvatars);
  for j:=i to CountOfAliveAvatars do
    Avatars[j]:=Avatars[j+1];
  for j:=i to CountOfAliveAvatars do
    Avatars[j].FAvatorNumber:=j
end;

procedure TMafiaRole.TakeOffDrugs;
begin
  FHasDrugs := False
end;

class procedure TMafiaRole.AvatorHeal(Sender: TMafiaRole);
begin
  MainAvatar.Heal(Sender);
end;

class procedure TMafiaRole.AvatorJoinUs(Sender: TMafiaRole);
begin
  Sender.BeAvator
end;

class procedure TMafiaRole.AvatorMakeUtopy(Sender: TMafiaRole);
begin
  FUtopy:=true
end;

class procedure TMafiaRole.AvatorClear(Sender: TMafiaRole);
begin
  Sender.Clear(MainAvatar);
end;

procedure TMafiaRole.LeaveAvators;
begin
  FAvatar := False;
  DelAvator(FAvatorNumber)
end;

procedure TMafiaRole.BeAvator;
begin
  if FUser then
    if MessageBox(0,'Join avators?','Avatars ask u to join them',32+4)=idYes then
      begin
        JoinAvators;
        ShowMessage('You have joined the avators!')
      end
    else
      ShowMessage('You have rejected their propose. You will be cleared')
  else
    if IfJoinAvators then
      JoinAvators
end;

procedure TMafiaRole.JoinAvators;
begin
  FAvatar := True;
  Inc(CountOfAliveAvatars);
  FAvatorNumber := CountOfAliveAvatars;
  AvatarName := 'Avatar [' + IntToStr(FAvatorNumber) + '] ';
  Avatars[CountOfAliveAvatars] := Self;
  FNarcoImmune := False;
  FDeathImmune := True;
  FHangImmune := True;
  if FNarcoman then
    MakeAvatarsNarcomans;

  PlayersGoals[Index].AdditionalAvatarsGoals.Assign(PlayersGoals[MainAvatar.Index].PrimaryGoals);
  try
  PlayersGoals[Index].FriendList.AddAcquaintances(Avatars, 1, CountOfAliveAvatars, 'Avatar', True, True);
  except
  on E: Exception do
    ShowMessage(E.Message + #13#10 + Format('%d', [Index]));

  end;
  ObjectivesForm.Memo3.Lines.Text := PlayersGoals[1].Info;
end;

function TMafiaRole.IfJoinAvators: boolean;
begin
  result:=Random(2)=1
end;

function Utopy: boolean;
begin
  Utopy:=FUtopy
end;

procedure TMafiaRole.Clear;
begin
  FCleared := True;
  Death;
  // TODO: Here should be cleared this from game list
end;

function FirstNotAvatarPerson: TMafiaRole;
var
  j:byte;
begin
  Result:=nil;
  for j:=1 to 19 do
    if Players[j].Alive then
      if not Players[j].Avatar then
        Result:=Players[j]
end;

function TMafiaRole.Aim: string;
begin
  if alive then
    Aim:='To survive - succeed'
  else
    Aim:='To survive - failed'
end;

function TAdvocat.Aim: string;
begin
  aim:=TMafiaRole(advocat).aim;
  result:=result+#13#10'Count of alive red mafia '+inttostr(CountOfAliveMembersOfRedMafia)+
  #13#10'Count of alive black mafia '+inttostr(CountOfAliveMembersOfBlackMafia)+
  #13#10'black maniac '+blackManiac.Status + #13#10'Black maniac '+BlackManiac.Status;
  if Doctor.Alive then
    result:=result+'To kill doctor - failed'
  else
    result:=result+'To kill doctor - succeed';
  if Policeman.Alive then
    result:=result+'To kill policeman - failed'
  else
    result:=result+'To kill policeman - succeed';
end;

function TMafiaRole.Status: string;
begin
  if alive then
    status:='alive'
  else
    status:='dead'
end;

function TNarcoman.IfJoinAvators: boolean;
begin
  result:=true
end;

function GetAlivePlayersNames: String;
{var
  i,j:byte;}
begin
{  //ap.Items.Clear;
  i:=1;
  Result := '';
  for j:=1 to 19 do
    if not Players[j].Dead then
      begin
        ap.Items.Add(Players[j].Name);
        apl[i]:=Players[j];
        Inc(i);
      end }
end;

function GetFullInfo: String;
var
  i: byte;
begin
  Result := Players[1].Info;
  for i := 2 to 19 do
    Result := Result + #13#10 + Players[i].Info;
end;

function GetFullShortInfo: String;
var
  i: byte;
begin
  Result := Players[1].ShortInfo;
  for i := 2 to 19 do
    Result := Result + #13#10 + Players[i].ShortInfo;
end;


initialization
  UseAvatarWinningConditions := False;
  UseNarcomanWinningConditions := False;
end.
