inherited UserWL: TUserWL
  Top = 166
  Caption = 'UserWL'
  ClientHeight = 116
  ExplicitWidth = 502
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Visible = False
  end
  inherited AP: TRadioGroup
    Height = 18
    Caption = 'Choose whom to heal'
    ExplicitHeight = 18
  end
  inherited Panel1: TPanel
    Top = 75
    ExplicitTop = 75
    inherited Button1: TButton
      Caption = 'Heal'
    end
    inherited Button2: TButton
      Width = 65
      Caption = 'Take a rest'
      ExplicitWidth = 65
    end
  end
end
