# NFC Tag Reader — Delphi Alexandria (Android)

Projeto de teste para leitura de tags NFC em dispositivos Android usando RAD Studio Alexandria (Delphi FMX).

Testado em: **Samsung Galaxy S20 FE — Android 13**

---

## O que faz

- Detecta se o hardware NFC está presente e ativo
- Ativa o modo de leitura em foreground ao abrir o app (`FormActivate`)
- Lê o UID da tag aproximada
- Lista as tecnologias suportadas pela tag (ex: NfcA, MifareClassic, Ndef)
- Decodifica o payload NDEF (registros do tipo RTD_TEXT)

---

## Arquivos do projeto

| Arquivo | Descrição |
|---|---|
| `TesteNFC.pas` | Unit principal com lógica de leitura NFC |
| `Androidapi.JNI.NFC.pas` | Binding JNI customizado com correções para Android 10+ |
| `TesteNFC.fmx` | Form FMX (Button1 + MemoLog) |
| `NFCTag.dpr` | Projeto Delphi |
| `AndroidManifest.template.xml` | Manifest com permissões NFC e intent-filters |

---

## Modificações necessárias no Androidapi.JNI.NFC.pas

O arquivo padrão do RAD Studio tem vários métodos do `NfcAdapter` declarados incorretamente na interface de **classe** em vez de **instância**. As seguintes correções foram aplicadas:

### Interface de instância `JNfcAdapter`

Métodos adicionados/movidos para a interface de instância:

```pascal
[JavaSignature('android/nfc/NfcAdapter')]
JNfcAdapter = interface(JObject)
  procedure disableForegroundDispatch(activity: JActivity); cdecl;
  procedure disableReaderMode(activity: JActivity); cdecl;         // adicionado
  procedure enableForegroundDispatch(...); cdecl;                   // movido
  procedure enableReaderMode(...); cdecl;
  function isEnabled: Boolean; cdecl;                               // movido
  ...
end;
```

### Interface de instância `JNdefMessage`

```pascal
[JavaSignature('android/nfc/NdefMessage')]
JNdefMessage = interface(JObject)
  function getRecords: TJavaObjectArray<JNdefRecord>; cdecl;       // adicionado
  ...
end;
```

### Interface de instância `JTag`

```pascal
[JavaSignature('android/nfc/Tag')]
JTag = interface(JObject)
  function getId: TJavaArray<Byte>; cdecl;                         // adicionado
  function getTechList: TJavaObjectArray<JString>; cdecl;          // adicionado
  ...
end;
```

### Interface `JNdef` (nova)

Adicionada para leitura de payload NDEF diretamente da tag:

```pascal
[JavaSignature('android/nfc/tech/Ndef')]
JNdef = interface(JObject)
  procedure close; cdecl;
  procedure connect; cdecl;
  function getNdefMessage: JNdefMessage; cdecl;
  function isConnected: Boolean; cdecl;
end;
TJNdef = class(TJavaGenericImport<JNdefClass, JNdef>) end;
```

---

## Pontos importantes

- `isNdefPushEnabled` foi removido do Android 10+ — usar `isEnabled` na instância
- `enableForegroundDispatch` com `PendingIntent` requer `FLAG_IMMUTABLE` (`$04000000`) no Android 12+
- `enableReaderMode` é a API moderna recomendada em vez de `enableForegroundDispatch`
- O callback `onTagDiscovered` vem de uma thread Java — usar `TThread.Queue` para acessar a UI
- Operações de I/O NFC (`connect`, `getNdefMessage`, `close`) devem ficar **fora** do `TThread.Queue`
- `TJavaObjectArray` não suporta `for..in` — usar `for i := 0 to Length - 1`
- `getDefaultAdapter` deve ser chamado como variável local, não como field inicializado no `FormCreate`

---

## AndroidManifest

```xml
<uses-permission android:name="android.permission.NFC"/>
<uses-feature android:name="android.hardware.nfc" android:required="false"/>
```

---

## Requisitos

- RAD Studio Alexandria
- Android SDK Target: API 33 (Android 13)
- Dispositivo com NFC habilitado
