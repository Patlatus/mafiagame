object Accuse: TAccuse
  Left = 232
  Top = 165
  BorderStyle = bsToolWindow
  Caption = 'Accusations form'
  ClientHeight = 191
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AC: TRadioGroup
    Left = 0
    Top = 0
    Width = 185
    Height = 150
    Align = alLeft
    Caption = 'Choose an accusation'
    Items.Strings = (
      'She is mafia!'
      'She is maniac!'
      'She is drugs-controlled!'
      'She is a DEMON!!!!'
      'She is a WITCH!!!!'
      'She is a morokun!'
      'She is an AVATAR!!!!!!!')
    TabOrder = 0
    OnClick = ACClick
  end
  object AP: TRadioGroup
    Left = 185
    Top = 0
    Width = 278
    Height = 150
    Align = alClient
    Caption = 'Choose whom to accuse'
    Columns = 3
    Items.Strings = (
      'Player #1'
      'Player #2'
      'Player #3'
      'Player #4'
      'Player #5'
      'Player #6'
      'Player #7'
      'Player #8'
      'Player #9'
      'Player #10'
      'Player #11'
      'Player #12'
      'Player #13'
      'Player #14'
      'Player #15'
      'Player #16'
      'Player #17'
      'Player #18'
      'Player #19')
    TabOrder = 1
    OnClick = APClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 150
    Width = 463
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Button1: TButton
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Accuse'
      ModalResult = 3
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 232
      Top = 8
      Width = 105
      Height = 25
      Caption = 'No accusation now'
      ModalResult = 5
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
