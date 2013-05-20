unit usDoctor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usAdvo, StdCtrls, ExtCtrls;

type
  TUserDoctor = class(TUserAdvocat)
    procedure Button1Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserDoctor: TUserDoctor;

implementation

uses MafiaDef, umsg, uEventList;

{$R *.dfm}

procedure TUserDoctor.FormCreate(Sender: TObject);
begin
  Mafia := TDoctor;
  Player := Doctor;
end;

procedure TUserDoctor.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  if AccusedPlayer.Attempted then
    begin
      Doctor.Heal(AccusedPlayer);
      if AccusedPlayer.Attempted then
        InfoString := Mafia.ClassName + ' couldn''t heal this person'
      else
        InfoString := Mafia.ClassName + ' healed some person'
    end
  else
    InfoString := Mafia.ClassName + ' decided to heal alive person';
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddHealTry(Player, AccusedPlayer, 'Doctor Heal', InfoString);
  Hide;
end;

end.
