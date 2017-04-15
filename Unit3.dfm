object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Wzrost'
  ClientHeight = 146
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 33
    Width = 49
    Height = 13
    Caption = 'Wzrost od'
  end
  object Label2: TLabel
    Left = 184
    Top = 33
    Width = 12
    Height = 13
    Caption = 'do'
  end
  object Edit1: TEdit
    Left = 120
    Top = 30
    Width = 49
    Height = 21
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 216
    Top = 30
    Width = 49
    Height = 21
    MaxLength = 3
    TabOrder = 1
    OnKeyPress = Edit2KeyPress
  end
  object Button1: TButton
    Left = 64
    Top = 88
    Width = 105
    Height = 25
    Caption = 'Filtruj'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 88
    Width = 121
    Height = 25
    Caption = 'Anuluj'
    TabOrder = 3
    OnClick = Button2Click
  end
end
