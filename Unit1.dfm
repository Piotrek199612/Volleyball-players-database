object Form1: TForm1
  Left = 0
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Baza Danych'
  ClientHeight = 655
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 92
    Top = 22
    Width = 20
    Height = 13
    Caption = 'Imi'#281
    Color = clBtnFace
    ParentColor = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 92
    Top = 46
    Width = 44
    Height = 13
    Caption = 'Nazwisko'
  end
  object Label3: TLabel
    Left = 92
    Top = 76
    Width = 61
    Height = 13
    Caption = 'Wzrost w cm'
  end
  object Label4: TLabel
    Left = 92
    Top = 132
    Width = 37
    Height = 13
    Caption = 'Pozycja'
  end
  object Label5: TLabel
    Left = 92
    Top = 103
    Width = 73
    Height = 13
    Caption = 'Data urodzenia'
  end
  object Label7: TLabel
    Left = 568
    Top = 88
    Width = 67
    Height = 13
    Caption = 'Sortuj wed'#322'ug'
  end
  object Label8: TLabel
    Left = 632
    Top = 341
    Width = 110
    Height = 13
    Caption = 'Wyszukaj wg Nazwiska'
    Color = clBtnFace
    ParentColor = False
  end
  object Edit1: TEdit
    Left = 184
    Top = 19
    Width = 185
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 391
    Top = 40
    Width = 49
    Height = 27
    Caption = '+'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 279
    Top = 576
    Width = 161
    Height = 41
    Caption = 'Zamknij'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 184
    Top = 46
    Width = 185
    Height = 21
    TabOrder = 1
    OnChange = Edit2Change
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 184
    Top = 73
    Width = 185
    Height = 21
    MaxLength = 3
    TabOrder = 2
    OnKeyPress = Edit3KeyPress
  end
  object Button4: TButton
    Left = 296
    Top = 248
    Width = 17
    Height = 1
    Caption = 'Button4'
    TabOrder = 8
  end
  object Button5: TButton
    Left = 92
    Top = 576
    Width = 153
    Height = 41
    Caption = 'Usu'#324' wszystko'
    TabOrder = 6
    OnClick = Button5Click
  end
  object ComboBox1: TComboBox
    Left = 184
    Top = 124
    Width = 185
    Height = 21
    Style = csDropDownList
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 4
    Items.Strings = (
      'Przyjmuj'#261'cy'
      'Rozgrywaj'#261'cy'
      'Atakuj'#261'cy'
      #346'rodkowy'
      'Libero')
  end
  object ListView1: TListView
    Left = 2
    Top = 151
    Width = 553
    Height = 411
    Columns = <
      item
        Caption = 'Lp.'
        MaxWidth = 30
        MinWidth = 30
        Width = 30
      end
      item
        Caption = 'Imi'#281
        MaxWidth = 75
        MinWidth = 75
        Width = 75
      end
      item
        Caption = 'Nazwisko'
        MaxWidth = 110
        MinWidth = 110
        Width = 110
      end
      item
        Caption = 'Wzrost'
        MaxWidth = 57
        MinWidth = 57
        Width = 57
      end
      item
        Caption = 'Data urodzenia'
        MaxWidth = 100
        MinWidth = 100
        Width = 100
      end
      item
        Caption = 'Wiek'
        MaxWidth = 50
        MinWidth = 50
      end
      item
        Caption = 'Pozycja'
        MaxWidth = 100
        MinWidth = 100
        Width = 100
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    ShowWorkAreas = True
    TabOrder = 9
    ViewStyle = vsReport
    OnMouseDown = ListView1MouseDown
  end
  object Button6: TButton
    Left = 704
    Top = 255
    Width = 90
    Height = 33
    Caption = 'Usu'#324
    TabOrder = 10
    OnClick = Button6Click
  end
  object MaskEdit1: TMaskEdit
    Left = 184
    Top = 100
    Width = 64
    Height = 21
    EditMask = '!9999/99/00;1;_'
    MaxLength = 10
    TabOrder = 3
    Text = 'rrrr-mm-dd'
    TextHint = 'rrrr-mm-dd'
  end
  object Button7: TButton
    Left = 578
    Top = 255
    Width = 104
    Height = 33
    Caption = 'Edytuj'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = Button7Click
  end
  object ComboBox2: TComboBox
    Left = 568
    Top = 107
    Width = 169
    Height = 21
    Style = csDropDownList
    TabOrder = 12
    OnChange = ComboBox2Change
    Items.Strings = (
      'Imi'#281
      'Nazwisko'
      'Wzrost'
      'Data urodzenia'
      'Pozycja')
  end
  object Edit5: TEdit
    Left = 578
    Top = 360
    Width = 216
    Height = 21
    TabOrder = 13
    OnChange = Edit5Change
    OnKeyPress = Edit5KeyPress
    OnKeyUp = Edit5KeyUp
  end
  object Button8: TButton
    Left = 624
    Top = 464
    Width = 161
    Height = 41
    Caption = 'Szczeg'#243#322'y zespo'#322'u'
    TabOrder = 14
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 632
    Top = 304
    Width = 105
    Height = 17
    Caption = 'Cofnij'
    Enabled = False
    TabOrder = 15
    OnClick = Button9Click
  end
  object FileSaveDialog1: TFileSaveDialog
    DefaultExtension = 'dat'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = '.dat'
      end>
    Options = []
    OnFileOkClick = FileSaveDialog1FileOkClick
    Left = 24
    Top = 104
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object Plik1: TMenuItem
      Caption = 'Plik'
      object OtwrzPlik1: TMenuItem
        Caption = 'Otw'#243'rz'
        OnClick = OtwrzPlik1Click
      end
      object Zapiszjako1: TMenuItem
        Caption = 'Zapisz jako'
        OnClick = Zapiszjako1Click
      end
      object Zamknij1: TMenuItem
        Caption = 'Zamknij'
        OnClick = Zamknij1Click
      end
    end
    object Wygld1: TMenuItem
      Caption = 'Wygl'#261'd'
      object Styl1: TMenuItem
        Caption = 'Styl'
        object N31: TMenuItem
          Caption = 'Domy'#347'lny'
          OnClick = N31Click
        end
        object N11: TMenuItem
          Caption = 'Windows'
          OnClick = N11Click
        end
        object N21: TMenuItem
          Caption = 'Obsidian'
          OnClick = N21Click
        end
        object MetropolisUIBlue1: TMenuItem
          Caption = 'Metropolis UI Blue'
          OnClick = MetropolisUIBlue1Click
        end
      end
    end
    object Filtr1: TMenuItem
      Caption = 'Filtr'
      object Pozycja1: TMenuItem
        Caption = 'Pozycja'
        object Filtratak: TMenuItem
          Caption = 'Atakuj'#261'cy'
          Checked = True
          OnClick = FiltratakClick
        end
        object Filtrlib: TMenuItem
          Caption = 'Libero'
          Checked = True
          OnClick = FiltrlibClick
        end
        object Filtrprz: TMenuItem
          Caption = 'Przyjmuj'#261'cy'
          Checked = True
          OnClick = FiltrprzClick
        end
        object Filtrroz: TMenuItem
          Caption = 'Rozgrywaj'#261'cy'
          Checked = True
          OnClick = FiltrrozClick
        end
        object Filtrśro: TMenuItem
          Caption = #346'rodkowy'
          Checked = True
          OnClick = FiltrśroClick
        end
      end
      object Wzrost1: TMenuItem
        Caption = 'Wzrost'
        OnClick = Wzrost1Click
      end
      object Wyszyfiltyr1: TMenuItem
        Caption = 'Wyszy'#347#263' filtry'
        OnClick = Wyszyfiltyr1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 760
    Top = 16
    object Cad1: TMenuItem
      Caption = 'Edytuj'
      OnClick = Cad1Click
    end
    object Usu1: TMenuItem
      Caption = 'Usu'#324
      OnClick = Usu1Click
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = '.dat'
        FileMask = '*.dat'
      end>
    Options = [fdoStrictFileTypes]
    OnFileOkClick = FileOpenDialog1FileOkClick
    Left = 24
    Top = 64
  end
end
