unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Data.Bind.Components, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    BindingsList1: TBindingsList;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  CurrentThread:TForm;
  TotalStop:boolean=false;
implementation

uses Unit1, uCheat;

{$R *.dfm}

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  TotalStop:=true;
  if CurrentThread<>nil then
  CurrentThread.Close;
  Application.Terminate;
//  MainForm.Close;
end;

procedure TForm2.BitBtn1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((ssShift in Shift) and (ssCtrl in Shift) and (Char(Key)='C')) then begin
    CheatsEnabled := True;
    //CheatForm.Show;
  end;
end;

end.
