object Form1: TForm1
  Left = 271
  Top = 114
  Caption = 'Form1'
  ClientHeight = 410
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 48
    Width = 62
    Height = 13
    Caption = 'Port listening'
  end
  object Label2: TLabel
    Left = 24
    Top = 232
    Width = 78
    Height = 13
    Caption = 'Address to send'
  end
  object Label3: TLabel
    Left = 160
    Top = 232
    Width = 59
    Height = 13
    Caption = 'Port to send'
  end
  object ButtonStart: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = ButtonStopClick
  end
  object WebServerPortControl: TEdit
    Left = 24
    Top = 67
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '8080'
  end
  object ButtonOpenBrowser: TButton
    Left = 24
    Top = 94
    Width = 107
    Height = 25
    Caption = 'Open Browser'
    TabOrder = 3
    OnClick = ButtonOpenBrowserClick
  end
  object IncommingRequestBodyMemo: TMemo
    Left = 24
    Top = 125
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object DestinationServerAddressControl: TEdit
    Left = 24
    Top = 251
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'localhost'
  end
  object DestinationServerPortControl: TEdit
    Left = 160
    Top = 251
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '8888'
  end
  object SendToDestinationServerButton: TButton
    Left = 24
    Top = 278
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 7
    OnClick = SendToDestinationServerButtonClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 200
    Top = 8
  end
end
