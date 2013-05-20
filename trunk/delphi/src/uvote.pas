unit uvote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TVote = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Vote1: TLabel;
    Vote2: TLabel;
    Vote3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Vote: TVote;

implementation

{$R *.dfm}

end.
