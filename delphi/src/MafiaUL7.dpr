program MafiaUL7;

{$R *.dres}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  OUnit in 'OUnit.pas' {OForm},
  MafiaDef in 'MafiaDef.pas',
  uinfo in 'uinfo.pas' {Info},
  uvote in 'uvote.pas' {Vote},
  uday in 'uday.pas' {DayForm},
  umsg in 'umsg.pas' {Msg},
  uac in 'uac.pas' {Accuse},
  usVote in 'usVote.pas' {UserVote},
  uWitch in 'uWitch.pas' {WitchForm},
  usMafia in 'usMafia.pas' {UserMafia},
  usPolice in 'usPolice.pas' {UserPolice},
  usAgent in 'usAgent.pas' {UserAgentFBI},
  usDemon in 'usDemon.pas' {UserDemon},
  usANCop in 'usANCop.pas' {UserANCop},
  usMorokun in 'usMorokun.pas' {UserMorokun},
  usWL in 'usWL.pas' {UserWL},
  usAdvo in 'usAdvo.pas' {UserAdvocat},
  usDoctor in 'usDoctor.pas' {UserDoctor},
  usNarcoDiler in 'usNarcoDiler.pas' {UserNarcoDiler},
  usNarcoMan in 'usNarcoMan.pas' {UserNarcoMan},
  usAvator in 'usAvator.pas' {UserAvator},
  Unit2 in 'Unit2.pas' {Form2},
  uEventList in 'uEventList.pas',
  uCheat in 'uCheat.pas' {CheatForm},
  uObjectives in 'uObjectives.pas' {ObjectivesForm},
  uGoals in 'uGoals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.title:='Mafia UNLEASHED';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TOForm, OForm);
  Application.CreateForm(TInfo, Info);
  Application.CreateForm(TVote, Vote);
  Application.CreateForm(TDayForm, DayForm);
  Application.CreateForm(TMsg, Msg);
  Application.CreateForm(TAccuse, Accuse);
  Application.CreateForm(TUserVote, UserVote);
  Application.CreateForm(TWitchForm, WitchForm);
  Application.CreateForm(TUserMafia, UserMafia);
  Application.CreateForm(TUserPolice, UserPolice);
  Application.CreateForm(TUserAgentFBI, UserAgentFBI);
  Application.CreateForm(TUserDemon, UserDemon);
  Application.CreateForm(TUserANCop, UserANCop);
  Application.CreateForm(TUserMorokun, UserMorokun);
  Application.CreateForm(TUserWL, UserWL);
  Application.CreateForm(TUserAdvocat, UserAdvocat);
  Application.CreateForm(TUserDoctor, UserDoctor);
  Application.CreateForm(TUserNarcoDiler, UserNarcoDiler);
  Application.CreateForm(TUserNarcoMan, UserNarcoMan);
  Application.CreateForm(TUserAvator, UserAvator);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TCheatForm, CheatForm);
  Application.CreateForm(TObjectivesForm, ObjectivesForm);
  Application.Run;
end.
