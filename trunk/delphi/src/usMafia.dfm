inherited UserMafia: TUserMafia
  Caption = 'UserMafia'
  OldCreateOrder = True
  ExplicitWidth = 469
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 13
  inherited AC: TRadioGroup
    Caption = 'Choose type of a death'
    Items.Strings = (
      'Using a string'
      'Just to shoot'
      'Using a knife')
  end
  inherited AP: TRadioGroup
    Caption = 'Choose whom to kill'
  end
  inherited Panel1: TPanel
    inherited Button1: TButton
      Left = 200
      Width = 27
      Caption = 'Kill'
      ExplicitLeft = 200
      ExplicitWidth = 27
    end
    inherited Button2: TButton
      Width = 81
      Caption = 'Give '#39'em a rest'
      ExplicitWidth = 81
    end
  end
end
