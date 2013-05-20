inherited UserANCop: TUserANCop
  Caption = 'UserANCop'
  ExplicitWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Height = 57
    Items.Strings = (
      'Take off drugs (she won'#39't be able to make narcomans)'
      'Just to shoot'
      'Heal (you can'#39't heal the first one)')
    ExplicitHeight = 57
  end
  inherited AP: TRadioGroup
    Top = 57
    Height = 93
    ExplicitTop = 57
    ExplicitHeight = 93
  end
  inherited Panel1: TPanel
    inherited Button1: TButton
      Left = 199
      Top = 6
      ExplicitLeft = 199
      ExplicitTop = 6
    end
  end
end
