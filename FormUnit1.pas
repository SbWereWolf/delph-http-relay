unit FormUnit1;

interface

uses
        Winapi.Messages, System.SysUtils, System.Variants,
        System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
        Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, IdGlobal,
        Web.HTTPApp,
        REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
        TForm1 = class(TForm)
                ButtonStart: TButton;
                ButtonStop: TButton;
                WebServerPortControl: TEdit;
                Label1: TLabel;
                ApplicationEvents1: TApplicationEvents;
                ButtonOpenBrowser: TButton;
                IncommingRequestBodyMemo: TMemo;
                DestinationServerAddressControl: TEdit;
                DestinationServerPortControl: TEdit;
                Label2: TLabel;
                Label3: TLabel;
                SendToDestinationServerButton: TButton;
                procedure FormCreate(Sender: TObject);
                procedure ApplicationEvents1Idle(Sender: TObject;
                  var Done: Boolean);
                procedure ButtonStartClick(Sender: TObject);
                procedure ButtonStopClick(Sender: TObject);
                procedure ButtonOpenBrowserClick(Sender: TObject);
                function SendPostRequestToDestinationServer: string;
                procedure SendToDestinationServerButtonClick(Sender: TObject);
        private
                FServer: TIdHTTPWebBrokerBridge;
                procedure StartServer;
                { Private declarations }
        public
                { Public declarations }
        end;

var
        Form1: TForm1;

implementation

{$R *.dfm}

uses
{$IFDEF MSWINDOWS}
        Winapi.Windows, Winapi.ShellApi,
{$ENDIF}
        IdHTTP,
        System.Generics.Collections;

procedure TForm1.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
        ButtonStart.Enabled := not FServer.Active;
        ButtonStop.Enabled := FServer.Active;
        WebServerPortControl.Enabled := not FServer.Active;
end;

procedure TForm1.ButtonOpenBrowserClick(Sender: TObject);
{$IFDEF MSWINDOWS}
var
        LURL: string;
{$ENDIF}
begin
        StartServer;
{$IFDEF MSWINDOWS}
        LURL := Format('http://localhost:%s', [WebServerPortControl.Text]);
        ShellExecute(0, nil, PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
{$ENDIF}
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
        StartServer;
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
        FServer.Active := False;
        FServer.Bindings.Clear;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
        FServer := TIdHTTPWebBrokerBridge.Create(Self);
end;

procedure TForm1.SendToDestinationServerButtonClick(Sender: TObject);
var
        response: string;
begin
        response := SendPostRequestToDestinationServer;
end;

procedure TForm1.StartServer;
begin
        if not FServer.Active then
        begin
                FServer.Bindings.Clear;
                FServer.DefaultPort := StrToInt(WebServerPortControl.Text);
                FServer.Active := True;
        end;
end;

function TForm1.SendPostRequestToDestinationServer: string;
var
        lHTTP: TIdHTTP;
        lParamList: TStringList;
        address: string;
        rows: TArray<string>;
        I: integer;
        RequestBody: TStringStream;
        Body: string;
begin
        lParamList := TStringList.Create;

        rows := IncommingRequestBodyMemo.Lines.ToStringArray();
        Body := '';
        for I := Low(rows) to High(rows) do
        begin
                Body := Body + rows[I];
                if (I <> High(rows)) then
                begin
                        Body := Body + AnsiChar(#10);
                end;
        end;
        RequestBody := TStringStream.Create(Body, TEncoding.UTF8);

        address := Format('http://%s:%s', [DestinationServerAddressControl.Text,
          DestinationServerPortControl.Text]);

        lHTTP := TIdHTTP.Create;
        lHTTP.ConnectTimeout := 60;
        lHTTP.Request.ContentType := 'application/json';
        try
                Result := lHTTP.Post(address, RequestBody);
        finally
                lHTTP.Free;
                lParamList.Free;
        end;
end;

end.
