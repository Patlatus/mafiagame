unit Unit1;

interface

uses
  Windows, Messages, STDCTRLS, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, usPolice, MafiaDef;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MafiaProcess(Count: Byte; MafiaClass: TRole; MafiaNickName: String; Leader: TMafia; Mafias: TMafias);
    procedure ManiacProcess(MafiaClass: TRole; MafiaNickName: String;  Leader: TManiac);
    procedure PoliceProcess(MafiaNickName: String; Leader: TMafiaRole; Form: TUserPolice; ActionCount: Byte);
    Procedure ShowPlayers;
    Procedure DayFirst;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  published
    procedure VoteProcess;
    procedure AccuseProcess;
    procedure HangProcess;
  end;

var
  Form1: TForm1;
  B,H,S:TBitmap;
  day:longint=1;
  Accused:array[1..3] of TMafiaRole;
  Hanged:TMafiaRole;
  Votes,Labels:array[1..3] of TLabel;
  Vot:array[1..3]of byte;
  CurrentAccusation:byte=1;
  CurrentPlayer:byte=1;
  cycled:boolean=false;
  Night:boolean=false;
Function MaxIndex:byte;
implementation

uses OUnit, uday, uac, uvote, umsg, usVote, uWitch, usMafia,
  usAgent, usDemon, usANCop, usMorokun, usWL, usDoctor, usAdvo,
  usNarcoDiler, usNarcoMan, usAvator, Unit2, uEventList, uCheat, uObjectives,
  uGoals;

{$R *.dfm}

function WinCondition: Boolean;
begin
  if UseAvatarWinningConditions then
    Result := TAvatar.WinningCondition
  else
    if UseNarcomanWinningConditions then
      Result := TNarcoman.WinningCondition
    else
      Result := User.WinningCondition
end;

Procedure TForm1.ShowPlayers;
var
  i:byte;
begin
  for i:=2 to 19 do
    if players[i].dead then
      Image1.Canvas.Draw(((i-2) mod 6)*b.Width,((i-2) div 6)*150,H)
    else
      if night and not players[i].UnSleep then
        Image1.Canvas.Draw(((i-2) mod 6)*b.Width,((i-2) div 6)*150,S)
      else
        Image1.Canvas.Draw(((i-2) mod 6)*b.Width,((i-2) div 6)*150,B);
//;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if OForm.ShowModal=mrOk then
    begin
      ShowPlayers;
  Labels[1]:=Vote.Label1;
  Labels[2]:=Vote.Label2;
  Labels[3]:=Vote.Label3;
  Votes[1]:=Vote.Vote1;
  Votes[2]:=Vote.Vote2;
  Votes[3]:=Vote.Vote3;
      if day=1 then
        begin
          DayFirst;
        end
{      repeat
      until}
    end
  else
    application.terminate
end;

procedure TForm1.HangProcess;
var
  InfoString: string;
begin
  //Процедура повішення
  Hanged:=Accused[MaxIndex];
  Hanged.Hang;

  if Hanged.Dead then
    InfoString := Hanged.Name+' was hanged. '+Hanged.info
  else
    if Hanged.HangImmune then
      InfoString := Hanged.Name+' wasn''t hanged, he has aspecial immunity from it'
    else
      if Hanged.DayShield then
        InfoString := Hanged.Name+' wasn''t hanged, he was spelled with aspecial day shield'
      else
        InfoString := Hanged.Name+' wasn''t hanged, INTERNAL ERROR';



  MSG.Memo1.lines.Add(InfoString);
  ShowMessage(InfoString);
  if Hanged.Dead then
    EventList.AddHanging(Hanged, 'hanged', InfoString)
  else
    EventList.AddHangingTry(Hanged, 'not hanged', InfoString);

  if User.Dead then
    begin
      ShowMessage('You was hanged. You lost');
      Close
    end;
  ShowPlayers;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Randomize;
  B:=TBitmap.Create;
  H:=TBitmap.Create;
  s:=TBitmap.Create;
  B.Handle:=LoadBitmap(hinstance,'BILLI');
  //H.Handle:=LoadBitmap(hinstance,'BMASK');
  H.Handle:=LoadBitmap(hinstance,'EYES'{'SLEEPS'}); //31 37
  S.Assign(B);
  S.Canvas.Draw(31, 37, H);
  H.Handle:=LoadBitmap(hinstance,'BMASK');
  //.Handle:=LoadBitmap(hinstance, 'SLEEPS'); //31 37  B.SaveToFile('Billi.bmp');
  h.SaveToFile('bmask1.bmp');
  s.SaveToFile('bsleeps1.bmp');
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssShift in Shift) and (ssCtrl in Shift) and (Char(Key)='C')) then begin
    CheatsEnabled := True;
    //CheatForm.Show;
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if y div 150>2 then y:=300;
  Hint:='Player'+inttostr((y div 150)*6+x div b.Width+2)
end;

procedure TForm1.MafiaProcess(Count: Byte; MafiaClass: TRole; MafiaNickName: String; Leader: TMafia; Mafias: TMafias);
begin
  if Count > 0 then
    if not Leader.Freezed then begin
      UserMafia.Player := Leader;
      UserMafia.Mafia := MafiaClass;
      if Leader.UserControlled then begin
        Mafias[1].UnSleep:=true;
        Mafias[2].UnSleep:=true;
        Mafias[3].UnSleep:=true;
        ShowPlayers;
        UserMafia.showmodal
      end else begin
        UserMafia.renew;
        if Mafias[1].UserControlled or Mafias[2].UserControlled or
            Mafias[3].UserControlled then begin
          Mafias[1].UnSleep:=true;
          Mafias[2].UnSleep:=true;
          Mafias[3].UnSleep:=true;
          ShowPlayers;
          ShowMessage('Look into my eyes...');
          SLeep(2000);
        end;
        if Random(2)=1 then begin
          UserMafia.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMafia.AC.ItemIndex:=random(3);
          UserMafia.Button1Click(nil);
        end else
          UserMafia.Button2Click(nil);
      end
    end else begin
      MSG.Memo1.Lines.Add(MafiaNickName + ' couldn''t do their functions because their leader is freezed by witch');
      EventList.AddMoveMiss(Leader, 'WitchSpell', MafiaNickName + ' couldn''t do their functions because their leader is freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add(MafiaNickName + ' is banquished');
    EventList.AddMoveMiss(Leader, 'Dead', MafiaNickName + ' is banquished')
  end;

  Mafias[1].UnSleep:=false;
  Mafias[2].UnSleep:=false;
  Mafias[3].UnSleep:=false;
  ShowPlayers;
end;

procedure TForm1.ManiacProcess;
begin
  if Leader.Alive then
    if not Leader.Freezed then begin
      UserMafia.Player := Leader;
      UserMafia.Mafia := MafiaClass;
      if Leader.UserControlled then begin
        UserMafia.showmodal
      end else begin
        UserMafia.renew;
        if Random(2)=1 then begin
          UserMafia.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMafia.AC.ItemIndex:=random(3);
          UserMafia.Button1Click(nil);
        end else
          UserMafia.Button2Click(nil);
      end
    end else begin
      MSG.Memo1.Lines.Add(MafiaNickName + ' couldn''t do her functions because was freezed by witch');
      EventList.AddMoveMiss(Leader, 'WitchSpell', MafiaNickName + ' couldn''t do her functions because was freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add(MafiaNickName + ' is banquished');
    EventList.AddMoveMiss(Leader, 'Dead', MafiaNickName + ' is banquished')
  end;
end;

procedure TForm1.PoliceProcess(MafiaNickName: String; Leader: TMafiaRole; Form: TUserPolice; ActionCount: Byte);
begin
  Form.Player := Leader;
  if Leader.Alive then
  if not Leader.Freezed then
  If Leader.UserControlled then
    Form.Showmodal
  else
    begin
      Form.renew;
      if Random(2)=1 then
        begin
          Form.AC.ItemIndex:=random(ActionCount);
          Form.AP.ItemIndex:=Random(CountOfAlivePlayers);
          Form.Button1Click(nil);
        end
      else
        Form.Button2Click(nil);
    end
  else begin
      MSG.Memo1.Lines.Add(MafiaNickName + ' couldn''t do her functions because was freezed by witch');
      EventList.AddMoveMiss(Leader, 'WitchSpell', MafiaNickName + ' couldn''t do her functions because was freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add(MafiaNickName + ' is banquished');
    EventList.AddMoveMiss(Leader, 'Dead', MafiaNickName + ' is banquished')
  end;
end;

procedure TForm1.AccuseProcess;
var
  RndPl: byte;
  Current, RandomAccusedPlayer: TMafiaRole;
begin
  //Процедура звинувачення
  while (CurrentAccusation < 4) and not TotalStop do begin
    Current := Players[CurrentPlayer];
    if not Current.Dead and not Current.Silent and not Current.Zombie then
      if CurrentPlayer = 1 then begin
        if Accuse.ShowModal = mrAbort then
          begin
            Accused[CurrentAccusation] := accuse.AccusedPlayer;
            Labels[CurrentAccusation].Caption := Accuse.AccusedPlayer.Name;
            Inc(CurrentAccusation)
          end else begin
            MSG.Memo1.lines.Add(User.name + ' doesn''t accuse anyone');
            EventList.AddMoveMiss(User, 'Decision', User.name + ' doesn''t accuse anyone')
          end;
        if totalstop then
          Exit;
      end else begin
        if Random(2) = 0 then begin
          MSG.Memo1.lines.Add(Current.Name + ' doesn''t accuse anyone');
          EventList.AddMoveMiss(Current, 'Decision', Current.Name + ' doesn''t accuse anyone')
        end
        else begin
          RndPl := Random(CountOfAlivePlayers) + 1;
          RandomAccusedPlayer := Apl[RndPl];
          Accuse.AC.ItemIndex := Random(8);
          MSG.Memo1.lines.Add(Current.Name + ' claims: ' + RandomAccusedPlayer.Name +
            ' - ' + Accuse.Accusation);
          Accused[CurrentAccusation] := RandomAccusedPlayer;
          Labels[CurrentAccusation].Caption := RandomAccusedPlayer.Name;
          Inc(CurrentAccusation);
          EventList.AddAccusation(Current, RandomAccusedPlayer, Accuse.Accusation,
            Current.Name + ' claims: ' + RandomAccusedPlayer.Name + ' - ' + Accuse.Accusation)
        end;
      end
    else
      if Current.Alive and Current.Silent then begin
        MSG.Memo1.lines.Add(Current.Name + ' cannot claim anything because she is under a spell SILENCE');
        EventList.AddMoveMiss(Current, 'UnderSpell', Current.Name + ' cannot claim anything because she is under a spell SILENCE')
      end else
        if Current.Alive and Current.Zombie then begin
          MSG.Memo1.lines.Add(Current.Name + ' cannot claim anything because she is Zombie!!!');
          EventList.AddMoveMiss(Current, 'Zombie', Current.Name + ' cannot claim anything because she is Zombie!!!')
        end else begin
          MSG.Memo1.lines.Add(Current.Name + ' cannot claim anything due to internal program error (Bug?)');
          EventList.AddMoveMiss(Current, 'Bug', Current.Name + ' cannot claim anything due to internal program error (Bug?)')
        end;
    Inc(CurrentPlayer);
    If CurrentPlayer = 20 then
      CurrentPlayer := 1
  end;
end;

procedure TForm1.DayFirst;
begin
  DayForm.Memo1.text := 'So day first. Nobody knows each other, but everybody must select three victims and to hang somebody from them';
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  if cycled then
    Exit;
  cycled:=true;
  timer1.Enabled:=true;
end;

Function MaxIndex:byte;
var
  m,max,i:byte;
begin
  m:=1;
  max:=Vot[1];
  for i:=2 to 3 do
    if Vot[i]>max then
      begin
        Max:=Vot[i];
        m:=i
      end;
  Result:=m
end;

function FirstNotAvatarPersonIndex: integer;
var
  j:byte;
begin
  Result:=-1;
  for j:=1 to CountOfAlivePlayers do
    if APl[j].Alive then
      if not APl[j].Avatar then
        begin
          Result:=j;
          Exit
        end
end;



procedure TForm1.Timer1Timer(Sender: TObject);
var
  i,j:byte;
  NString, InfoString: string;
  NarcoForm: TUserNarcoDiler;
  Target: TMafiaRole;
begin
  timer1.Enabled:=false;

  ObjectivesForm.Memo1.Lines.Text := User.Info;
  ObjectivesForm.Memo2.Lines.Text := RolesInfo[User.RoleIndex];
  ObjectivesForm.Memo4.Lines.Text := User.RoleInfo;
  //ObjectivesForm.Memo3.Lines.Text := 'Done goals';
  ObjectivesForm.Memo3.Lines.Text := PlayersGoals[1].Info;

  while not (User.Dead or WinCondition or
    User.LosingCondition or (CountOfAlivePlayers<2)
    or TotalStop) do begin
  Night:=false;
  ShowPlayers;
  DayForm.Show;
  Vote.Show;
  msg.show;

  Labels[1].Caption:='';
  Labels[2].Caption:='';
  Labels[3].Caption:='';
  Votes[1].Caption:='';
  Votes[2].Caption:='';
  Votes[3].Caption:='';
  CurrentAccusation:=1;
  CurrentPlayer:=1;

  DeFreeze;
  UnSpellNight;

  AccuseProcess;
  VoteProcess;
  HangProcess;

  DeSilent;
  UnSpellDay;

  DayForm.Hide;
  Vote.Hide;
  msg.Memo1.Lines.Clear;

  Night := true;
  //CountOfKilledPersons := 0;
  ShowPlayers;
  if witch.Alive then
    if witch.UserControlled then
      WitchForm.ShowModal
    else begin
      WitchForm.renew;
      i := 0;
      case Random(54) + 1 of
        1..24: i := 1;
        //      Witch.SpellSilent(APl[Random(CountOfAlivePlayers)+1]);
        25..36: i := 2;//Witch.Freeze(APl[Random(CountOfAlivePlayers)+1]);
        37..44: i := 3;//Witch.SpellTruth(APl[Random(CountOfAlivePlayers)+1]);
        45..48: i := 4;//Witch.SpellNightShield(APl[Random(CountOfAlivePlayers)+1]);
        49..51: i := 5;//Witch.SpellDayShield(APl[Random(CountOfAlivePlayers)+1]);
        52..53: i := 6;//Witch.DemonDie(APl[Random(CountOfAlivePlayers)+1]);
        54: if not Witch.Avatar and Agent.Dead then
        i := 7; //Witch.AvatarDeath(APl[Random(CountOfAlivePlayers)+1]);
      end;
      if i > 0 then begin
        j := Random(CountOfAlivePlayers) + 1;
        InfoString := 'Witch used a power ' + Spells[i].Spell;
        MSG.Memo1.Lines.Add(InfoString);
        Spells[i].Proc(APl[j]);
        EventList.AddWitchSpell(witch, APl[j], Spells[i].Spell, InfoString);
      end
    end;

  MafiaProcess(CountOfAliveMembersOfBlackMafia, TBlackMafia, 'Black mafia', MainBlackMafia, BlackMafia);
  MafiaProcess(CountOfAliveMembersOfRedMafia, TRedMafia, 'Red mafia', MainRedMafia, RedMafia);
  ManiacProcess(TBlackManiac, 'Black maniac', BlackManiac);
  ManiacProcess(TRedManiac, 'Red maniac', RedManiac);
  PoliceProcess('Policewoman', Policeman, UserPolice, 2);
  PoliceProcess('Agent FBI', Agent, UserAGENTFBI, 3);
  PoliceProcess('Demon', Demon, UserDemon, 2);
  PoliceProcess('Morokun', Morokun, UserMorokun, 2);
  PoliceProcess('Antidrugs cop', ANCop, UserANCop, 3);

//  If Random(2)=1 then
//    If witch.UserControlled then
//      ShowMessage('Choose whom do you want to freeze to make her unable to do ter functions');
//      ShowMessage('Виберіть, кого ви хочете заморозити на ніч, щоб вона не могла виконувати свої функції');



 { if CountOfAliveMembersOfBlackMafia>0 then
    if not MainBlackMafia.Freezed then begin
      UserMafia.Player := MainBlackMafia;

      if MainBlackMafia.UserControlled then begin
        UserMafia.Mafia:=TBlackMafia;
        BlackMafia[1].UnSleep:=true;
        BlackMafia[2].UnSleep:=true;
        BlackMafia[3].UnSleep:=true;
        ShowPlayers;
        UserMafia.showmodal
      end else begin
        UserMafia.Mafia:=TBlackMafia;
        UserMafia.renew;
        if BlackMafia[1].UserControlled or BlackMafia[2].UserControlled or
            BlackMafia[3].UserControlled then begin
          BlackMafia[1].UnSleep:=true;
          BlackMafia[2].UnSleep:=true;
          BlackMafia[3].UnSleep:=true;
          ShowPlayers;
          SLeep(2000);
        end;
        if Random(2)=1 then begin
          UserMafia.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMafia.AC.ItemIndex:=random(3);
          UserMafia.Button1Click(nil);
        end else
          UserMafia.Button2Click(nil);
      end
    end else begin
      MSG.Memo1.Lines.Add('Black mafia couldn''t do their functions because their leader is freezed by witch');
      EventList.AddMoveMiss(MainBlackMafia, 'WitchSpell', 'Black mafia couldn''t do their functions because their leader is freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add('Black mafia is banquished');
    EventList.AddMoveMiss(MainBlackMafia, 'Dead', 'Black mafia couldn''t do their functions because their leader is freezed by witch')
  end;

  BlackMafia[1].UnSleep:=false;
  BlackMafia[2].UnSleep:=false;
  BlackMafia[3].UnSleep:=false;
  ShowPlayers;

  if CountOfAliveMembersOfRedMafia>0 then
  if not MainRedMafia.Freezed then
  if MainRedMafia.UserControlled then
    begin
      UserMafia.Mafia:=TRedMafia;
      RedMafia[1].UnSleep:=true;
      RedMafia[2].UnSleep:=true;
      RedMafia[3].UnSleep:=true;
      ShowPlayers;
      UserMafia.showmodal
    end
  else
    begin
      UserMafia.Mafia:=TRedMafia;
      UserMafia.renew;
      if RedMafia[1].UserControlled or
      RedMafia[2].UserControlled or
      RedMafia[3].UserControlled then
        begin
      RedMafia[1].UnSleep:=true;
      RedMafia[2].UnSleep:=true;
      RedMafia[3].UnSleep:=true;
      ShowPlayers;
      SLeep(2000);
        end;
      if Random(2)=1 then
        begin
          UserMafia.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMafia.AC.ItemIndex:=random(3);
          UserMafia.Button1Click(nil);
        end
      else
        UserMafia.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Red mafia couldn''t do their functions because their leader is freezed by witch')
  else
    MSG.Memo1.Lines.Add('Red mafia is banquished');

      RedMafia[1].UnSleep:=false;
      RedMafia[2].UnSleep:=false;
      RedMafia[3].UnSleep:=false;
      ShowPlayers;  }




  {if BlackManiac.Alive then
  if not BlackManiac.Freezed then
  if BlackManiac.UserControlled then
    begin
      UserMafia.Mafia:=TBlackManiac;
      UserMafia.showmodal
    end
  else
    begin
      UserMafia.Mafia:=TBlackManiac;
      UserMafia.renew;
      if Random(2)=1 then
        begin
          UserMafia.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMafia.AC.ItemIndex:=random(3);
          UserMafia.Button1Click(nil);
        end
      else
        UserMafia.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Black Maniac couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Black maniac is banquished');


  if RedManiac.Alive then
  if not RedManiac.Freezed then
  if RedManiac.UserControlled then
    begin
      UserMafia.Mafia:=TRedManiac;
      UserMafia.showmodal
    end
  else
    begin
      UserMafia.Mafia:=TRedManiac;
      UserMafia.renew;
      if Random(2)=1 then
        begin
          UserMafia.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMafia.AC.ItemIndex:=random(3);
          UserMafia.Button1Click(nil);
        end
      else
        UserMafia.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Red Maniac couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Red maniac is banquished');  }


  {if Policeman.Alive then
  if not Policeman.Freezed then
  If Policeman.UserControlled then
    UserPolice.Showmodal
  else
    begin
      UserPolice.renew;
      if Random(2)=1 then
        begin
          UserPolice.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserPolice.AC.ItemIndex:=random(2);
          UserPolice.Button1Click(nil);
        end
      else
        UserPolice.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('A Police(WO!)man couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Police is banquished');

  if Agent.Alive then
  if not Agent.Freezed then
  If Agent.UserControlled then
    UserAGENTFBI.Showmodal
  else
    begin
      UserAGENTFBI.renew;
      if Random(2)=1 then
        begin
          UserAGENTFBI.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserAGENTFBI.AC.ItemIndex:=random(3);
          UserAGENTFBI.Button1Click(nil);
        end
      else
        UserAGENTFBI.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Agent FBI couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Agent FBI is banquished'); }

  {if Demon.Alive then
  if not Demon.Freezed then
  If Demon.UserControlled then
    UserDemon.Showmodal
  else
    begin
      UserDemon.renew;
      if Random(2)=1 then
        begin
          UserDemon.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserDemon.AC.ItemIndex:=random(2);
          UserDemon.Button1Click(nil);
        end
      else
        UserDemon.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Demon couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Demon is banquished');
  }

  {if Morokun.Alive then
  if not Morokun.Freezed then
  If Morokun.UserControlled then
    UserMorokun.Showmodal
  else
    begin
      UserMorokun.renew;
      if Random(2)=1 then
        begin
          UserMorokun.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserMorokun.AC.ItemIndex:=random(2);
          UserMorokun.Button1Click(nil);
        end
      else
        UserMorokun.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Morokun couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Morokun is banquished'); }

  {if ANCop.Alive then
  if not ANCop.Freezed then
  If ANCop.UserControlled then
    UserANCop.Showmodal
  else
    begin
      UserANCop.renew;
      if Random(2)=1 then
        begin
          UserANCop.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserANCop.AC.ItemIndex:=random(3);
          UserANCop.Button1Click(nil);
        end
      else
        UserANCop.Button2Click(nil);
    end
  else
    MSG.Memo1.Lines.Add('Antidrugs cop couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('Antidrugs cop is banquished'); }

  for i := 1 to CountOfAliveNarcomans do begin
    NString:='Narcoman ['+inttostr(i)+'] ';
    if Assigned(Narcomans[i]) and Narcomans[i].Alive then
      if not Narcomans[i].Freezed then begin
        if Narcomans[i].HasDrugs then
          NarcoForm := UserNarcoDiler
        else
          NarcoForm := UserNarcoMan;
        NarcoForm.Player := Narcomans[i];
        NarcoForm.NarcomanString := NString;
        if Narcomans[i].UserControlled then
          NarcoForm.Showmodal
        else begin
          NarcoForm.renew;
          if Random(2) = 1 then
          begin
            NarcoForm.AP.ItemIndex := Random(CountOfAlivePlayers);
            NarcoForm.Button1Click(Nil);
          end else
            NarcoForm.Button2Click(Nil);
        end
      end else begin
        MSG.Memo1.Lines.Add(NString + ' couldn''t do her functions because was freezed by witch');
        EventList.AddMoveMiss(Narcomans[i], 'WitchSpell', NString + ' couldn''t do her functions because was freezed by witch')
      end
    else begin
      MSG.Memo1.Lines.Add(NString + ' is banquished');
      EventList.AddMoveMiss(Narcomans[i], 'Dead', NString + ' is banquished')
    end;
  end;



  {if NarcoDiler<>nil then
  if NarcoDiler.Alive then
  if not NarcoDiler.Freezed then
  if NarcoDiler.HasDrugs then
  If NarcoDiler.UserControlled then
    UserNarcoDiler.Showmodal
  else
    begin
      UserNarcoDiler.renew;
      if Random(2)=1 then
        begin
          UserNarcoDiler.AP.ItemIndex:=Random(CountOfAlivePlayers);
          UserNarcoDiler.Button1Click(nil);
        end
      else
        UserNarcoDiler.Button2Click(nil);
    end
  else

//      Narcomans[i]
  else
    MSG.Memo1.Lines.Add('NarcoDiler couldn''t do her functions because was freezed by witch')
  else
    MSG.Memo1.Lines.Add('NarcoDiler is banquished')
  else
    MSG.Memo1.Lines.Add('NarcoDiler is banquished');}

  if Doctor.Alive then
    if not Doctor.Freezed then
      if Doctor.UserControlled then
        UserDoctor.Showmodal
      else begin
        UserDoctor.renew;
        if Random(2) = 1 then
          begin
            UserDoctor.AP.ItemIndex := Random(CountOfAlivePlayers);
            UserDoctor.Button1Click(nil);
          end
        else
          UserDoctor.Button2Click(nil);
      end
    else begin
      MSG.Memo1.Lines.Add('Doctor couldn''t do her functions because was freezed by witch');
      EventList.AddMoveMiss(Doctor, 'WitchSpell', 'Doctor couldn''t do her functions because was freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add('Doctor is banquished');
    EventList.AddMoveMiss(Doctor, 'Dead', 'Doctor is banquished')
  end;

  if Advocat.Alive then
    if not Advocat.Freezed then
      if Advocat.UserControlled then
        UserAdvocat.Showmodal
      else begin
        UserAdvocat.renew;
        if Random(2) = 1 then
          begin
            UserAdvocat.AP.ItemIndex := Random(CountOfAlivePlayers);
            UserAdvocat.Button1Click(nil);
          end
        else
          UserAdvocat.Button2Click(nil);
      end
    else begin
      MSG.Memo1.Lines.Add('Advocat couldn''t do her functions because was freezed by witch');
      EventList.AddMoveMiss(Advocat, 'WitchSpell', 'Advocat couldn''t do her functions because was freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add('Advocat is banquished');
    EventList.AddMoveMiss(Advocat, 'Dead', 'Advocat is banquished')
  end;

  if WhiteLighter.Alive then
    if not WhiteLighter.Freezed then
      if WhiteLighter.UserControlled then
        UserWL.Showmodal
      else begin
        UserWL.renew;
        if Random(2) = 1 then
          begin
            UserWL.AP.ItemIndex := Random(CountOfAlivePlayers);
            UserWL.Button1Click(nil);
          end
        else
          UserWL.Button2Click(nil);
      end
    else begin
      MSG.Memo1.Lines.Add('WhiteLighter couldn''t do her functions because was freezed by witch');
      EventList.AddMoveMiss(WhiteLighter, 'WitchSpell', 'WhiteLighter couldn''t do her functions because was freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add('WhiteLighter is banquished');
    EventList.AddMoveMiss(WhiteLighter, 'Dead', 'WhiteLighter is banquished')
  end;

  for i := 1 to CountOfZombies do begin
    NString := 'Zombie [' + inttostr(i) + '] ';
    if Assigned(Zombies[i]) and Zombies[i].Alive then
      if not Zombies[i].Freezed then begin
        Target := Players[Random(CountOfAlivePlayers) + 1];
        Target.ZombieAttack(Zombies[i]);
        InfoString := NString + ' attacked some alive player';
        EventList.AddMurderTry(Zombies[i], Target, 'Zombie', InfoString)
      end else begin
        InfoString := NString + ' couldn''t do her functions because was freezed by witch';
        EventList.AddMoveMiss(Zombies[i], 'WitchSpell', InfoString)
      end
    else begin
      InfoString := NString + ' is banquished';
      EventList.AddMoveMiss(Narcomans[i], 'Dead', InfoString)
    end; {else begin
      InfoString := NString + ' was supposed to do something but didn''t succeed due to internal program error (Bug?)';
      EventList.AddMoveMiss(Narcomans[i], 'Bug', InfoString)
    end;}
    MSG.Memo1.Lines.Add(InfoString);
  end;


  //UserAvator.Player := MainAvatar;


// TODO: Every avatar should have ability to do something!!!

  for i := 1 to CountOfAliveAvatars do begin
    UserAvator.Player := Avatars[i];

    if Assigned(Avatars[i]) and Avatars[i].Alive then
      if not Avatars[i].Freezed then begin
        if Avatars[i].UserControlled then
          UserAvator.Showmodal
        else begin
          UserAvator.renew;
          if (i > 1) and (Random(2) = 1) then begin
            UserAvator.Button2Click(Nil);
          end else begin
            case CountOfAliveAvatars of
              1: UserAvator.ac.ItemIndex := 0; //JoinUs
              2..9:
                if CountOfAliveAvatars = CountOfAlivePlayers then
                  UserAvator.ac.ItemIndex := 4 // Utopy
                else
                  UserAvator.ac.ItemIndex := 0;
              10:
                if not Utopy then
                  UserAvator.ac.ItemIndex := 4
                else
                  UserAvator.ac.ItemIndex := 5 // Clear
            end;
            UserAvator.AP.ItemIndex := FirstNotAvatarPersonIndex - 1;
            UserAvator.Button1Click(Nil);
          end
        end
      end else begin
        MSG.Memo1.Lines.Add(Avatars[i].AvatarName + ' couldn''t do her functions because was freezed by witch');
        EventList.AddMoveMiss(Avatars[i], 'WitchSpell', Avatars[i].AvatarName + ' couldn''t do her functions because was freezed by witch')
      end
    else begin
      MSG.Memo1.Lines.Add(Avatars[i].AvatarName + ' is banquished');
      EventList.AddMoveMiss(Avatars[i], 'Dead', Avatars[i].AvatarName + ' is banquished')
    end;
  end;

  {if Assigned(MainAvatar) and MainAvatar.Alive then
    if not MainAvatar.Freezed then
      if MainAvatar.UserControlled then
        UserAvator.Showmodal
      else begin
        UserAvator.renew;
        case CountOfAliveAvatars of
          1: UserAvator.ac.ItemIndex := 0; //JoinUs
          2..9:
            if CountOfAliveAvatars = CountOfAlivePlayers then
              UserAvator.ac.ItemIndex := 4 // Utopy
            else
              UserAvator.ac.ItemIndex := 0;
          10:
            if not Utopy then
              UserAvator.ac.ItemIndex := 4
            else
              UserAvator.ac.ItemIndex := 5 // Clear
        end;
        UserAvator.AP.ItemIndex := FirstNotAvatarPersonIndex - 1;
        UserAvator.Button1Click(nil);
      end
    else begin
      MSG.Memo1.Lines.Add('MainAvatar couldn''t do her functions because was freezed by witch');
      EventList.AddMoveMiss(MainAvatar, 'WitchSpell', 'MainAvatar couldn''t do her functions because was freezed by witch')
    end
  else begin
    MSG.Memo1.Lines.Add('MainAvatar is banquished');
    EventList.AddMoveMiss(MainAvatar, 'Dead', 'MainAvatar is banquished')
  end;}



  EveryNight;

  NarcoDilerEnable;

  Inc(Day);
  DayForm.Memo1.Text := 'Day ' + inttostr(Day) + #13#10 +
  'Number of alive narcomans: ' + inttostr(CountOfAliveNarcomans) +
  '  Number of alive avators: ' + inttostr(CountOfAliveAvatars) +
  #13#10'Number of alive Players: ' + inttostr(CountOfAlivePlayers);

  if WinCondition then begin
    if PlayersGoals[1].PrimaryGoals.Satisfied and not PlayersGoals[1].AdditionalAvatarsGoals.Satisfied then
      if MessageBox(0, 'You won, but you have additional avatar goals. Would you like to continue game and try to succeed in avatar goals?', 'asdf', MB_YESNO) = IDYES then
        UseAvatarWinningConditions := True
      else
        if PlayersGoals[1].PrimaryGoals.Satisfied and not PlayersGoals[1].AdditionalNarcomansGoals.Satisfied then
          if MessageBox(0, 'You won, but you have additional narcomans goals. Would you like to continue game and try to succeed in narcomans goals?', 'asdf', MB_YESNO) = IDYES then
            UseNarcomanWinningConditions := True
  end;


     end;
  if totalstop then
    Exit;
  if WinCondition then begin
    ObjectivesForm.Hide;
    ObjectivesForm.Show;

    ShowMessage('You won');
  end;
  if User.LosingCondition then begin
    ShowMessage('You lost. Try later again');
    CheatForm.UL.Lines.SaveToFile('ul.txt');
    CheatForm.EL.Lines.SaveToFile('el.txt');
  end;

  close
end;

procedure TForm1.VoteProcess;
var
  i, j: byte;
  CurrentPlayer: TMafiaRole;
begin
  //Процедура голосування
  UserVote.Vote.items.Clear;
  UserVote.Vote.items.add(Accused[1].Name);
  UserVote.Vote.items.add(Accused[2].Name);
  UserVote.Vote.items.add(Accused[3].Name);
  UserVote.Vote.ItemIndex := -1;
  Vot[1] := 0;
  Vot[2] := 0;
  Vot[3] := 0;
  for i := 1 to 19 do begin
    CurrentPlayer := Players[i];
      if CurrentPlayer.Alive and not CurrentPlayer.Silent and not CurrentPlayer.Zombie  then
      if i = 1 then
        begin
          UserVote.ShowModal;
          if totalstop then exit;
          j := UserVote.Vote.ItemIndex + 1;
          Inc(Vot[j]);
          MSG.Memo1.lines.Add(User.Name + ' votes for ' + Labels[j].Caption);
          Votes[j].Caption := Inttostr(Vot[j]);
          EventList.AddVote(CurrentPlayer, Accused[j], Accuse.Accusation,
            User.Name + ' votes for ' + Labels[j].Caption)
        end
      else
        begin
          j := Random(3) + 1;
          Inc(Vot[j]);
          MSG.Memo1.lines.Add(CurrentPlayer.Name + ' votes for ' + Labels[j].Caption);
          Votes[j].Caption := Inttostr(Vot[j]);
          EventList.AddVote(CurrentPlayer, Accused[j], Accuse.Accusation,
            User.Name + ' votes for ' + Labels[j].Caption)
        end
    else
      if CurrentPlayer.Alive and CurrentPlayer.Silent then begin
        MSG.Memo1.lines.Add(CurrentPlayer.Name + ' cannot vote because she is under a spell SILENCE');
        EventList.AddMoveMiss(CurrentPlayer, 'UnderSpell', CurrentPlayer.Name + ' cannot vote because she is under a spell SILENCE')
      end else
        if CurrentPlayer.Alive and CurrentPlayer.Zombie then begin
          MSG.Memo1.lines.Add(CurrentPlayer.Name + ' cannot vote because she is Zombie!!!');
          EventList.AddMoveMiss(CurrentPlayer, 'Zombie', CurrentPlayer.Name + ' cannot vote because she is Zombie!!!')
        end else begin
          MSG.Memo1.lines.Add(CurrentPlayer.Name + ' cannot vote due to internal program error (Bug?)');
          EventList.AddMoveMiss(CurrentPlayer, 'Bug', CurrentPlayer.Name + ' cannot vote due to internal program error (Bug?)')
        end;
    end;
end;

end.
