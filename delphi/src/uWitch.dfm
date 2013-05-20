inherited WitchForm: TWitchForm
  Caption = 'WitchForm'
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Top = 22
    Height = 128
    Caption = 'Choose a spell'
    ExplicitTop = 22
    ExplicitHeight = 128
  end
  inherited AP: TRadioGroup
    Top = 22
    Height = 128
    Caption = 'Choose whom to spell'
    ExplicitTop = 22
    ExplicitHeight = 128
  end
  inherited Panel1: TPanel
    inherited Button1: TButton
      Left = 192
      Width = 35
      Caption = 'Spell'
      ExplicitLeft = 192
      ExplicitWidth = 35
    end
    inherited Button2: TButton
      Width = 121
      Caption = 'Skip to increase power'
      ExplicitWidth = 121
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 463
    Height = 22
    Align = alTop
    TabOrder = 3
    object power: TLabel
      Left = 7
      Top = 4
      Width = 29
      Height = 13
      Caption = 'power'
    end
  end
end
