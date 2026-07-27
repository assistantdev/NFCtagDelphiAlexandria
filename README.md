# NFCTag — Delphi Alexandria (Android)

Projeto de leitura de tags NFC em dispositivos Android usando RAD Studio Alexandria com FMX.

**Testado em:** Samsung Galaxy S20 FE — Android 13  
**IDE:** RAD Studio Alexandria  
**Target SDK:** API 33

---

## Estrutura do projeto

| Arquivo | Descrição |
|---|---|
| `TesteNFC.pas` | Form principal — consome a classe `TNFC` |
| `TesteNFC.fmx` | Layout do form (`btnVerifique` + `MemoLog`) |
| `uNFC.pas` | Classe `TNFC` — toda a lógica NFC isolada aqui |
| `Androidapi.JNI.NFC.pas` | Binding JNI customizado com correções para Android 10+ |
| `AndroidManifest.template.xml` | Permissões NFC e intent-filters |
| `NFCTag.dpr` | Projeto Delphi |

---

## Como usar

### 1. Adicionar `uNFC.pas` ao projeto

Inclua `uNFC` no `uses` do form e declare os fields:

```pascal
uses uNFC;

type
  TfrmPrincipal = class(TForm)
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    NFC: TNFC;
    procedure OnTagDetectada(const AUID, ATechs, AConteudo: string);
  end;
```

### 2. Inicializar no FormActivate

```pascal
procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  if not Assigned(NFC) then
    NFC := TNFC.Create(procedure(AUID, ATechs, AConteudo: string)
    begin
      OnTagDetectada(AUID, ATechs, AConteudo);
    end);
  if NFC.Suportado and NFC.Habilitado then
    NFC.Ativar
  else
    MemoLog.Lines.Add('NFC nao disponivel ou desligado.');
end;
```

### 3. Implementar o callback

```pascal
procedure TfrmPrincipal.OnTagDetectada(const AUID, ATechs, AConteudo: string);
begin
  // AUID     = UID da tag em hexadecimal (ex: "9B252E6A")
  // ATechs   = tecnologias suportadas (ex: "android.nfc.tech.NfcA, android.nfc.tech.Ndef")
  // AConteudo = payload NDEF decodificado (texto) ou vazio se sem conteudo
end;
```

### 4. Desativar e liberar

```pascal
procedure TfrmPrincipal.FormDeactivate(Sender: TObject);
begin
  if Assigned(NFC) then NFC.Desativar;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NFC);
end;
```

---

## Classe TNFC

Declarada em `uNFC.pas`. Encapsula toda a lógica JNI de leitura NFC.

### Construtor

```pascal
constructor TNFC.Create(AOnTagDetectada: TNFCTagDetectadaProc);
```

`TNFCTagDetectadaProc = TProc<string, string, string>` — callback chamado na UI thread quando uma tag é detectada, recebendo `(UID, Techs, Conteudo)`.

### Métodos públicos

| Método | Descrição |
|---|---|
| `Ativar` | Ativa o `enableReaderMode` — app passa a receber tags |
| `Desativar` | Desativa o `disableReaderMode` |
| `Suportado: Boolean` | `True` se o dispositivo tem hardware NFC |
| `Habilitado: Boolean` | `True` se o NFC está ligado nas configurações |

### Funcionamento interno

- `TNFCReaderCallback` implementa `JNfcAdapter_ReaderCallback` via `TJavaLocal`
- `onTagDiscovered` é chamado pelo Android em thread Java
- Leitura de UID, techs e payload NDEF ocorre na thread Java (fora da UI)
- `TThread.Queue` entrega o resultado na UI thread antes de chamar o callback
- Conexão NDEF: `TJNdef.JavaClass.get(tag)` → `connect` → `getNdefMessage` → `close`

---

## Correções no Androidapi.JNI.NFC.pas

O arquivo padrão do RAD Studio tem métodos declarados incorretamente na interface de **classe** em vez de **instância**. Correções aplicadas:

### Interface de instância `JNfcAdapter`

```pascal
JNfcAdapter = interface(JObject)
  procedure disableForegroundDispatch(activity: JActivity); cdecl;
  procedure disableReaderMode(activity: JActivity); cdecl;           // adicionado
  procedure enableForegroundDispatch(...); cdecl;                     // movido
  procedure enableReaderMode(...); cdecl;
  function isEnabled: Boolean; cdecl;                                 // movido
end;
```

### Interface de instância `JNdefMessage`

```pascal
JNdefMessage = interface(JObject)
  function getRecords: TJavaObjectArray<JNdefRecord>; cdecl;         // adicionado
end;
```

### Interface de instância `JTag`

```pascal
JTag = interface(JObject)
  function getId: TJavaArray<Byte>; cdecl;                           // adicionado
  function getTechList: TJavaObjectArray<JString>; cdecl;            // adicionado
end;
```

### Interface `JNdef` (nova)

```pascal
JNdefClass = interface(JObjectClass)
  {class} function get(tag: JTag): JNdef; cdecl;
end;

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

## AndroidManifest

```xml
<uses-permission android:name="android.permission.NFC"/>
<uses-feature android:name="android.hardware.nfc" android:required="false"/>
```

Intent-filters configurados para `NDEF_DISCOVERED`, `TAG_DISCOVERED` e `TECH_DISCOVERED` com `priority="1000"`.

---

## Pontos importantes

| Problema | Solução |
|---|---|
| `isNdefPushEnabled` sempre falso no Android 10+ | Usar `isEnabled` na instância |
| `enableForegroundDispatch` com `FLAG_MUTABLE` causa exceção no Android 12+ | Usar `FLAG_IMMUTABLE` (`$04000000`) ou `enableReaderMode` |
| `TJavaObjectArray` não suporta `for..in` | Usar `for i := 0 to Length - 1` |
| `Assigned(GetAdapter)` não compila | Usar variável local intermediária |
| `getDefaultAdapter` retorna nil no `FormCreate` | Chamar sempre como variável local, nunca como field inicializado no `FormCreate` |
| Callback `onTagDiscovered` vem de thread Java | Usar `TThread.Queue` para acessar UI |
| Operações de I/O NFC (`connect`, `getNdefMessage`) | Executar fora do `TThread.Queue`, na thread Java |
