unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, FormUnit1;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin

  FormUnit1.Form1.IncommingRequestBodyMemo.Lines.Clear;
  FormUnit1.Form1.IncommingRequestBodyMemo.Lines.Add(Request.Content);

  Response.Content := '<html>' +
    '<head><title>request body catcher</title></head>' +
    '<body>body of incomming request plased into memo field</body>' + '</html>';
end;

end.
