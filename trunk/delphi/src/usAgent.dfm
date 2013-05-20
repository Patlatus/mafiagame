inherited UserAgentFBI: TUserAgentFBI
  Caption = 'UserAgentFBI'
  ExplicitWidth = 320
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Height = 57
    Items.Strings = (
      'Send to prison (she wil die only if is mafia or maniac)'
      'Just to shoot (she wil die in any case)'
      'AvatarDeath (try a poison against avatars)')
    ExplicitHeight = 57
  end
  inherited AP: TRadioGroup
    Top = 57
    Height = 93
    ExplicitTop = 57
    ExplicitHeight = 93
  end
end
