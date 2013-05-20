unit usVote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TUserVote = class(TForm)
    vote: TRadioGroup;
    Voteb: TButton;
    procedure FormShow(Sender: TObject);
    procedure voteClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VotebClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserVote: TUserVote;

implementation

uses uac, Unit2;

{$R *.dfm}

procedure TUserVote.FormShow(Sender: TObject);
var MyRegion:HRGN;
begin
  //Form2.Hide;
  {CurrentThread:=Self;
  Form2.Show;}

   TAccuse(self).StopShow;
  MyRegion := CreateRoundRectRgn(0, 0, Width, Height, 20 ,20);
  SetWindowRGN(Handle, MyRegion, true);
  VoteB.Enabled:=false
end;

procedure TUserVote.voteClick(Sender: TObject);
begin
  VoteB.Enabled:=true
end;

procedure TUserVote.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture();
 Perform(WM_Syscommand,$F012, 0);
end;

procedure TUserVote.VotebClick(Sender: TObject);
begin
  hide
end;

procedure TUserVote.FormHide(Sender: TObject);
begin
  TAccuse(self).StopHide;
end;

end.
