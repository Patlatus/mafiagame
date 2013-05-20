object Form1: TForm1
  Left = 329
  Top = 84
  Caption = 'Mafia UNLEASHED'
  ClientHeight = 582
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 685
    Height = 582
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    OnMouseMove = Image1MouseMove
    ExplicitWidth = 693
    ExplicitHeight = 586
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 64
    Top = 128
  end
end
