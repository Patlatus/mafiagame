unit uWitch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uac, StdCtrls, ExtCtrls, MafiaDef;

type
  TWitchForm = class(TAccuse)
    Panel2: TPanel;
    power: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject); override;
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
//    Spell:TMafiaEvent;
    procedure Renew; override;
    { Public declarations }
  end;

var
  WitchForm: TWitchForm;
  Spells:array [1..7] of record
    Spell:String;Proc:TMafiaProc;Power:byte end =
    ((Spell:'Silent';Proc:TWitch.SpellSilent;Power:1),
    (Spell:'Freeze';Proc:TWitch.Freeze;Power:2),
    (Spell:'Spell of the TRUTH';Proc:TWitch.SpellTruth;Power:3),
    (Spell:'Night SHIELD';Proc:TWitch.SpellNightShield;Power:5),
    (Spell:'Day SHIELD';Proc:TWitch.SpellDayShield;Power:7),
    (Spell:'DEMON MUST DIE';Proc:TWitch.DemonDie;Power:10),
    (Spell:'AVATAR MUST DIE';Proc:TWitch.AvatarDeath;Power:20));
implementation

uses umsg, uEventList, uCheat;

{$R *.dfm}

procedure TWitchForm.FormShow(Sender: TObject);
begin
  inherited;
//  Spell:=nil;
end;

procedure TWitchForm.Button2Click(Sender: TObject);
begin
  Witch.Skip;
  Hide
end;

procedure TWitchForm.Button1Click(Sender: TObject);
var
  InfoString: string;
begin
  InfoString := 'Witch used a power '+Spells[ac.itemindex+1].Spell;
  MSG.Memo1.Lines.Add(InfoString);
  Spells[ac.itemindex+1].Proc(APl[ap.itemindex+1]);
  if @Spells[ac.itemindex+1].Proc=@TWitch.SpellTruth then
    ShowMessage(APl[ap.itemindex+1].info);
  EventList.AddWitchSpell(witch, APl[ap.itemindex+1], Spells[ac.itemindex+1].Spell, InfoString);
  Hide
//  Spell:=Spells[ac.itemindex+1].Proc
end;

procedure TWitchForm.Renew;
VAR
  j:byte;
begin
  Inherited;


  power.Caption:='Witch power: '+inttostr(Witch.power);
  AC.Items.Clear;
  for j:=1 to 6 do
    if Witch.Power>=Spells[j].Power then
      AC.Items.Add(Spells[j].Spell);
  if (Witch.Power>=Spells[7].Power) and Agent.Dead
  and not witch.Avatar then
      AC.Items.Add(Spells[7].Spell);
end;

procedure TWitchForm.FormCreate(Sender: TObject);
begin
    Spells[1].Proc:=TWitch.SpellSilent;
    Spells[2].Proc:=TWitch.Freeze;
    Spells[3].Proc:=TWitch.SpellTruth;
    Spells[4].Proc:=TWitch.SpellNightShield;
    Spells[5].Proc:=TWitch.SpellDayShield;
    Spells[6].Proc:=TWitch.DemonDie;
    Spells[7].Proc:=TWitch.AvatarDeath;
end;

procedure TWitchForm.FormHide(Sender: TObject);
begin
  StopHide;
end;

end.
