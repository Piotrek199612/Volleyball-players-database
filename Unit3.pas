unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Strutils,DateUtils;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
uses
Unit1;

 procedure wyswietl(first:plist);
var
cur:plist;
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
 i:=0;
while cur^.wsk <> nil do
  begin
  form1.ListView1.Items.Add.caption:=inttostr(lp);
  Form1.ListView1.Items.Item[i].SubItems.add(cur^.Imiê);
  Form1.ListView1.Items.Item[i].subitems.add(cur^.Nazwisko);
  Form1.ListView1.Items.Item[i].SubItems.add(inttostr(cur^.wzrost));
  Form1.ListView1.Items.Item[i].SubItems.add(datetostr(cur^.data));
  Form1.ListView1.Items.Item[i].SubItems.add(inttostr(yearsbetween(Now,cur^.data)));
  Form1.ListView1.Items.Item[i].SubItems.add(cur^.pozycja);
  cur:=cur^.wsk;
  lp:=lp+1;
  i:=i+1;
end;
if cur^.wsk=nil then
   form1.ListView1.Items.Add.caption:=inttostr(lp);
 Form1.ListView1.Items.Item[i].SubItems.add(cur^.Imiê);
 Form1.ListView1.Items.Item[i].SubItems.add(cur^.Nazwisko);
  Form1.ListView1.Items.Item[i].SubItems.add(inttostr(cur^.wzrost));
 Form1.ListView1.Items.Item[i].SubItems.add(datetostr(cur^.data));
 Form1.ListView1.Items.Item[i].SubItems.add(inttostr(yearsbetween(Now,cur^.data)));
  Form1.ListView1.Items.Item[i].SubItems.add(cur^.pozycja);
  cur:=cur^.wsk;
  lp:=lp+1;
  i:=i+1;
except

end;
end;





procedure Filtr(pozycja:string);
var
n,m:integer;
begin
n:=0;
m:=form1.listview1.Items.Count;
  while n<>m do
    begin
    if form1.Listview1.Items[n].SubItems[5]<>pozycja then
      begin
      n:=n+1;
      end
  else
      begin
      m:=m-1;
      form1.listview1.Items[n].Delete;
      end;
  end;
end;

procedure Filtroj;
begin
if form1.Filtratak.Checked=False then
  Filtr('Atakuj¹cy');
if form1.Filtrlib.Checked=False then
  Filtr('Libero');
if form1.Filtrprz.Checked=False then
  Filtr('Przyjmuj¹cy');
if form1.Filtrroz.Checked=False then
  Filtr('Rozgrywaj¹cy');
if form1.Filtrœro.Checked=False then
  Filtr('Œrodkowy');
end;

procedure filtrwzrost(a:string;b:string;j:integer);
var
i:integer;
c:string;
begin
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





procedure TForm3.Button1Click(Sender: TObject);
var
i,j:integer;
a,b,c:string;
begin
form1.ListView1.Clear;
wyswietl(first);
filtroj();
a:=(edit1.Text);
b:=(edit2.Text);
j:=Form1.ListView1.Items.Count;
filtrwzrost(a,b,j);
close;
end;


procedure TForm3.Button2Click(Sender: TObject);
begin
Close;
end;



procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if  not (Key in [#8,'0', '1', '2', '3', '4', '5','6', '7', '8', '9']) then
    Key:=#0;
end;

procedure TForm3.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if  not (Key in [#8,'0', '1', '2', '3', '4', '5','6', '7', '8', '9']) then
    Key:=#0;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
edit1.Text:='0';
edit2.Text:='999';
end;

end.
