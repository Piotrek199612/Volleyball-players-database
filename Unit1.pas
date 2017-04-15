unit Unit1;

interface

uses
  sharemem,Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, menus, ShellApi,
  Vcl.ComCtrls,DateUtils, Vcl.Mask,Vcl.Themes,Strutils;

type
  TForm1 = class(TForm)
    Button1, Button3,Button4,Button5, Button6, Button7,Button8, Button9 : TButton;
    Edit1, Edit2, Edit3,Edit5: TEdit;
    Label1, Label2, Label3,Label4, Label5,Label7,Label8: TLabel;
    ComboBox1: TComboBox;
    ListView1: TListView;
    MaskEdit1: TMaskEdit;
    ComboBox2: TComboBox;
    MainMenu1: TMainMenu;
    Plik1,OtwrzPlik1, Zamknij1, Zapiszjako1,Wygld1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Cad1, Usu1, Styl1, N11, N21, N31, MetropolisUIBlue1, Wyszyfiltyr1: TMenuItem;
    Filtr1, Pozycja1, Filtratak, Filtrlib, Filtrprz, Filtrroz, Filtrœro, Wzrost1: TMenuItem;
    FileSaveDialog1: TFileSaveDialog;
    FileOpenDialog1: TFileOpenDialog;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FileOpenDialog1FileOkClick(Sender: TObject;
      var CanClose: Boolean);
    procedure FileSaveDialog1FileOkClick(Sender: TObject;
      var CanClose: Boolean);
    procedure Zapiszjako1Click(Sender: TObject);
    procedure OtwrzPlik1Click(Sender: TObject);
    procedure Zamknij1Click(Sender: TObject);
    procedure Otwrz1Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button8Click(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Cad1Click(Sender: TObject);
    procedure Usu1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure MetropolisUIBlue1Click(Sender: TObject);
    procedure FiltratakClick(Sender: TObject);
    procedure FiltrlibClick(Sender: TObject);
    procedure FiltrprzClick(Sender: TObject);
    procedure FiltrrozClick(Sender: TObject);
    procedure FiltrœroClick(Sender: TObject);
    procedure Wzrost1Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Wyszyfiltyr1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
type  plist=^idk;
    idk =record
    Imiê : shortstring;
    Nazwisko :shortstring;
    wzrost : integer;
    data : Tdatetime;
    pozycja : shortstring;
    wsk:plist;
      end;
var
  Form1: TForm1;
  nazwiska :file of idk;
  osoba :idk;
  i:integer;
  first,cofnijfirst:plist;
  x:Hmodule;

  implementation

{$R *.dfm}
uses
Unit2,Unit3;
procedure Filtr(Listview1:Tlistview;pozycja:string);
  var
    n,m:integer;
  begin
    n:=0;
    m:=listview1.Items.Count;
    while n<>m do
      begin
        if Listview1.Items[n].SubItems[5]<>pozycja then
          begin
          n:=n+1;
          end
        else
         begin
          m:=m-1;
          listview1.Items[n].Delete;
          end;
      end;
  end;

procedure Filtroj(Listview1:Tlistview;Filtratak:TMenuitem;Filtrlib:TMenuitem;Filtrprz:TMenuitem;Filtrroz:TMenuitem;Filtrœro:TMenuitem;a:string;b:string;j:integer);
  var
    c:string;
    i:integer;
  begin
    if Filtratak.Checked=False then
      Filtr(listview1,'Atakuj¹cy');
    if Filtrlib.Checked=False then
      Filtr(listview1,'Libero');
    if Filtrprz.Checked=False then
      Filtr(listview1,'Przyjmuj¹cy');
    if Filtrroz.Checked=False then
      Filtr(listview1,'Rozgrywaj¹cy');
    if Filtrœro.Checked=False then
      Filtr(listview1,'Œrodkowy');
    i:=0;
    j:=Form1.ListView1.Items.Count;
    while i<j do
      begin
        c:=(Form1.ListView1.Items.Item[i].SubItems[2]);
        c :=leftstr(c,3);
        if ((c>=a) and (c<=b))  then
          begin
            i:=i+1;
          end
        else
          begin
            form1.ListView1.Items.Item[i].Delete;
            j:=j-1;
          end;
      end;
  end;

 procedure wyswietl(listview1:Tlistview);
  var
    cur:plist;
    item: TListItem;
    lp:integer;
    listanazwisko:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;   var first:plist);
    x:Hmodule;
begin
  x:=loadlibrary('Project2.dll');
  @listanazwisko:=getprocaddress(x,'listanazwisko');
  try
    reset(nazwiska);
    if first=nil then
      begin
      seek(nazwiska,0);
      while eof(nazwiska)<>true do
        begin
          read(nazwiska,osoba);
          listanazwisko(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
        end;
      end;
      if first=nil then
        messagebox(0,'Brak danych w bazie' , 'Brak danych',MB_ICONINFORMATION);
      cur:=first;
      lp:=1;
      while cur^.wsk <> nil do
        begin
          item := ListView1.items.add;
          item.caption:=inttostr(lp);
          item.subitems.add(cur^.Imiê);
          item.subitems.add(cur^.Nazwisko);
          item.subitems.add(inttostr(cur^.wzrost));
          item.subitems.add(datetostr(cur^.data));
          item.SubItems.Add(inttostr(yearsbetween(Now,cur^.data)));
          item.subitems.add(cur^.pozycja);
          cur:=cur^.wsk;
          lp:=lp+1;
        end;
      if cur^.wsk=nil then
        item := ListView1.items.add;
      item.caption:=inttostr(lp);
      item.subitems.add(cur^.Imiê);
      item.subitems.add(cur^.Nazwisko);
      item.subitems.add(inttostr(cur^.wzrost));
      item.subitems.add(datetostr(cur^.data));
      item.SubItems.Add(inttostr(yearsbetween(Now,cur^.data)));
      item.subitems.add(cur^.pozycja);
      cur:=cur^.wsk;
      lp:=lp+1;
  except

  end;
end;

procedure zapiszliste(first:plist);
  var
    cur:plist;
  begin
    rewrite(nazwiska);
    reset(nazwiska);
    seek(nazwiska,0);
    cur:=first;
    while cur<>nil do
      begin
        osoba.Imiê:=cur.Imiê;
        osoba.Nazwisko:=cur.Nazwisko;
        osoba.wzrost:=cur.wzrost;
        osoba.data:=cur.data;
        osoba.pozycja:=cur.pozycja;
        write(nazwiska,osoba);
        cur:=cur^.wsk;
      end;

  end;

procedure TForm1.FiltratakClick(Sender: TObject);
//Filtr Atakuj¹cy
  var
    lp:integer;
    a,b:string;
    j:integer;
begin
  a:=form3.Edit1.Text;
  b:=form3.Edit2.Text;
  j:=Form1.ListView1.Items.Count;
  if Filtratak.checked=True then
    begin
      Filtratak.Checked:=False;
      Filtr(listview1,'Atakuj¹cy');
    end
  else
  begin
    listview1.Clear;
    wyswietl(listview1);
    Filtratak.Checked:=True;
    filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
  end;
end;


procedure TForm1.FiltrlibClick(Sender: TObject);
//Filtr Libero
var
 lp:integer;
 a,b:string;
 j:integer;
begin
    a:=form3.Edit1.Text;
    b:=form3.Edit2.Text;
    j:=Form1.ListView1.Items.Count;
  if Filtrlib.checked=True then
    begin
      Filtrlib.Checked:=False;
      Filtr(listview1,'Libero');
    end
  else
    begin
      listview1.Clear;
      wyswietl(listview1);
      Filtrlib.Checked:=True;
      filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
    end;

end;


procedure TForm1.FiltrprzClick(Sender: TObject);
//Filtr Przyjmuj¹cy
  var
    lp:integer;
    a,b:string;
    j:integer;
  begin
    a:=form3.Edit1.Text;
    b:=form3.Edit2.Text;
    j:=Form1.ListView1.Items.Count;
    if Filtrprz.checked=True then
      begin
        Filtrprz.Checked:=False;
        Filtr(listview1,'Przyjmuj¹cy');
      end
    else
      begin
        listview1.Clear;
        wyswietl(listview1);
        Filtrprz.Checked:=True;
        filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
      end;
  end;

procedure TForm1.FiltrrozClick(Sender: TObject);
//Filtr Rozgrywaj¹cy
var
 lp:integer;
 a,b:string;
 j:integer;
begin
  a:=form3.Edit1.Text;
  b:=form3.Edit2.Text;
  j:=Form1.ListView1.Items.Count;
  if Filtrroz.checked=True then
    begin
      Filtrroz.Checked:=False;
      Filtr(listview1,'Rozgrywaj¹cy');
    end
  else
    begin
      listview1.Clear;
      wyswietl(listview1);
      Filtrroz.Checked:=True;
      filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
    end;

end;

procedure TForm1.FiltrœroClick(Sender: TObject);
//Filtr Œrodkowy
var
 lp:integer;
 a,b:string;
 j:integer;
begin
  a:=form3.Edit1.Text;
  b:=form3.Edit2.Text;
  j:=Form1.ListView1.Items.Count;
  if Filtrœro.checked=True then
    begin
      Filtrœro.Checked:=False;
      Filtr(listview1,'Œrodkowy');
    end
  else
    begin
      listview1.Clear;
      wyswietl(listview1);
      Filtrœro.Checked:=True;
      filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
    end;
end;


procedure TForm1.Button1Click(Sender: TObject);
//dodaj
var
  a,b:string;
  j:integer;
  cur,prev:plist;
  item: TListItem;
  listanazwisko:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listaimie:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listawzrost:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listapozycja:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listadata:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
begin
  try
    x:=loadlibrary('Project2.dll');
    @listanazwisko:=getprocaddress(x,'listanazwisko');
    @listaimie:=getprocaddress(x,'listaimie');
    @listadata:=getprocaddress(x,'listadata');
    @listawzrost:=getprocaddress(x,'listawzrost');
    @listapozycja:=getprocaddress(x,'listapozycja');
    reset(nazwiska);
    Seek(nazwiska, FileSize(nazwiska));
    if ((edit1.Text<>'') and (edit2.Text<>'') and(edit3.Text <> '') and(maskedit1.text<>'') and(combobox1.text<> '') and(maskedit1.Text<>'rrrr-mm-dd')) then
      begin
        listview1.clear;
        edit1.text:=uppercase(edit1.text[1])+Copy(Edit1.Text, 2, Length(Edit1.Text));
        edit2.text:=uppercase(edit2.text[1])+Copy(Edit2.Text, 2, Length(Edit2.Text));
        osoba.Imiê:=shortstring(edit1.Text);
        osoba.Nazwisko:=shortstring(edit2.Text);
        osoba.data:=strtodate(maskedit1.text);
        osoba.wzrost:=strtoint(edit3.Text);
        osoba.pozycja:=shortstring(combobox1.Text);
        if combobox2.ItemIndex=0 then
          listaimie(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
        if combobox2.ItemIndex=1 then
          listanazwisko(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
        if combobox2.ItemIndex=2 then
          listawzrost(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
        if combobox2.ItemIndex=3 then
          listadata(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
        if combobox2.ItemIndex=4 then
          listapozycja(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
        write(nazwiska, osoba);
        closefile(nazwiska);
        edit1.Clear;
        edit2.Clear;
        edit3.Clear;
        maskedit1.Text:='rrrr-mm-dd';
        edit5.Text:=#0;
        listview1.Clear;
        Button7.Caption:='Edytuj';
        Button7.Enabled:=True;
        popupmenu1.Items[0].Enabled:=True;

        wyswietl(listview1)
      end
    else
      messagebox(Handle,'Wype³nij wzystkie pola' , 'Brak danych',MB_ICONINFORMATION);


  a:=form3.Edit1.Text;
  b:=form3.Edit2.Text;
  j:=Form1.ListView1.Items.Count;
    filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
    i:=0;
    if ((osoba.Imiê=listview1.Items[0].SubItems[0]) and (osoba.Nazwisko=listview1.Items[1].SubItems[1])) then
     listview1.Items[i].Selected:=True
     else
     begin
     while (osoba.Imiê<>listview1.Items[i].SubItems[0]) or (osoba.Nazwisko<>listview1.Items[i].SubItems[1]) or(osoba.wzrost<>strtoint(listview1.Items[i].SubItems[2])) or (osoba.data<>strtodatetime(listview1.Items[i].SubItems[3]))   do
       i:=i+1;
        listview1.Items[i].Selected:=True;
     end;  except
  end;
end;



procedure TForm1.Button3Click(Sender: TObject);
//zamknij
begin
  close;
end;

procedure TForm1.Button5Click(Sender: TObject);
//wyczyœæ
var
  del:plist;
begin
if filesize(nazwiska)=0 then
messagebox(Handle,'Brak danych w pliku' , 'Baza Danych',MB_ICONINFORMATION)
else
if messagebox(Handle,'Czy napewno chcesz usun¹æ wszystkie dane?' , 'Baza Danych',MB_YESNO)=IDYes then
  begin
  listview1.clear;
  rewrite(nazwiska);
  while first <>nil do
    begin
    del:=first;
    first:=first^.wsk;
    dispose(del);
    end;
  end;
end;


procedure TForm1.Button6Click(Sender: TObject);
//usuñ
var
  index,lp,j:integer;
  usun, prev,cur, next,cofnij,cofnijnext:plist;
  a,b:string;
begin
 a:=form3.Edit1.Text;
      b:=form3.Edit2.Text;
      j:=Form1.ListView1.Items.Count;
index:=0;
while ((index<listview1.Items.Count) and (listview1.Items.Item[index].Selected=False)) do
 begin
 index:=index+1;
 end;
 if (index>=listview1.Items.Count) then messagebox(Handle,'¯aden element nie zosta³ zaznaczony' , 'Baza Danych',MB_ICONINFORMATION)
 else
 begin
  lp:=listview1.Items.Count;
  if (index<0) then
    messagebox(Handle,'Baza jest pusta' , 'Baza Danych',MB_ICONINFORMATION)
  else
    begin
        if index<lp then
         begin
         cur:=first;
         new(usun);
        usun^.Imiê:=listview1.Items.Item[index].SubItems[0];
        usun^.Nazwisko:=listview1.Items.Item[index].SubItems[1];
        usun^.wzrost:=strtoint(listview1.Items.Item[index].SubItems[2]);
        usun^.data:=strtodate(listview1.Items.Item[index].SubItems[3]);
        usun^.pozycja:=listview1.Items.Item[index].SubItems[5];
         while not((usun^.Imiê=cur^.Imiê) and (usun^.Nazwisko=cur^.Nazwisko) and (usun^.wzrost=cur^.wzrost) and (usun^.data=cur^.data) and (usun^.pozycja=cur^.pozycja)) do
            begin
              prev:=cur;
              cur:=cur^.wsk;
            end;

        if ((first^.Imiê=cur^.Imiê) and (first^.Nazwisko=cur^.Nazwisko) and (first^.wzrost=cur^.wzrost) and (first^.data=cur^.data) and (first^.pozycja=cur^.pozycja)) then
          begin
           usun:=first;
           first:=first^.wsk;
           new(cofnij);
          cofnij.Imiê:=usun.Imiê;
          cofnij.Nazwisko:=usun.Nazwisko;
          cofnij.wzrost:=usun.wzrost;
          cofnij.data:=usun.data;
          cofnij.pozycja:=usun.pozycja;
          dispose(usun);
          Button9.Enabled:=true;
          zapiszliste(first);
        end
        else
         begin
          new(cofnij);
          cofnij^.Imiê:=usun.Imiê;
          cofnij^.Nazwisko:=usun.Nazwisko;
          cofnij^.data:=usun.data;
          cofnij^.pozycja:=usun.pozycja;
          cofnij^.wzrost:=usun.wzrost;
          prev^.wsk:=cur^.wsk;
          dispose(cur);
          Button9.Enabled:=true;
          zapiszliste(first);
        end;


      if cofnijfirst=nil then
        begin
          new(cofnijfirst);
          cofnijfirst.Imiê:=cofnij.Imiê;
          cofnijfirst.Nazwisko:=cofnij.Nazwisko;
          cofnijfirst.wzrost:=cofnij.wzrost;
          cofnijfirst.data:=cofnij.data;
          cofnijfirst.pozycja:=cofnij.pozycja;
          cofnijfirst.wsk:=nil;
        end;
      if cofnijfirst<>nil then
        begin
          cofnijnext:=cofnijfirst;
          cofnijfirst:=cofnij;
          cofnij.wsk:=cofnijnext;
        end;
       edit5.Text:=#0;
      listview1.Clear;
      wyswietl(listview1);
      filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
      if index<listview1.Items.Count then
      listview1.Items.Item[index].Selected:=True;
        end;
    end;
  end;


end;



procedure TForm1.Button7Click(Sender: TObject);
//edytuj
var
  index,itemindex,lpmax,j:integer;
  usun, prev,cur, next:plist;
  item: TListItem;
  a,b:string;
begin
      a:=form3.Edit1.Text;
      b:=form3.Edit2.Text;
      j:=Form1.ListView1.Items.Count;
index:=0;
while ((index<listview1.Items.Count) and (listview1.Items.Item[index].Selected=False)) do
 begin
 index:=index+1;
 end;
 if (index>=listview1.Items.Count) then messagebox(Handle,'¯aden element nie zosta³ zaznaczony' , 'Baza Danych',MB_ICONINFORMATION)
 else
 begin
  lpmax:=listview1.Items.Count;
  if (index>lpmax) then
    messagebox(Handle,'Element o podanym numerze nie istnieje' , 'Brak danego indexu',MB_ICONINFORMATION)
  else
    begin
      new(usun);
      usun.Imiê:=listview1.Items[index].SubItems[0];
      usun.Nazwisko:=listview1.Items[index].SubItems[1];
      usun.wzrost:=strtoint(listview1.Items[index].SubItems[2]);
      usun.data:=strtodatetime(listview1.Items[index].SubItems[3]);
      usun.pozycja:=listview1.Items[index].SubItems[5];

      if ((usun.Imiê=first^.Imiê) and (usun.Nazwisko=first^.Nazwisko) and(usun.wzrost=first^.wzrost) and (usun.data=first^.data) and (usun.pozycja=first^.pozycja))then
      begin
       first:=first^.wsk;
            edit1.text:=usun.Imiê;
            edit2.text:=usun.Nazwisko;
            edit3.text:=inttostr(usun.wzrost);
            maskedit1.Text:=datetostr(usun.data);
            if usun.pozycja='Przyjmuj¹cy' then
             itemindex:=0;
            if usun.pozycja='Rozgrywaj¹cy' then
             itemindex:=1;
           if usun.pozycja='Atakuj¹cy' then
             itemindex:=2;
           if usun.pozycja='Œrodkowy' then
             itemindex:=3;
           if usun.pozycja='Libero' then
             itemindex:=4;
           combobox1.ItemIndex:=itemindex;
              dispose(usun);
           rewrite(nazwiska);
           zapiszliste(first);
           listview1.Clear;
          edit5.clear;
          wyswietl(listview1);
          filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);

      end
      else
       begin
       cur:=first;
       prev:=nil;
       while ((cur.Imiê<>usun.Imiê) or (cur.Nazwisko<>usun.Nazwisko) or (cur.wzrost<>usun.wzrost) or (cur.data<>usun.data  )or (cur.pozycja<>usun.pozycja)) do
       begin
       prev:=cur;
       cur:=cur^.wsk;
       end;
                   edit1.text:=usun.Imiê;
            edit2.text:=usun.Nazwisko;
            edit3.text:=inttostr(usun.wzrost);
            maskedit1.Text:=datetostr(usun.data);
            if usun.pozycja='Przyjmuj¹cy' then
               itemindex:=0;
            if usun.pozycja='Rozgrywaj¹cy' then
               itemindex:=1;
            if usun.pozycja='Atakuj¹cy' then
               itemindex:=2;
            if usun.pozycja='Œrodkowy' then
               itemindex:=3;
            if usun.pozycja='Libero' then
               itemindex:=4;
            combobox1.ItemIndex:=itemindex;
       prev^.wsk:=cur^.wsk;
       dispose(cur);
       dispose(usun);
       rewrite(nazwiska);
            zapiszliste(first);
            listview1.Clear;
            edit5.clear;
            wyswietl(listview1);
             filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);


      end;

          button7.Enabled:=False;
          Button7.Caption:='Aby zakoñczyæ edycjê'+#10+'dodaj rekord';
          popupmenu1.Items[0].Enabled:=False;
      end;
    end;
end;



procedure TForm1.Button8Click(Sender: TObject);
//Szczegó³y
begin
  Form2.Show;
end;




procedure TForm1.Button9Click(Sender: TObject);
//Cofnij
var
  a,b:string;
  j:integer;
  cofnijnext:plist;
    listanazwisko:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listaimie:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listawzrost:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listapozycja:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listadata:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
begin
    a:=form3.Edit1.Text;
      b:=form3.Edit2.Text;
      j:=Form1.ListView1.Items.Count;
    x:=loadlibrary('Project2.dll');
    @listanazwisko:=getprocaddress(x,'listanazwisko');
    @listaimie:=getprocaddress(x,'listaimie');
    @listadata:=getprocaddress(x,'listadata');
    @listawzrost:=getprocaddress(x,'listawzrost');
    @listapozycja:=getprocaddress(x,'listapozycja');
  if cofnijfirst^.wsk<>nil then
    begin
     if combobox2.ItemIndex=0 then
          listaimie(cofnijfirst.Imiê,cofnijfirst.Nazwisko,cofnijfirst.wzrost,cofnijfirst.data,cofnijfirst.pozycja,first);
        if combobox2.ItemIndex=1 then
          listanazwisko(cofnijfirst.Imiê,cofnijfirst.Nazwisko,cofnijfirst.wzrost,cofnijfirst.data,cofnijfirst.pozycja,first);
        if combobox2.ItemIndex=2 then
          listawzrost(cofnijfirst.Imiê,cofnijfirst.Nazwisko,cofnijfirst.wzrost,cofnijfirst.data,cofnijfirst.pozycja,first);
        if combobox2.ItemIndex=3 then
          listadata(cofnijfirst.Imiê,cofnijfirst.Nazwisko,cofnijfirst.wzrost,cofnijfirst.data,cofnijfirst.pozycja,first);
        if combobox2.ItemIndex=4 then
          listapozycja(cofnijfirst.Imiê,cofnijfirst.Nazwisko,cofnijfirst.wzrost,cofnijfirst.data,cofnijfirst.pozycja,first);
      cofnijnext:=cofnijfirst^.wsk;
      dispose(cofnijfirst);
      cofnijfirst:=cofnijnext;
    end;
    if cofnijfirst^.wsk=nil then
      button9.Enabled:=false;
    listview1.clear;
    wyswietl(listview1);
    filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
    zapiszliste(first);
end;

procedure TForm1.Cad1Click(Sender: TObject);
//Popup Menu Edytuj
var
  index,itemindex,lpmax:integer;
  usun, prev,cur, next:plist;
  item: TListItem;
begin
index:=0;
while ((index<listview1.Items.Count) and (listview1.Items.Item[index].Selected=False)) do
 begin
 index:=index+1;
 end;
 if (index>=listview1.Items.Count) then messagebox(Handle,'¯aden element nie zosta³ zaznaczony' , 'Baza Danych',MB_ICONINFORMATION)
 else
 begin
  lpmax:=listview1.Items.Count;
  if (index>lpmax) then
    messagebox(Handle,'Element o podanym numerze nie istnieje' , 'Brak danego indexu',MB_ICONINFORMATION)
  else
    begin
      try
        if index =0 then
          begin
            usun:=first;
            first:=first^.wsk;
            edit1.text:=usun.Imiê;
            edit2.text:=usun.Nazwisko;
            edit3.text:=inttostr(usun.wzrost);
            maskedit1.Text:=datetostr(usun.data);
            if usun.pozycja='Przyjmuj¹cy' then
             itemindex:=0;
            if usun.pozycja='Rozgrywaj¹cy' then
             itemindex:=1;
           if usun.pozycja='Atakuj¹cy' then
             itemindex:=2;
           if usun.pozycja='Œrodkowy' then
             itemindex:=3;
           if usun.pozycja='Libero' then
             itemindex:=4;
           combobox1.ItemIndex:=itemindex;
            if first =nil then
              dispose(usun);
           listview1.Clear;
           wyswietl(listview1);
           zapiszliste(first);
          end;
        if index>0  then
          begin
            cur:=first;
            usun:=cur;
            for I := 1 to index-1 do
              begin
              cur:=cur^.wsk;
              end;
            usun:=cur^.wsk;
            next:=usun^.wsk;
            edit1.text:=usun.Imiê;
            edit2.text:=usun.Nazwisko;
            edit3.text:=inttostr(usun.wzrost);
            maskedit1.Text:=datetostr(usun.data);
            if usun.pozycja='Przyjmuj¹cy' then
               itemindex:=0;
            if usun.pozycja='Rozgrywaj¹cy' then
               itemindex:=1;
            if usun.pozycja='Atakuj¹cy' then
               itemindex:=2;
            if usun.pozycja='Œrodkowy' then
               itemindex:=3;
            if usun.pozycja='Libero' then
               itemindex:=4;
            combobox1.ItemIndex:=itemindex;
            dispose(usun);
            cur^.wsk:=next;
            rewrite(nazwiska);
            zapiszliste(first);
            listview1.Clear;
            wyswietl(listview1);
          end;
       except
      end;
    end;
end;
end;

procedure TForm1.Usu1Click(Sender: TObject);
//Popup menu usuñ
var
  index,lp:integer;
  usun, prev,cur, next,cofnij,cofnijnext:plist;
  item: TListItem;
begin
  lp:=listview1.Items.Count;
  index:=0;
while ((index<listview1.Items.Count) and (listview1.Items.Item[index].Selected=False)) do
 begin
 index:=index+1;
 end;
 if (index>=listview1.Items.Count) then messagebox(Handle,'¯aden element nie zosta³ zaznaczony' , 'Baza Danych',MB_ICONINFORMATION)
 else
 begin
  lp:=listview1.Items.Count;
  if ((index>lp) or (index<0)) then
    messagebox(Handle,'Baza jest pusta' , 'Baza Danych',MB_ICONINFORMATION)
  else
    begin
      if index =0 then
      begin
        usun:=first;
        first:=first^.wsk;
        new(cofnij);
        cofnij.Imiê:=usun.Imiê;
        cofnij.Nazwisko:=usun.Nazwisko;
        cofnij.wzrost:=usun.wzrost;
        cofnij.data:=usun.data;
        cofnij.pozycja:=usun.pozycja;
        dispose(usun);
        Button9.Enabled:=true;
        zapiszliste(first);
      end;
    if index>0  then
      begin
        cur:=first;
        usun:=cur;
          for I := 1 to index-1 do
            begin
              cur:=cur^.wsk;
            end;
        usun:=cur^.wsk;
        next:=usun^.wsk;
        new(cofnij);
        cofnij.Imiê:=usun.Imiê;
        cofnij.Nazwisko:=usun.Nazwisko;
        cofnij.wzrost:=usun.wzrost;
        cofnij.data:=usun.data;
        cofnij.pozycja:=usun.pozycja;
        dispose(usun);
        cur^.wsk:=next;
        rewrite(nazwiska);
        Button9.Enabled:=true;
       zapiszliste(first);
      end;
    if cofnijfirst=nil then
      begin
        new(cofnijfirst);
        cofnijfirst.Imiê:=cofnij.Imiê;
        cofnijfirst.Nazwisko:=cofnij.Nazwisko;
        cofnijfirst.wzrost:=cofnij.wzrost;
        cofnijfirst.data:=cofnij.data;
        cofnijfirst.pozycja:=cofnij.pozycja;
        cofnijfirst.wsk:=nil;
      end;
    if cofnijfirst<>nil then
      begin
        cofnijnext:=cofnijfirst;
        cofnijfirst:=cofnij;
        cofnij.wsk:=cofnijnext;
      end;
    listview1.Clear;
    wyswietl(listview1);
    end;
end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
//Sortuj Wed³ug
var
  a,b:string;
  j:integer;
  del:plist;
  listanazwisko:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;   var first:plist);
  listaimie:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listawzrost:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listapozycja:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
  listadata:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;var first:plist);
begin
  x:=loadlibrary('Project2.dll');
  @listanazwisko:=getprocaddress(x,'listanazwisko');
  @listaimie:=getprocaddress(x,'listaimie');
  @listadata:=getprocaddress(x,'listadata');
  @listawzrost:=getprocaddress(x,'listawzrost');
  @listapozycja:=getprocaddress(x,'listapozycja');
  listview1.Clear;
  while first <>nil do
    begin
      a:=form3.Edit1.Text;
      b:=form3.Edit2.Text;
      j:=Form1.ListView1.Items.Count;
      del:=first;
      first:=first^.wsk;
      dispose(del);
    end;
  reset(nazwiska);
  seek(nazwiska,0);
  case combobox2.itemindex of
   0: while eof(nazwiska)<>true do
    begin
     read(nazwiska,osoba);
     listaimie(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,first);
    end;
   1:while eof(nazwiska)<>true do
    begin
     read(nazwiska,osoba);
     listanazwisko(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,first);
    end;
   2:while eof(nazwiska)<>true do
    begin
     read(nazwiska,osoba);
     listawzrost(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,first);
    end;
   3:while eof(nazwiska)<>true do
    begin
     read(nazwiska,osoba);
     listadata(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,first);
    end;
   4:while eof(nazwiska)<>true do
    begin
     read(nazwiska,osoba);
     listapozycja(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,first);
    end;
  end;
  wyswietl(listview1);
  filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
end;



procedure TForm1.Edit1Change(Sender: TObject);
begin
      if edit1.Text<>'' then
  edit1.text:=Ansiuppercase(edit1.text[1])+Copy(Edit1.Text, 2, Length(Edit1.Text));
  edit1.SelStart:=Length(edit1.Text);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if  (Key in [#33..#44,#46..#64,#91..#96,#123..#126]) then
    Key:=#0;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
      if edit2.Text<>'' then
  edit2.text:=Ansiuppercase(edit2.text[1])+Copy(Edit2.Text, 2, Length(Edit2.Text));
  edit2.SelStart:=Length(edit2.Text);
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if  (Key in [#33..#44,#46..#64,#91..#96,#123..#126]) then
    Key:=#0;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
//Wzrost Editbox
begin
  if  not (Key in [#8,'0', '1', '2', '3', '4', '5','6', '7', '8', '9']) then
    Key:=#0;
end;

procedure TForm1.Edit5Change(Sender: TObject);
//Wyszukaj Editbox
var
  a:shortstring;
  m,n:integer;
  cur:plist;
  wyszokaj:Function(a:shortstring;b:shortstring):boolean;
begin
  if edit5.Text<>'' then
  edit5.text:=Ansiuppercase(edit5.text[1])+Copy(Edit5.Text, 2, Length(Edit5.Text));
  edit5.SelStart:=Length(edit5.Text);
  x:=loadlibrary('Project2.dll');
  @wyszokaj:=getprocaddress(x,'wyszokaj');
  cur:=first;
  n:=0;
  m:=listview1.Items.Count;
  while n<>m do
    begin
      if wyszokaj(edit5.text,Listview1.Items[n].SubItems[1])=True then
        begin
          n:=n+1;
        end
      else
        begin
          m:=m-1;
          listview1.Items[n].Delete;
        end;
    end;
end;



procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
//Wyszokaj editbox
begin
  if  (Key in [#33..#44,#46..#64,#91..#96,#123..#126]) then
    Key:=#0;
  if ((Key = #8) and (edit5.Text<>'')) then
    begin
      listview1.Clear;
      wyswietl(listview1);
    end;
end;

procedure TForm1.Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
//Wyszokaj editbox
var
  a,b:string;
  j:integer;
begin
  a:=form3.Edit1.Text;
  b:=form3.Edit2.Text;
  j:=Form1.ListView1.Items.Count;
  if edit5.Text='' then
    begin
      listview1.Clear;
      wyswietl(listview1);
      filtroj(listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
    end;
end;

procedure TForm1.FileOpenDialog1FileOkClick(Sender: TObject; var CanClose: Boolean);
//Otwórz plik
var
  del:plist;
  listanazwisko:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;   var first:plist);
begin
  try
  x:=loadlibrary('Project2.dll');
  @listanazwisko:=getprocaddress(x,'listanazwisko');
  listview1.Clear;
  while first <>nil do
    begin
      del:=first;
      first:=first^.wsk;
      dispose(del);
    end;
  assignfile(nazwiska,Fileopendialog1.FileName);
  reset(nazwiska);
  seek(nazwiska,0);
  if filesize(nazwiska)<>0 then
         while eof(nazwiska)<>true do
          begin
           read(nazwiska,osoba);
           listanazwisko(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,first);
          end;
       listview1.Clear;
       reset(nazwiska);
       wyswietl(listview1);
    except
  end;
end;

procedure TForm1.FileSaveDialog1FileOkClick(Sender: TObject; var CanClose: Boolean);
//Zapisz jako
var
cur:plist;
begin
  try
  if fileexists(filesavedialog1.FileName)=true then
    begin
      if messagebox(Handle,'Istniej¹cy plik zostanie nadpisany.'+#13+'Czy chcesz kontynuowaæ' , 'Plik istnieje',MB_YESNO)=IDYes then
        begin
          cur:=first;
          assignfile(nazwiska,Filesavedialog1.FileName);
          rewrite(nazwiska);
          reset(nazwiska);
          while cur<>nil  do
            begin
             osoba.Imiê:=cur^.Imiê;
             osoba.Nazwisko:=cur^.Nazwisko;
             osoba.wzrost:=cur^.wzrost;
             osoba.data:=cur^.data;
             osoba.pozycja:=cur^.pozycja;
             write(nazwiska,osoba);
             cur:=cur^.wsk;
            end;
          reset(nazwiska);
        end
      else
    end
  else
    begin
      cur:=first;
      assignfile(nazwiska,Filesavedialog1.FileName);
      rewrite(nazwiska);
      reset(nazwiska);
     while cur<>nil  do
        begin
           osoba.Imiê:=cur^.Imiê;
           osoba.Nazwisko:=cur^.Nazwisko;
           osoba.wzrost:=cur^.wzrost;
           osoba.data:=cur^.data;
           osoba.pozycja:=cur^.pozycja;
           write(nazwiska,osoba);
           cur:=cur^.wsk;
        end;
      reset(nazwiska);
    end;
  except
  end;
end;



procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
if messagebox(Handle,'Czy napewno chcesz zakoñczyæ?' , 'Baza Danych',MB_YESNO)=IDYes then
canclose:=True
else
canclose:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  cur:plist;
  item: TListItem;
  listanazwisko:procedure (Imiê:shortstring; Nazwisko:shortstring;wzrost:integer;data:tdate; pozycja:shortstring ;   var first:plist);
  okno:procedure;
begin
   CreateMutex(nil, FALSE, 'Project1');
   if GetLastError() <> 0 then
     begin
       messagebox(Handle,'Dany program jest ju¿ otwarty' , '',MB_ICONINFORMATION);
       Halt;
     end;
  x:=loadlibrary('Project2.dll');
  @listanazwisko:=getprocaddress(x,'listanazwisko');
  assignfile(nazwiska, 'Dane\Nowyplik.dat');
  Fileopendialog1.DefaultFolder:=GetCurrentDir+'/Dane';
  Filesavedialog1.DefaultFolder:=GetCurrentDir+'/Dane';
  combobox2.ItemIndex:=1;
  if fileexists('Dane\Nowyplik.dat') then
    begin
      reset(nazwiska);
      seek(nazwiska,0);
      if filesize(nazwiska)<>0 then
       try
       while eof(nazwiska)<>true do
          begin
           read(nazwiska,osoba);
           listanazwisko(osoba.Imiê,osoba.Nazwisko,osoba.wzrost,osoba.data,osoba.pozycja,  first);
          end;
       listview1.Clear;
       reset(nazwiska);
       wyswietl(listview1);
       except
       end;
    end
    else
      rewrite(nazwiska);
end;


procedure TForm1.FormDestroy(Sender: TObject);
begin
  freelibrary(x);
end;

procedure TForm1.ListView1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
  if listview1.Items.Count<>0 then
  if (Button = mbRight) then
    Popupmenu1.Popup(mouse.CursorPos.X, mouse.CursorPos.Y);
  end;

procedure TForm1.MetropolisUIBlue1Click(Sender: TObject);
begin
  Tstylemanager.SetStyle('Metropolis UI Blue');
end;

procedure TForm1.Otwrz1Click(Sender: TObject);
begin
  zapiszliste(first);
end;

procedure TForm1.OtwrzPlik1Click(Sender: TObject);
begin
  Fileopendialog1.execute;
  combobox2.ItemIndex:=1;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  Tstylemanager.SetStyle('Windows');
end;

procedure TForm1.N21Click(Sender: TObject);
begin
  Tstylemanager.SetStyle('Obsidian');
end;


procedure TForm1.N31Click(Sender: TObject);
begin
  Tstylemanager.SetStyle('Aqua Graphite');
end;



procedure TForm1.Wyszyfiltyr1Click(Sender: TObject);
var
    a,b:string;
    j:integer;
begin
a:=form3.Edit1.Text;
b:=form3.Edit2.Text;
j:=Form1.ListView1.Items.Count;
filtratak.Checked:=True;
filtrlib.Checked:=True;
filtrprz.Checked:=True;
filtrroz.Checked:=True;
filtrœro.Checked:=True;
form3.Edit1.Text:='0';
form3.Edit2.Text:='999';
filtroj(Listview1,Filtratak,Filtrlib,Filtrprz,Filtrroz,Filtrœro,a,b,j);
listview1.clear;
wyswietl(listview1);
end;

procedure TForm1.Wzrost1Click(Sender: TObject);
begin
  Form3.show;
end;

procedure TForm1.Zamknij1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Zapiszjako1Click(Sender: TObject);
begin
  Filesavedialog1.Execute;
end;

end.
