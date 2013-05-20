unit usWL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usANCop, StdCtrls, ExtCtrls;

type
  TUserWL = class(TUserANCop)
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject); override;
    procedure APClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserWL: TUserWL;

implementation

uses MafiaDef, umsg, uac, uEventList;

{$R *.dfm}

procedure TUserWL.FormCreate(Sender: TObject);
begin
  Mafia := TWhiteLighter;
  Player := WhiteLighter;
end;

procedure TUserWL.Button1Click(Sender: TObject);
var
  InfoString: String;
begin
  if AccusedPlayer.Attempted then
    begin
      WhiteLighter.Heal(AccusedPlayer);
      if AccusedPlayer.Attempted then
        InfoString := Mafia.ClassName + ' couldn''t heal this person'
      else
        InfoString := Mafia.ClassName + ' healed some person'
    end
  else
    InfoString := Mafia.ClassName + ' decided to heal alive person';
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddHealTry(Player, AccusedPlayer, 'Magic Heal', InfoString);
  Hide
end;

procedure TUserWL.APClick(Sender: TObject);
begin
  Button1.Enabled:=ap.itemindex>=0
end;

end.
