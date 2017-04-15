unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Unit1, Vcl.StdCtrls,DateUtils;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


procedure TForm2.FormHide(Sender: TObject);
begin
form1.Enabled:=True;
end;

procedure TForm2.FormShow(Sender: TObject);
var
wzrost,b,wiek,nww,nmw,nsz,nmz:integer;//nww - najwiêkszy wzrost, nmw - najmniejszy wzrost,nmz- najm³odszy zawodnik, nsz - najstarzszy zawodnik
c:extended;
cur:plist;
begin
form1.Enabled:=False;
cur:=first;
wzrost:=0;
b:=0;
wiek:=0;
nww:=0;//najwy¿szy zawodnik
nmw:=1000;//najni¿szy zawodnik
nmz:=1000;//najm³odszy zawodnik
nsz:=0;//najstarszy zawodnik
while cur<>nil do
begin
wzrost:=wzrost+cur.wzrost;
wiek:=wiek+yearsbetween(Now,cur^.data);
if yearsbetween(Now,cur^.data)>nsz then
nsz:=yearsbetween(Now,cur^.data);
if yearsbetween(Now,cur^.data)<nmz then
nmz:=yearsbetween(Now,cur^.data);
if cur^.wzrost>nww then
nww:=cur^.wzrost;
if cur^.wzrost<nmw then
nmw:=cur^.wzrost;
cur:=cur^.wsk;
b:=b+1;
end;
if b<>0 then
begin
c:=wzrost/b;
if (nsz in [22,23,24]) then
label9.Caption:=inttostr(nsz)+' lata'
else
label9.Caption:=inttostr(nsz)+' lat';
if (nmz in [22,23,24])  then
label10.Caption:=inttostr(nmz)+' lata'
else
label10.Caption:=inttostr(nmz)+' lat';

label1.caption:=formatfloat('0.00',c)+'cm';
label4.Caption:=formatfloat('0.0',wiek/b)+' lat';

label11.Caption:=inttostr(nww)+'cm';
label12.Caption:=inttostr(nmw)+'cm';
end
else

end;

end.
