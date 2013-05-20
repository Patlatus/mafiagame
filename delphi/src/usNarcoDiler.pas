unit usNarcoDiler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, usAdvo, StdCtrls, ExtCtrls;

type
  TUserNarcoDiler = class(TUserAdvocat)
    procedure Button1Click(Sender: TObject); override;
    procedure Button2Click(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    NarcomanString:String;
    { Public declarations }
  end;

var
  UserNarcoDiler: TUserNarcoDiler;

implementation

uses umsg, MafiaDef, uEventList;

{$R *.dfm}

procedure TUserNarcoDiler.Button1Click(Sender: TObject);
var
  InfoString: String;
  DebugOldNC: Byte;
begin
  DebugOldNC := CountOfAliveNarcomans;
  if not AccusedPlayer.Narcoman then
    if AccusedPlayer.Avatar then
      begin
        {NarcoDiler}Player.MakeAvatarsNarcomans;
        InfoString := 'All avatars become narcomans thanking ' + NarcomanString
      end
    else
      begin
        {NarcoDiler}Player.MakeNarcoman(AccusedPlayer);
        if AccusedPlayer.Narcoman then
          InfoString := 'One more drugs-adicted person joins narcomans'' society thanking ' + NarcomanString
        else
          InfoString := NarcomanString + ' failed. Hhmmm. Maybe that person was NARCOIMMUNE'
      end
  else
    InfoString := NarcomanString + ' tries to make a narcoman from a narcoman...';
  MSG.Memo1.Lines.Add(InfoString);
  EventList.AddMurderTry(Player{NarcoDiler}, AccusedPlayer, 'Drugs' + Format('%d %d', [DebugOldNC, CountOfAliveNarcomans]), InfoString);
  Hide
end;

procedure TUserNarcoDiler.Button2Click(Sender: TObject);
begin
  MSG.Memo1.Lines.Add(NarcomanString + '[' + NarcoDiler.NickName + '] decided to take a rest');
  EventList.AddMoveMiss(Player, 'Decision', NarcomanString + '[' + Player.NickName + '|' + NarcoDiler.NickName + '] decided to take a rest and leave people alone');
  Hide
end;

procedure TUserNarcoDiler.FormCreate(Sender: TObject);
begin
  Mafia := TNarcoman;
  Player := NarcoDiler;
end;

end.
