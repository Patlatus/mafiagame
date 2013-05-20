inherited UserDemon: TUserDemon
  Caption = 'UserDemon'
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Height = 65
    Items.Strings = (
      'Attack using demonical powers'
      'Just to shoot'
      'Make a zombie')
    ExplicitHeight = 65
  end
  inherited AP: TRadioGroup
    Top = 65
    Height = 85
  end
end
