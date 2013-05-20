unit uinfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TInfo = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Info: TInfo;

implementation

{$R *.dfm}

end.
