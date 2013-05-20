inherited UserAvator: TUserAvator
  Caption = 'UserAvator'
  ClientHeight = 193
  ExplicitWidth = 469
  ExplicitHeight = 217
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Height = 130
    Caption = 'Choose action'
    Items.Strings = (
      'Join us'
      'Heal dead one'
      'Change event in past'
      'Rewind events back'
      'Make utopy'
      'Clear')
    ExplicitHeight = 130
  end
  inherited AP: TRadioGroup
    Height = 130
    Caption = 'Choose whom to act'
    ExplicitHeight = 130
  end
  inherited Panel1: TPanel
    Top = 152
    ExplicitTop = 152
    inherited Button1: TButton
      Caption = 'Act'
    end
    inherited Button2: TButton
      Width = 81
      Caption = 'Leave avators'
      ExplicitWidth = 81
    end
  end
end
