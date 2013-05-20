unit uac;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uEventList, MafiaDef;

type
  TAccuse = class(TForm)
    AC: TRadioGroup;
    AP: TRadioGroup;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject); virtual;
    procedure Button2Click(Sender: TObject); virtual;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure ACClick(Sender: TObject);
    procedure APClick(Sender: TObject);
  Public
    Mafia:TRole;
    Player: TMafiaRole;
    Function WayOfKill:string;
      Function AccusedPlayer:TMafiaRole;
      Function Accusation:string;
      Procedure Renew;virtual;
    procedure EnableButton;
    procedure PrepareLivePlayersList;
    procedure PrepareDeadPlayersList;
    procedure PrepareEventsList;
    function ChosenLivePlayer: TMafiaRole;
    function ChosenDeadPlayer: TMafiaRole;
    function ChosenEvent: TMafiaEvent;

    procedure StopShow;
    procedure StopHide;
  end;

var
  Accuse: TAccuse;
  APl:array[1..19] of TMafiaRole;
  Shown:boolean=false;

  LivePlayersList, DeadPlayersList: TMafiaRoleArray;
implementation

uses umsg, Unit2, uCheat, uObjectives;

{$R *.dfm}

Function TAccuse.AccusedPlayer: TMafiaRole;
begin
  Result:=APl[ap.itemindex+1]
end;

procedure TAccuse.APClick(Sender: TObject);
begin
  EnableButton;
end;

procedure TAccuse.ACClick(Sender: TObject);
begin
  EnableButton;
end;

Function TAccuse.Accusation:string;
begin
  result:=Copy(AC.Items[aC.ItemIndex],5,length(AC.Items[aC.ItemIndex])-4)
end;

procedure TAccuse.Button1Click(Sender: TObject);
var
  InfoString: string;
begin
  Shown:=false;
  InfoString := User.name+' claims: '+AccusedPlayer.Name+' - '+Accusation;
  MSG.Memo1.lines.Add(InfoString);
  EventList.AddAccusation(User, AccusedPlayer, Accusation, InfoString);

  Hide
end;

procedure TAccuse.Button2Click(Sender: TObject);
begin
  Shown:=false;
  MSG.Memo1.lines.Add(User.name+' doesn''t accuse anyone');
  Hide
end;

function TAccuse.ChosenDeadPlayer: TMafiaRole;
begin
  Result := DeadPlayersList[ap.itemindex + 1]
end;

function TAccuse.ChosenEvent: TMafiaEvent;
begin
  Result := EventList[ap.itemindex + 1]
end;

function TAccuse.ChosenLivePlayer: TMafiaRole;
begin
  Result := LivePlayersList[ap.itemindex + 1]
end;

procedure TAccuse.EnableButton;
begin
  Button1.Enabled := (ap.ItemIndex >= 0) and (ac.ItemIndex >= 0);
end;

procedure TAccuse.renew;
var
  i,j:byte;
begin
  ap.Items.Clear;
  i:=1;
  for j:=1 to 19 do
    if not Players[j].Dead then
      begin
        ap.Items.Add(Players[j].Name);
        apl[i]:=Players[j];
        Inc(i);
      end
end;

procedure TAccuse.FormShow(Sender: TObject);
begin
  StopShow;
  Shown:=true;
  ac.ItemIndex:=-1;
  ap.ItemIndex:=-1;
  Button1.Enabled:=false;
  Renew;
end;

procedure TAccuse.PrepareDeadPlayersList;
var
  i, j: byte;
begin
  ap.Items.Clear;
  i := 1;
  for j := 1 to 19 do
    if Players[j].Dead then
      begin
        ap.Items.Add(Players[j].Name);
        DeadPlayersList[i] := Players[j];
        Inc(i);
      end
end;

procedure TAccuse.PrepareEventsList;
var
  {i, }j: byte;
begin
  ap.Items.Clear;
  //i := 1;
  for j := 0 to EventList.Count - 1 do
      begin
        ap.Items.Add(EventList[j].FullDescription);
        //Inc(i);
      end
end;

procedure TAccuse.PrepareLivePlayersList;
var
  i, j: byte;
begin
  ap.Items.Clear;
  i := 1;
  for j := 1 to 19 do
    if not Players[j].Dead then
      begin
        ap.Items.Add(Players[j].Name);
        LivePlayersList[i] := Players[j];
        Inc(i);
      end
end;

procedure TAccuse.FormHide(Sender: TObject);
begin
  StopHide;
  if not TotalStop then
  if Shown then
    MSG.Memo1.lines.Add(User.name+' doesn''t accuse anyone');
  Shown:=false;
end;

procedure TAccuse.StopShow;
begin
  //Form2.Hide;
    CurrentThread:=Self;
  Form2.Show;
  ObjectivesForm.Show;
  if CheatsEnabled then
    CheatForm.Show;
end;

function TAccuse.WayOfKill: string;
begin
  result := AC.Items[ac.itemindex]

end;

procedure TAccuse.StopHide;
begin
  CurrentThread:=nil;
  Form2.Hide;
  ObjectivesForm.Hide;
  if CheatsEnabled then
    CheatForm.Hide;
end;

end.
