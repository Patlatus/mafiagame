object Form2: TForm2
  Left = 920
  Top = 85
  BorderStyle = bsNone
  Caption = 'Form2'
  ClientHeight = 33
  ClientWidth = 112
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnKeyDown = BitBtn1KeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 6
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Stop(Exit)'
    Kind = bkNo
    NumGlyphs = 2
    TabOrder = 0
    OnClick = BitBtn1Click
    OnKeyDown = BitBtn1KeyDown
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    UseAppManager = True
    Left = 20
    Top = 5
  end
end
