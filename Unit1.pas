unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  System.DateUtils, System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Panel1: TPanel;
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    ListBox1: TListBox;
    Panel3: TPanel;
    Label3: TLabel;
    DateTimePicker3: TDateTimePicker;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo2: TMemo;
    Panel4: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    DateTimePicker4: TDateTimePicker;
    ImageList1: TImageList;
    CheckBox9: TCheckBox;
    function foo_day(d: tdate): boolean;
    function foo_pidpis(b: boolean; n: byte): string;
    function fun_day(d: tdate): boolean;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.foo_day(d: tdate): boolean;
var
  r: boolean;
begin
  r := False;
  if (Form1.CheckBox1.Checked) and (DayOfTheWeek(d) = 1) then
    r := True;
  if (Form1.CheckBox2.Checked) and (DayOfTheWeek(d) = 2) then
    r := True;
  if (Form1.CheckBox3.Checked) and (DayOfTheWeek(d) = 3) then
    r := True;
  if (Form1.CheckBox4.Checked) and (DayOfTheWeek(d) = 4) then
    r := True;
  if (Form1.CheckBox5.Checked) and (DayOfTheWeek(d) = 5) then
    r := True;
  if (Form1.CheckBox6.Checked) and (DayOfTheWeek(d) = 6) then
    r := True;
  if (Form1.CheckBox7.Checked) and (DayOfTheWeek(d) = 7) then
    r := True;
  Result := r;
end;

function TForm1.foo_pidpis(b: boolean; n: byte): string;
begin
  if b then
  begin
    case n of
      1:
        Result := ' - ïîíåä³ëîê';
      2:
        Result := ' - â³âòîðîê';
      3:
        Result := ' - ñåðåäà';
      4:
        Result := ' - ÷åòâåð';
      5:
        Result := ' - ï' + #96 + 'ÿòíèöÿ';
      6:
        Result := ' - ñóááîòà';
      7:
        Result := ' - íåä³ëëÿ';
    end;
  end
  else
    Result := '';

end;

function TForm1.fun_day(d: tdate): boolean;
var
  i: integer;
begin
  Result := True;
  if Form1.ListBox1.Items.Count > 0 then
    for i := 0 to Form1.ListBox1.Items.Count - 1 do
    begin
      if DateToStr(d) = Form1.ListBox1.Items.Strings[i] then
        Result := False;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: integer;
  day: array [0 .. 7] of integer;
  Mon: array [0 .. 12, 0 .. 7] of integer;

begin
  Memo1.Clear;
  for i := 0 to 7 do
    day[i] := 0;

  for i := 0 to 12 do
    for j := 0 to 7 do
      Mon[i, j] := 0;

  for i := Trunc(DateTimePicker1.Date) to Trunc(DateTimePicker2.Date) do
  begin
    if (foo_day(i)) and (fun_day(i)) then
    begin
      Memo1.Lines.Add(DateToStr(i) + foo_pidpis(CheckBox9.Checked,
        DayOfTheWeek(i)));
      inc(day[0]);
      inc(day[DayOfTheWeek(i)]);
      inc(Mon[MonthOfTheYear(i), 0]);
      inc(Mon[MonthOfTheYear(i), DayOfTheWeek(i)]);
    end;
  end;
  Memo2.Clear;
  Memo2.Lines.Add('Æóðíàë:');
  Memo2.Lines.Add('Âñüîãî äí³â: ' + IntToStr(day[0]));
  Memo2.Lines.Add('Ïîíåä³ëîê: ' + IntToStr(day[1]));
  Memo2.Lines.Add('Â³âòîðîê: ' + IntToStr(day[2]));
  Memo2.Lines.Add('Ñåðåäà: ' + IntToStr(day[3]));
  Memo2.Lines.Add('×åòâåð: ' + IntToStr(day[4]));
  Memo2.Lines.Add('Ï' + #96 + 'ÿòíèöÿ: ' + IntToStr(day[5]));
  Memo2.Lines.Add('Ñóááîòà: ' + IntToStr(day[6]));
  Memo2.Lines.Add('Íåä³ëëÿ: ' + IntToStr(day[7]));
  Memo2.Lines.Add('-#-#-#-');

  if Mon[1, 0] > 0 then
    Memo2.Lines.Add('Ñ³÷åíü: ' + IntToStr(Mon[1, 0]));
  if Mon[1, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[1, 1]));
  if Mon[1, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[1, 2]));
  if Mon[1, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[1, 3]));
  if Mon[1, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[1, 4]));
  if Mon[1, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[1, 5]));
  if Mon[1, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[1, 6]));
  if Mon[1, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[1, 7]));

  if Mon[2, 0] > 0 then
    Memo2.Lines.Add('Ëþòèé: ' + IntToStr(Mon[2, 0]));
  if Mon[2, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[2, 1]));
  if Mon[2, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[2, 2]));
  if Mon[2, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[2, 3]));
  if Mon[2, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[2, 4]));
  if Mon[2, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[2, 5]));
  if Mon[2, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[2, 6]));
  if Mon[2, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[2, 7]));

  if Mon[3, 0] > 0 then
    Memo2.Lines.Add('Áåðåçåíü: ' + IntToStr(Mon[3, 0]));
  if Mon[3, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[3, 1]));
  if Mon[3, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[3, 2]));
  if Mon[3, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[3, 3]));
  if Mon[3, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[3, 4]));
  if Mon[3, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[3, 5]));
  if Mon[3, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[3, 6]));
  if Mon[3, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[3, 7]));

  if Mon[4, 0] > 0 then
    Memo2.Lines.Add('Êâ³òåíü: ' + IntToStr(Mon[4, 0]));
  if Mon[4, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[4, 1]));
  if Mon[4, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[4, 2]));
  if Mon[4, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[4, 3]));
  if Mon[4, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[4, 4]));
  if Mon[4, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[4, 5]));
  if Mon[4, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[4, 6]));
  if Mon[4, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[4, 7]));

  if Mon[5, 0] > 0 then
    Memo2.Lines.Add('Òðàâåíü: ' + IntToStr(Mon[5, 0]));
  if Mon[5, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[5, 1]));
  if Mon[5, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[5, 2]));
  if Mon[5, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[5, 3]));
  if Mon[5, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[5, 4]));
  if Mon[5, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[5, 5]));
  if Mon[5, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[5, 6]));
  if Mon[5, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[5, 7]));

  if Mon[6, 0] > 0 then
    Memo2.Lines.Add('×åðâåíü: ' + IntToStr(Mon[6, 0]));
  if Mon[6, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[6, 1]));
  if Mon[6, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[6, 2]));
  if Mon[6, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[6, 3]));
  if Mon[6, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[6, 4]));
  if Mon[6, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[6, 5]));
  if Mon[6, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[6, 6]));
  if Mon[6, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[6, 7]));

  if Mon[7, 0] > 0 then
    Memo2.Lines.Add('Ëèïåíü: ' + IntToStr(Mon[7, 0]));
  if Mon[7, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[7, 1]));
  if Mon[7, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[7, 2]));
  if Mon[7, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[7, 3]));
  if Mon[7, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[7, 4]));
  if Mon[7, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[7, 5]));
  if Mon[7, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[7, 6]));
  if Mon[7, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[7, 7]));

  if Mon[8, 0] > 0 then
    Memo2.Lines.Add('Ñåðïåíü: ' + IntToStr(Mon[8, 0]));
  if Mon[8, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[8, 1]));
  if Mon[8, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[8, 2]));
  if Mon[8, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[8, 3]));
  if Mon[8, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[8, 4]));
  if Mon[8, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[8, 5]));
  if Mon[8, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[8, 6]));
  if Mon[8, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[8, 7]));

  if Mon[9, 0] > 0 then
    Memo2.Lines.Add('Âåðåñåíü: ' + IntToStr(Mon[9, 0]));
  if Mon[9, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[9, 1]));
  if Mon[9, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[9, 2]));
  if Mon[9, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[9, 3]));
  if Mon[9, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[9, 4]));
  if Mon[9, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[9, 5]));
  if Mon[9, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[9, 6]));
  if Mon[9, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[9, 7]));

  if Mon[10, 0] > 0 then
    Memo2.Lines.Add('Æîâòåíü: ' + IntToStr(Mon[10, 0]));
  if Mon[10, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[10, 1]));
  if Mon[10, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[10, 2]));
  if Mon[10, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[10, 3]));
  if Mon[10, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[10, 4]));
  if Mon[10, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[10, 5]));
  if Mon[10, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[10, 6]));
  if Mon[10, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[10, 7]));

  if Mon[11, 0] > 0 then
    Memo2.Lines.Add('Ëèñòîïàä: ' + IntToStr(Mon[11, 0]));
  if Mon[11, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[11, 1]));
  if Mon[11, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[11, 2]));
  if Mon[11, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[11, 3]));
  if Mon[11, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[11, 4]));
  if Mon[11, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[11, 5]));
  if Mon[11, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[11, 6]));
  if Mon[11, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[11, 7]));

  if Mon[12, 0] > 0 then
    Memo2.Lines.Add('Ãðóäåíü: ' + IntToStr(Mon[12, 0]));
  if Mon[12, 1] > 0 then
    Memo2.Lines.Add('  Ïí.: ' + IntToStr(Mon[12, 1]));
  if Mon[12, 2] > 0 then
    Memo2.Lines.Add('  Âò.: ' + IntToStr(Mon[12, 2]));
  if Mon[12, 3] > 0 then
    Memo2.Lines.Add('  Ñð.: ' + IntToStr(Mon[12, 3]));
  if Mon[12, 4] > 0 then
    Memo2.Lines.Add('  ×ò.: ' + IntToStr(Mon[12, 4]));
  if Mon[12, 5] > 0 then
    Memo2.Lines.Add('  Ïò.: ' + IntToStr(Mon[12, 5]));
  if Mon[12, 6] > 0 then
    Memo2.Lines.Add('  Ñá.: ' + IntToStr(Mon[12, 6]));
  if Mon[12, 7] > 0 then
    Memo2.Lines.Add('  Íä.: ' + IntToStr(Mon[12, 7]));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  if not CheckBox8.Checked then
  begin
    if fun_day(DateTimePicker3.Date) then
      ListBox1.Items.Add(DateToStr(DateTimePicker3.Date));
  end
  else
  begin
    for i := Trunc(DateTimePicker3.Date) to Trunc(DateTimePicker4.Date) do
      if fun_day(i) then
        ListBox1.Items.Add(DateToStr(i));
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if ListBox1.ItemIndex > -1 then
    ListBox1.Items.Delete(ListBox1.ItemIndex)
  else
    ShowMessage('Íå âèáðàíà æîäíà äàòà!');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ListBox1.Items.Clear;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  DateTimePicker4.Date := DateTimePicker3.Date + 7;
  DateTimePicker4.Enabled := CheckBox8.Checked;
  DateTimePicker4.Visible := CheckBox8.Checked;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ListBox1.Items.Count > 0 then

    ListBox1.Items.SaveToFile(ExtractFilePath(ParamStr(0)) + 'funday.txt');

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  s: string;
begin
  s := ExtractFilePath(ParamStr(0)) + 'funday.txt';

  if FileExists(s) then
    ListBox1.Items.LoadFromFile(s);

  DateTimePicker1.Date := Date;
  DateTimePicker2.Date := DateTimePicker1.Date + 7;
end;

procedure TForm1.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
begin
  if (Key = VK_DELETE) and (ListBox1.Items.Count > 0) then
  begin
    i := ListBox1.ItemIndex;
    Button3.Click;
    if i < ListBox1.Items.Count then
      ListBox1.ItemIndex := i
    else
      ListBox1.ItemIndex := ListBox1.Items.Count - 1;
  end;
end;

end.
