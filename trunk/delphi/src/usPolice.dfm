inherited UserPolice: TUserPolice
  Caption = 'UserPolice'
  ClientWidth = 496
  OnCreate = FormCreate
  ExplicitWidth = 502
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Width = 496
    Height = 49
    Align = alTop
    Items.Strings = (
      'Send to prison (she wil die only if is mafia or maniac)'
      'Just to shoot (she wil die in any case)')
    ExplicitWidth = 496
    ExplicitHeight = 49
  end
  inherited AP: TRadioGroup
    Left = 0
    Top = 49
    Width = 496
    Height = 101
    Columns = 5
    ExplicitLeft = 0
    ExplicitTop = 49
    ExplicitWidth = 496
    ExplicitHeight = 101
  end
  inherited Panel1: TPanel
    Width = 496
    ExplicitWidth = 496
  end
end
