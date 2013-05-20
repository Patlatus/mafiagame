object UserVote: TUserVote
  Left = 192
  Top = 140
  BorderStyle = bsNone
  Caption = 'UserVote'
  ClientHeight = 152
  ClientWidth = 120
  Color = clLime
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnHide = FormHide
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object vote: TRadioGroup
    Left = 8
    Top = 8
    Width = 105
    Height = 105
    Caption = 'Choose your vote:'
    TabOrder = 0
    OnClick = voteClick
  end
  object Voteb: TButton
    Left = 8
    Top = 120
    Width = 105
    Height = 25
    Caption = 'Vote!!!'
    ModalResult = 1
    TabOrder = 1
    OnClick = VotebClick
  end
end
