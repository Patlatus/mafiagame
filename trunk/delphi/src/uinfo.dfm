object Info: TInfo
  Left = 166
  Top = 43
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Info'
  ClientHeight = 609
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 779
    Height = 505
    Align = alTop
    Lines.Strings = (
      
        'Every player can die in five ways - being shooted, murdered in p' +
        'rison, through demonical death, from overdrugs, being hanged. Re' +
        'spectively there are several '
      
        'immunities - immunity from night death, full immunity from drugs' +
        ' (even couldn'#39't take it), immunity from hanging. Witch, whitelig' +
        'hter, demon, morokun (if they are not '
      
        'avatars) have immunity from drugs. Whitelighter, avatar, demon h' +
        'ave immunity from shooting and other night deaths (they cannot b' +
        'e killed in the night). Avatar and '
      'demon have immunity from hanging (they couldn'#39't be hanged).'
      
        'If a player become a narcoman or avatar he takes also their obje' +
        'ctives and their losing conditions.'
      
        'If a narco joins avatars, all avatars immediately become narcoma' +
        'ns.'
      
        'There are two mafia family - red and black, their members are or' +
        'dered - first all decisions take main mafiozi, if he is killed, ' +
        'the power goes to the next member of clan, '
      
        'and so on. Objective of every mafia is to kill policeman or buy ' +
        'him, and to become a monopolist mean kill out all other mafia an' +
        'd maniacs. Losing condition - clan die '
      'out (every member of a clan is dead)'
      
        'There are also two maniacs - red and black, they are working the' +
        'mselves. Objective of each maniac is to kill the other one and a' +
        'lso all the mafiozi. Losing condition - '
      'death.'
      
        'Advocat (the lawyer) can prevent from prison death any of member' +
        's of mafia or maniacs. His objective - death of policeman, death' +
        ' of doctor, and at least one living '
      
        'member of mafia or maniac and, of course, himself. Losing condit' +
        'ion - death, dying out all the members of mafia and maniacs.'
      
        'Doctor can prevent from not demonical night death. His objective' +
        ' - to survive, survive of agent FBI, antidrugs cop and all the m' +
        'afia and maniacs die out. If '
      
        'policeman dies, the doctor can give mortal ampules to the player' +
        's. Losing condition - death, death of agent or antidrugs cop.'
      
        'Policeman finds mafia and maniac. He couldn'#39't kill innocents. Hi' +
        's objective is to survive and all the mafia and maniacs die out.' +
        ' Losing condition - death.'
      
        'Demon has many powers. He could attack someone in the night (to ' +
        'provide a demonical death for a victim). He could make a zombie ' +
        'from a dead player. Zombies '
      
        'kill players in the night. They have immunity for all kinds of d' +
        'eath, but their life span is five days. Global objective of a de' +
        'mon - is to provide the existance of magic, in '
      
        'part demonizm. Or to become an avatar or to kill them out to pre' +
        'vent them from attacking demonism. To join with witch or to kill' +
        ' her. Losing condition - death.'
      
        'Witch has many powers. First she could choose her way - or the w' +
        'ay of light or the way of darkness. He could make spells, like t' +
        'he spell of truth to get known who is '
      
        'some player in fact. He could freeze someone, so he couldn'#39't mak' +
        'e his functions in the night. He could make a poison against dem' +
        'on. Even could make a poison '
      
        'against avatar, if she isn'#39't an avatar and agent FBI is killed. ' +
        'Global objective of a witch - is to provide the existance of mag' +
        'ic, in part witchery. Or to become an '
      
        'avatar or to kill them out to prevent them from attacking witche' +
        'ry. To join with demon or to kill him. Losing condition - death.'
      
        'WhiteLighter can heal players from any kinds of death except han' +
        'ging and if aim was killed not in this night. Objective is to he' +
        'al witch, and other players, death of '
      
        'demon and morokun. Losing condition - death of death of the witc' +
        'h.'
      
        'Dark angel (Morokun) kills everybody searching the whitelighter.' +
        ' Only morokun could kill whitelighter, so it is his objective. L' +
        'osing condition - death.'
      
        'Avatar has four powers. Their power is in their count. So the fi' +
        'rst power - to summon new avatar. He could offer to anybody join' +
        ' them. This person can or accept or '
      
        'decline this offer. If their count is larger than 2, they could ' +
        'bring back to life some dead player. If their count is larger th' +
        'an 3, they could change event in the past. '
      
        'E.g. to cancel the healing of policeman (if he was killed) in th' +
        'e first night, so everybody, killed by police, will come back to' +
        ' live. If their count is larger than 5, they '
      
        'could come back to the past. E.g. to the first night. So all pla' +
        'yers except avatars become such as they were at the first night.' +
        ' If their count is larger than 10, they can '
      
        'make an utopy and to clear any players. Losing condition - death' +
        ' of all avatars.'
      
        'Agent FBI has poisons against the avatars. He challenges everyth' +
        'ing. Global aim is mafis, maniacs, avatars die out. Can check is' +
        ' smb is avatar - to throw the poison. '
      'If target is avatar, he will die. Losing condition - death.'
      
        'Narcoman, he is also narkodiller. Life span 5 days. Everynight c' +
        'an make smb narco. If target is one avatar, all the avatars beco' +
        'me narcos. Global aim is to make '
      
        'everybody narcos. Losing condition - death of all narcomans and ' +
        'alive at least one not-narco.'
      
        'Antidrugs COP - he can to take drugs from narco. He can kill or ' +
        'heal narcos. Global objective is to heal or kill all narcos. Los' +
        'ing condition - death. or becoming a '
      'narco...')
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 352
    Top = 584
    Width = 75
    Height = 25
    Caption = 'Go!'
    ModalResult = 1
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 0
    Top = 505
    Width = 779
    Height = 72
    Align = alTop
    Lines.Strings = (
      'Memo2')
    TabOrder = 2
  end
end
