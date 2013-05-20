object OForm: TOForm
  Left = 670
  Top = 136
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 163
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = NextBKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 99
    Height = 13
    Caption = 'Choose your options:'
  end
  object MAC: TRadioGroup
    Left = 8
    Top = 24
    Width = 233
    Height = 105
    Caption = 'Manual-auto'
    Items.Strings = (
      'I want myself to choose the role I will play'
      'I want program to do it randomly')
    TabOrder = 0
    OnClick = MACClick
  end
  object BackB: TButton
    Left = 8
    Top = 136
    Width = 70
    Height = 25
    Caption = '<< Back'
    Enabled = False
    TabOrder = 1
    OnClick = BackBClick
  end
  object Button2: TButton
    Left = 84
    Top = 135
    Width = 70
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnKeyDown = NextBKeyDown
  end
  object NextB: TButton
    Left = 168
    Top = 136
    Width = 70
    Height = 25
    Caption = 'Next >>'
    Default = True
    Enabled = False
    TabOrder = 3
    OnClick = NextBClick
    OnKeyDown = NextBKeyDown
  end
  object RC: TRadioGroup
    Left = 8
    Top = 24
    Width = 337
    Height = 105
    Caption = 'Choose you role:'
    Columns = 3
    Items.Strings = (
      'Black Mafia'
      'Red Mafia'
      'Black Maniac'
      'Red Maniac'
      'Advocat'
      'Doctor'
      'Police'
      'Demon'
      'Witch'
      'WhiteLighter'
      'Black Angel'
      'Avatar'
      'Agent FBI'
      'Narcoman'
      'AntiNarcotics Cop')
    TabOrder = 4
    Visible = False
    OnClick = MACClick
  end
end
