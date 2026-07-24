unit Androidapi.JNI.NFC;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util;

type
  // ===== Forward declarations =====

  JAnimator = interface; // android.animation.Animator
  JAnimator_AnimatorListener = interface;
  // android.animation.Animator$AnimatorListener
  JAnimator_AnimatorPauseListener = interface;
  // android.animation.Animator$AnimatorPauseListener
  JKeyframe = interface; // android.animation.Keyframe
  JLayoutTransition = interface; // android.animation.LayoutTransition
  JLayoutTransition_TransitionListener = interface;
  // android.animation.LayoutTransition$TransitionListener
  JPropertyValuesHolder = interface; // android.animation.PropertyValuesHolder
  JStateListAnimator = interface; // android.animation.StateListAnimator
  JTimeInterpolator = interface; // android.animation.TimeInterpolator
  JTypeConverter = interface; // android.animation.TypeConverter
  JTypeEvaluator = interface; // android.animation.TypeEvaluator
  JValueAnimator = interface; // android.animation.ValueAnimator
  JValueAnimator_AnimatorUpdateListener = interface;
  // android.animation.ValueAnimator$AnimatorUpdateListener
  JNdefMessage = interface; // android.nfc.NdefMessage
  JNdefRecord = interface; // android.nfc.NdefRecord
  JNfcAdapter = interface; // android.nfc.NfcAdapter
  JNdef = interface; // android.nfc.tech.Ndef
  JNfcAdapter_CreateBeamUrisCallback = interface;
  // android.nfc.NfcAdapter$CreateBeamUrisCallback
  JNfcAdapter_CreateNdefMessageCallback = interface;
  // android.nfc.NfcAdapter$CreateNdefMessageCallback
  JNfcAdapter_OnNdefPushCompleteCallback = interface;
  // android.nfc.NfcAdapter$OnNdefPushCompleteCallback
  JNfcAdapter_ReaderCallback = interface;
  // android.nfc.NfcAdapter$ReaderCallback
  JNfcEvent = interface; // android.nfc.NfcEvent
  JTag = interface; // android.nfc.Tag
  JPathMotion = interface; // android.transition.PathMotion
  JScene = interface; // android.transition.Scene
  JTransition = interface; // android.transition.Transition
  JTransition_EpicenterCallback = interface;
  // android.transition.Transition$EpicenterCallback
  JTransition_TransitionListener = interface;
  // android.transition.Transition$TransitionListener
  JTransitionManager = interface; // android.transition.TransitionManager
  JTransitionPropagation = interface;
  // android.transition.TransitionPropagation
  JTransitionValues = interface; // android.transition.TransitionValues
  JInterpolator = interface; // android.view.animation.Interpolator
  JToolbar_LayoutParams = interface; // android.widget.Toolbar$LayoutParams

  // ===== Interface declarations =====

  JAnimatorClass = interface(JObjectClass)
    ['{3F76A5DF-389E-4BD3-9861-04C5B00CEADE}']
    { class } function init: JAnimator; cdecl; // Deprecated
    { class } procedure addListener(listener: JAnimator_AnimatorListener);
      cdecl; // Deprecated
    { class } procedure addPauseListener
      (listener: JAnimator_AnimatorPauseListener); cdecl; // Deprecated
    { class } function getDuration: Int64; cdecl;
    { class } function getInterpolator: JTimeInterpolator; cdecl;
    { class } function getListeners: JArrayList; cdecl;
    { class } function isStarted: Boolean; cdecl;
    { class } procedure pause; cdecl;
    { class } procedure removeAllListeners; cdecl;
    { class } procedure resume; cdecl;
    { class } function setDuration(duration: Int64): JAnimator; cdecl;
    { class } procedure setInterpolator(value: JTimeInterpolator); cdecl;
    { class } procedure setupStartValues; cdecl;
    { class } procedure start; cdecl;
  end;

  [JavaSignature('android/animation/Animator')]
  JAnimator = interface(JObject)
    ['{FA13E56D-1B6D-4A3D-8327-9E5BA785CF21}']
    procedure cancel; cdecl;
    function clone: JAnimator; cdecl;
    procedure &end; cdecl;
    function getStartDelay: Int64; cdecl;
    function isPaused: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    procedure removeListener(listener: JAnimator_AnimatorListener); cdecl;
    procedure removePauseListener(listener
      : JAnimator_AnimatorPauseListener); cdecl;
    procedure setStartDelay(startDelay: Int64); cdecl;
    procedure setTarget(target: JObject); cdecl;
    procedure setupEndValues; cdecl;
  end;

  TJAnimator = class(TJavaGenericImport<JAnimatorClass, JAnimator>)
  end;

  JAnimator_AnimatorListenerClass = interface(IJavaClass)
    ['{5ED6075A-B997-469C-B8D9-0AA8FB7E4798}']
    { class } procedure onAnimationCancel(animation: JAnimator); cdecl;
    // Deprecated
    { class } procedure onAnimationEnd(animation: JAnimator); cdecl;
    // Deprecated
    { class } procedure onAnimationRepeat(animation: JAnimator); cdecl;
    // Deprecated
  end;

  [JavaSignature('android/animation/Animator$AnimatorListener')]
  JAnimator_AnimatorListener = interface(IJavaInstance)
    ['{E2DE8DD6-628B-4D84-AA46-8A1E3F00FF13}']
    procedure onAnimationStart(animation: JAnimator); cdecl; // Deprecated
  end;

  TJAnimator_AnimatorListener = class
    (TJavaGenericImport<JAnimator_AnimatorListenerClass,
    JAnimator_AnimatorListener>)
  end;

  JAnimator_AnimatorPauseListenerClass = interface(IJavaClass)
    ['{CB0DC3F0-63BC-4284-ADD0-2ED367AE11E5}']
    { class } procedure onAnimationPause(animation: JAnimator); cdecl;
    // Deprecated
  end;

  [JavaSignature('android/animation/Animator$AnimatorPauseListener')]
  JAnimator_AnimatorPauseListener = interface(IJavaInstance)
    ['{43C9C106-65EA-4A7D-A958-FAB9E43FA4A6}']
    procedure onAnimationResume(animation: JAnimator); cdecl; // Deprecated
  end;

  TJAnimator_AnimatorPauseListener = class
    (TJavaGenericImport<JAnimator_AnimatorPauseListenerClass,
    JAnimator_AnimatorPauseListener>)
  end;

  JKeyframeClass = interface(JObjectClass)
    ['{D383116E-5CCF-48D8-9EA1-B26FBF24BA39}']
    { class } function init: JKeyframe; cdecl; // Deprecated
    { class } function clone: JKeyframe; cdecl;
    { class } function getFraction: Single; cdecl;
    { class } function hasValue: Boolean; cdecl;
    { class } function ofFloat(fraction: Single; value: Single): JKeyframe;
      cdecl; overload;
    { class } function ofFloat(fraction: Single): JKeyframe; cdecl; overload;
    { class } function ofInt(fraction: Single; value: Integer): JKeyframe;
      cdecl; overload; // Deprecated
    { class } function ofInt(fraction: Single): JKeyframe; cdecl; overload;
    // Deprecated
    { class } function ofObject(fraction: Single; value: JObject): JKeyframe;
      cdecl; overload; // Deprecated
    { class } function ofObject(fraction: Single): JKeyframe; cdecl; overload;
    // Deprecated
    { class } procedure setFraction(fraction: Single); cdecl; // Deprecated
    { class } procedure setInterpolator(interpolator: JTimeInterpolator); cdecl;
    // Deprecated
  end;

  [JavaSignature('android/animation/Keyframe')]
  JKeyframe = interface(JObject)
    ['{9D0687A4-669E-440F-8290-154739405019}']
    function getInterpolator: JTimeInterpolator; cdecl;
    function getType: Jlang_Class; cdecl;
    function getValue: JObject; cdecl;
    procedure setValue(value: JObject); cdecl; // Deprecated
  end;

  TJKeyframe = class(TJavaGenericImport<JKeyframeClass, JKeyframe>)
  end;

  JLayoutTransitionClass = interface(JObjectClass)
    ['{433C5359-0A96-4796-AD7B-8084EF7EF7C4}']
    { class } function _GetAPPEARING: Integer; cdecl;
    { class } function _GetCHANGE_APPEARING: Integer; cdecl;
    { class } function _GetCHANGE_DISAPPEARING: Integer; cdecl;
    { class } function _GetCHANGING: Integer; cdecl;
    { class } function _GetDISAPPEARING: Integer; cdecl;
    { class } function init: JLayoutTransition; cdecl; // Deprecated
    { class } procedure disableTransitionType(transitionType: Integer); cdecl;
    // Deprecated
    { class } procedure enableTransitionType(transitionType: Integer); cdecl;
    // Deprecated
    { class } function getAnimator(transitionType: Integer): JAnimator; cdecl;
    // Deprecated
    { class } function getStartDelay(transitionType: Integer): Int64; cdecl;
    { class } function getTransitionListeners: JList; cdecl;
    { class } procedure hideChild(parent: JViewGroup; child: JView); cdecl;
      overload; // Deprecated
    { class } function isTransitionTypeEnabled(transitionType: Integer)
      : Boolean; cdecl;
    { class } procedure removeChild(parent: JViewGroup; child: JView); cdecl;
    { class } procedure removeTransitionListener
      (listener: JLayoutTransition_TransitionListener); cdecl;
    { class } procedure setDuration(transitionType: Integer; duration: Int64);
      cdecl; overload;
    { class } procedure setInterpolator(transitionType: Integer;
      interpolator: JTimeInterpolator); cdecl;
    { class } procedure setStagger(transitionType: Integer;
      duration: Int64); cdecl;
    { class } procedure showChild(parent: JViewGroup; child: JView;
      oldVisibility: Integer); cdecl; overload;
    { class } property APPEARING: Integer read _GetAPPEARING;
    { class } property CHANGE_APPEARING: Integer read _GetCHANGE_APPEARING;
    { class } property CHANGE_DISAPPEARING: Integer
      read _GetCHANGE_DISAPPEARING;
    { class } property CHANGING: Integer read _GetCHANGING;
    { class } property DISAPPEARING: Integer read _GetDISAPPEARING;
  end;

  [JavaSignature('android/animation/LayoutTransition')]
  JLayoutTransition = interface(JObject)
    ['{42450BEE-EBF2-4954-B9B7-F8DAE7DF0EC1}']
    procedure addChild(parent: JViewGroup; child: JView); cdecl; // Deprecated
    procedure addTransitionListener(listener
      : JLayoutTransition_TransitionListener); cdecl; // Deprecated
    function getDuration(transitionType: Integer): Int64; cdecl;
    function getInterpolator(transitionType: Integer): JTimeInterpolator; cdecl;
    function getStagger(transitionType: Integer): Int64; cdecl;
    procedure hideChild(parent: JViewGroup; child: JView;
      newVisibility: Integer); cdecl; overload;
    function isChangingLayout: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    procedure setAnimateParentHierarchy(animateParentHierarchy: Boolean); cdecl;
    procedure setAnimator(transitionType: Integer; animator: JAnimator); cdecl;
    procedure setDuration(duration: Int64); cdecl; overload;
    procedure setStartDelay(transitionType: Integer; delay: Int64); cdecl;
    procedure showChild(parent: JViewGroup; child: JView); cdecl; overload;
    // Deprecated
  end;

  TJLayoutTransition = class(TJavaGenericImport<JLayoutTransitionClass,
    JLayoutTransition>)
  end;

  JLayoutTransition_TransitionListenerClass = interface(IJavaClass)
    ['{9FA6F1EC-8EDB-4A05-AF58-B55A525AE114}']
  end;

  [JavaSignature('android/animation/LayoutTransition$TransitionListener')]
  JLayoutTransition_TransitionListener = interface(IJavaInstance)
    ['{0FBE048F-FCDA-4692-B6F1-DE0F07FAE885}']
    procedure endTransition(transition: JLayoutTransition;
      container: JViewGroup; view: JView; transitionType: Integer); cdecl;
    procedure startTransition(transition: JLayoutTransition;
      container: JViewGroup; view: JView; transitionType: Integer); cdecl;
  end;

  TJLayoutTransition_TransitionListener = class
    (TJavaGenericImport<JLayoutTransition_TransitionListenerClass,
    JLayoutTransition_TransitionListener>)
  end;

  JPropertyValuesHolderClass = interface(JObjectClass)
    ['{36C77AFF-9C3F-42B6-88F3-320FE8CF9B25}']
    { class } function ofMultiFloat(propertyName: JString;
      values: TJavaBiArray<Single>): JPropertyValuesHolder; cdecl; overload;
    { class } function ofMultiFloat(propertyName: JString; path: JPath)
      : JPropertyValuesHolder; cdecl; overload;
    { class } function ofMultiInt(propertyName: JString;
      values: TJavaBiArray<Integer>): JPropertyValuesHolder; cdecl; overload;
    { class } function ofMultiInt(propertyName: JString; path: JPath)
      : JPropertyValuesHolder; cdecl; overload;
    { class } function ofObject(propertyName: JString;
      converter: JTypeConverter; path: JPath): JPropertyValuesHolder;
      cdecl; overload;
    { class } function ofObject(property_: JProperty; converter: JTypeConverter;
      path: JPath): JPropertyValuesHolder; cdecl; overload;
    { class } procedure setConverter(converter: JTypeConverter); cdecl;
    { class } procedure setProperty(property_: JProperty); cdecl; // Deprecated
  end;

  [JavaSignature('android/animation/PropertyValuesHolder')]
  JPropertyValuesHolder = interface(JObject)
    ['{12B4ABFD-CBCA-4636-AF2D-C386EF895DC3}']
    function clone: JPropertyValuesHolder; cdecl;
    function getPropertyName: JString; cdecl;
    procedure setEvaluator(evaluator: JTypeEvaluator); cdecl; // Deprecated
    procedure setPropertyName(propertyName: JString); cdecl; // Deprecated
    function toString: JString; cdecl; // Deprecated
  end;

  TJPropertyValuesHolder = class(TJavaGenericImport<JPropertyValuesHolderClass,
    JPropertyValuesHolder>)
  end;

  JStateListAnimatorClass = interface(JObjectClass)
    ['{109E4067-E218-47B1-93EB-65B8916A98D8}']
    { class } function init: JStateListAnimator; cdecl; // Deprecated
    { class } procedure addState(specs: TJavaArray<Integer>;
      animator: JAnimator); cdecl; // Deprecated
  end;

  [JavaSignature('android/animation/StateListAnimator')]
  JStateListAnimator = interface(JObject)
    ['{CA2A9587-26AA-4DC2-8DFF-A1305A37608F}']
    function clone: JStateListAnimator; cdecl; // Deprecated
    procedure jumpToCurrentState; cdecl; // Deprecated
  end;

  TJStateListAnimator = class(TJavaGenericImport<JStateListAnimatorClass,
    JStateListAnimator>)
  end;

  JTimeInterpolatorClass = interface(IJavaClass)
    ['{1E682A1C-9102-461D-A3CA-5596683F1D66}']
    { class } function getInterpolation(input: Single): Single; cdecl;
    // Deprecated
  end;

  [JavaSignature('android/animation/TimeInterpolator')]
  JTimeInterpolator = interface(IJavaInstance)
    ['{639F8A83-7D9B-49AF-A19E-96B27E46D2AB}']
  end;

  TJTimeInterpolator = class(TJavaGenericImport<JTimeInterpolatorClass,
    JTimeInterpolator>)
  end;

  JTypeConverterClass = interface(JObjectClass)
    ['{BE2DD177-6D79-4B0C-B4F5-4E4CD9D7436D}']
    { class } function init(fromClass: Jlang_Class; toClass: Jlang_Class)
      : JTypeConverter; cdecl; // Deprecated
  end;

  [JavaSignature('android/animation/TypeConverter')]
  JTypeConverter = interface(JObject)
    ['{BFEA4116-0766-4AD9-AA8F-4C15A583EB2E}']
    function convert(value: JObject): JObject; cdecl;
  end;

  TJTypeConverter = class(TJavaGenericImport<JTypeConverterClass,
    JTypeConverter>)
  end;

  JTypeEvaluatorClass = interface(IJavaClass)
    ['{15B67CAF-6F50-4AA3-A88F-C5AF78D62FD4}']
    { class } function evaluate(fraction: Single; startValue: JObject;
      endValue: JObject): JObject; cdecl;
  end;

  [JavaSignature('android/animation/TypeEvaluator')]
  JTypeEvaluator = interface(IJavaInstance)
    ['{F436383D-6F44-40D8-ACDD-9057777691FC}']
  end;

  TJTypeEvaluator = class(TJavaGenericImport<JTypeEvaluatorClass,
    JTypeEvaluator>)
  end;

  JValueAnimatorClass = interface(JAnimatorClass)
    ['{FF3B71ED-5A33-45B0-8500-7672B0B98E2C}']
    { class } function _GetINFINITE: Integer; cdecl;
    { class } function _GetRESTART: Integer; cdecl;
    { class } function _GetREVERSE: Integer; cdecl;
    { class } function init: JValueAnimator; cdecl; // Deprecated
    { class } procedure addUpdateListener
      (listener: JValueAnimator_AnimatorUpdateListener); cdecl;
    { class } procedure cancel; cdecl;
    { class } function getAnimatedValue: JObject; cdecl; overload;
    { class } function getAnimatedValue(propertyName: JString): JObject;
      cdecl; overload;
    { class } function getCurrentPlayTime: Int64; cdecl;
    { class } function getFrameDelay: Int64; cdecl;
    { class } function getRepeatCount: Integer; cdecl;
    { class } function getRepeatMode: Integer; cdecl;
    { class } function getStartDelay: Int64; cdecl;
    { class } procedure pause; cdecl; // Deprecated
    { class } procedure removeAllUpdateListeners; cdecl; // Deprecated
    { class } procedure removeUpdateListener
      (listener: JValueAnimator_AnimatorUpdateListener); cdecl; // Deprecated
    { class } procedure setCurrentPlayTime(playTime: Int64); cdecl;
    // Deprecated
    { class } function setDuration(duration: Int64): JValueAnimator; cdecl;
    // Deprecated
    { class } procedure setEvaluator(value: JTypeEvaluator); cdecl;
    // Deprecated
    { class } procedure setFrameDelay(frameDelay: Int64); cdecl; // Deprecated
    { class } procedure setInterpolator(value: JTimeInterpolator); cdecl;
    // Deprecated
    { class } procedure setRepeatCount(value: Integer); cdecl; // Deprecated
    { class } procedure start; cdecl;
    { class } function toString: JString; cdecl;
    { class } property INFINITE: Integer read _GetINFINITE;
    { class } property RESTART: Integer read _GetRESTART;
    { class } property REVERSE: Integer read _GetREVERSE;
  end;

  [JavaSignature('android/animation/ValueAnimator')]
  JValueAnimator = interface(JAnimator)
    ['{70F92B14-EFD4-4DC7-91DE-6617417AE194}']
    function clone: JValueAnimator; cdecl;
    procedure &end; cdecl;
    function getAnimatedFraction: Single; cdecl;
    function getDuration: Int64; cdecl;
    function getInterpolator: JTimeInterpolator; cdecl;
    function getValues: TJavaObjectArray<JPropertyValuesHolder>; cdecl;
    // Deprecated
    function isRunning: Boolean; cdecl; // Deprecated
    function isStarted: Boolean; cdecl; // Deprecated
    procedure resume; cdecl; // Deprecated
    procedure REVERSE; cdecl; // Deprecated
    procedure setCurrentFraction(fraction: Single); cdecl; // Deprecated
    procedure setRepeatMode(value: Integer); cdecl;
    procedure setStartDelay(startDelay: Int64); cdecl;
  end;

  TJValueAnimator = class(TJavaGenericImport<JValueAnimatorClass,
    JValueAnimator>)
  end;

  JValueAnimator_AnimatorUpdateListenerClass = interface(IJavaClass)
    ['{9CA50CBF-4462-4445-82CD-13CE985E2DE4}']
    { class } procedure onAnimationUpdate(animation: JValueAnimator); cdecl;
    // Deprecated
  end;

  [JavaSignature('android/animation/ValueAnimator$AnimatorUpdateListener')]
  JValueAnimator_AnimatorUpdateListener = interface(IJavaInstance)
    ['{0F883491-52EF-4A40-B7D2-FC23E11E46FE}']
  end;

  TJValueAnimator_AnimatorUpdateListener = class
    (TJavaGenericImport<JValueAnimator_AnimatorUpdateListenerClass,
    JValueAnimator_AnimatorUpdateListener>)
  end;

  JNdefMessageClass = interface(JObjectClass)
    ['{F3AB1A3F-5D57-493B-8DE2-196E232BAAA7}']
    { class } function _GetCREATOR: JParcelable_Creator; cdecl;
    { class } function init(data: TJavaArray<Byte>): JNdefMessage; cdecl;
      overload; // Deprecated
    { class } function init(records: TJavaObjectArray<JNdefRecord>)
      : JNdefMessage; cdecl; overload; // Deprecated
    { class } function getRecords: TJavaObjectArray<JNdefRecord>; cdecl;
    // Deprecated
    { class } function hashCode: Integer; cdecl; // Deprecated
    { class } function toByteArray: TJavaArray<Byte>; cdecl; // Deprecated
    { class } property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/nfc/NdefMessage')]
  JNdefMessage = interface(JObject)
    ['{E0CECFAE-B76D-4560-824C-588B651BBAF8}']
    function describeContents: Integer; cdecl; // Deprecated
    function equals(obj: JObject): Boolean; cdecl; // Deprecated
    function getByteArrayLength: Integer; cdecl; // Deprecated
    function getRecords: TJavaObjectArray<JNdefRecord>; cdecl;
    function toString: JString; cdecl; // Deprecated
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl; // Deprecated
  end;

  TJNdefMessage = class(TJavaGenericImport<JNdefMessageClass, JNdefMessage>)
  end;

  JNdefRecordClass = interface(JObjectClass)
    ['{F3F097F8-593C-4069-921C-062E0F144A55}']
    { class } function _GetCREATOR: JParcelable_Creator; cdecl;
    { class } function _GetRTD_ALTERNATIVE_CARRIER: TJavaArray<Byte>; cdecl;
    { class } function _GetRTD_HANDOVER_CARRIER: TJavaArray<Byte>; cdecl;
    { class } function _GetRTD_HANDOVER_REQUEST: TJavaArray<Byte>; cdecl;
    { class } function _GetRTD_HANDOVER_SELECT: TJavaArray<Byte>; cdecl;
    { class } function _GetRTD_SMART_POSTER: TJavaArray<Byte>; cdecl;
    { class } function _GetRTD_TEXT: TJavaArray<Byte>; cdecl;
    { class } function _GetRTD_URI: TJavaArray<Byte>; cdecl;
    { class } function _GetTNF_ABSOLUTE_URI: SmallInt; cdecl;
    { class } function _GetTNF_EMPTY: SmallInt; cdecl;
    { class } function _GetTNF_EXTERNAL_TYPE: SmallInt; cdecl;
    { class } function _GetTNF_MIME_MEDIA: SmallInt; cdecl;
    { class } function _GetTNF_UNCHANGED: SmallInt; cdecl;
    { class } function _GetTNF_UNKNOWN: SmallInt; cdecl;
    { class } function _GetTNF_WELL_KNOWN: SmallInt; cdecl;
    { class } function init(tnf: SmallInt; type_: TJavaArray<Byte>;
      id: TJavaArray<Byte>; payload: TJavaArray<Byte>): JNdefRecord; cdecl;
      overload; // Deprecated
    { class } function init(data: TJavaArray<Byte>): JNdefRecord; cdecl;
      overload; // Deprecated
    { class } function createApplicationRecord(packageName: JString)
      : JNdefRecord; cdecl; // Deprecated
    { class } function createExternal(domain: JString; type_: JString;
      data: TJavaArray<Byte>): JNdefRecord; cdecl; // Deprecated
    { class } function createMime(mimeType: JString; mimeData: TJavaArray<Byte>)
      : JNdefRecord; cdecl; // Deprecated
    { class } function createTextRecord(languageCode: JString; text: JString)
      : JNdefRecord; cdecl;
    { class } function createUri(uri: Jnet_Uri): JNdefRecord; cdecl; overload;
    { class } function createUri(uriString: JString): JNdefRecord;
      cdecl; overload;
    { class } function describeContents: Integer; cdecl;
    { class } function equals(obj: JObject): Boolean; cdecl;
    { class } function getId: TJavaArray<Byte>; cdecl;
    { class } function hashCode: Integer; cdecl;
    { class } function toByteArray: TJavaArray<Byte>; cdecl; // Deprecated
    { class } function toMimeType: JString; cdecl;
    { class } property CREATOR: JParcelable_Creator read _GetCREATOR;
    { class } property RTD_ALTERNATIVE_CARRIER: TJavaArray<Byte>
      read _GetRTD_ALTERNATIVE_CARRIER;
    { class } property RTD_HANDOVER_CARRIER: TJavaArray<Byte>
      read _GetRTD_HANDOVER_CARRIER;
    { class } property RTD_HANDOVER_REQUEST: TJavaArray<Byte>
      read _GetRTD_HANDOVER_REQUEST;
    { class } property RTD_HANDOVER_SELECT: TJavaArray<Byte>
      read _GetRTD_HANDOVER_SELECT;
    { class } property RTD_SMART_POSTER: TJavaArray<Byte>
      read _GetRTD_SMART_POSTER;
    { class } property RTD_TEXT: TJavaArray<Byte> read _GetRTD_TEXT;
    { class } property RTD_URI: TJavaArray<Byte> read _GetRTD_URI;
    { class } property TNF_ABSOLUTE_URI: SmallInt read _GetTNF_ABSOLUTE_URI;
    { class } property TNF_EMPTY: SmallInt read _GetTNF_EMPTY;
    { class } property TNF_EXTERNAL_TYPE: SmallInt read _GetTNF_EXTERNAL_TYPE;
    { class } property TNF_MIME_MEDIA: SmallInt read _GetTNF_MIME_MEDIA;
    { class } property TNF_UNCHANGED: SmallInt read _GetTNF_UNCHANGED;
    { class } property TNF_UNKNOWN: SmallInt read _GetTNF_UNKNOWN;
    { class } property TNF_WELL_KNOWN: SmallInt read _GetTNF_WELL_KNOWN;
  end;

  [JavaSignature('android/nfc/NdefRecord')]
  JNdefRecord = interface(JObject)
    ['{7FC0B3FF-8E8E-44C5-86F0-2F9A592C2E6E}']
    function getPayload: TJavaArray<Byte>; cdecl;
    function getTnf: SmallInt; cdecl;
    function getType: TJavaArray<Byte>; cdecl;
    function toString: JString; cdecl;
    function toUri: Jnet_Uri; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;

  TJNdefRecord = class(TJavaGenericImport<JNdefRecordClass, JNdefRecord>)
  end;

  JNfcAdapterClass = interface(JObjectClass)
    ['{C4ECC055-BBA4-4B74-AF3A-144B2191B5FB}']
    { class } function _GetACTION_ADAPTER_STATE_CHANGED: JString; cdecl;
    { class } function _GetACTION_NDEF_DISCOVERED: JString; cdecl;
    { class } function _GetACTION_TAG_DISCOVERED: JString; cdecl;
    { class } function _GetACTION_TECH_DISCOVERED: JString; cdecl;
    { class } function _GetEXTRA_ADAPTER_STATE: JString; cdecl;
    { class } function _GetEXTRA_ID: JString; cdecl;
    { class } function _GetEXTRA_NDEF_MESSAGES: JString; cdecl;
    { class } function _GetEXTRA_READER_PRESENCE_CHECK_DELAY: JString; cdecl;
    { class } function _GetEXTRA_TAG: JString; cdecl;
    { class } function _GetFLAG_READER_NFC_A: Integer; cdecl;
    { class } function _GetFLAG_READER_NFC_B: Integer; cdecl;
    { class } function _GetFLAG_READER_NFC_BARCODE: Integer; cdecl;
    { class } function _GetFLAG_READER_NFC_F: Integer; cdecl;
    { class } function _GetFLAG_READER_NFC_V: Integer; cdecl;
    { class } function _GetFLAG_READER_NO_PLATFORM_SOUNDS: Integer; cdecl;
    { class } function _GetFLAG_READER_SKIP_NDEF_CHECK: Integer; cdecl;
    { class } function _GetSTATE_OFF: Integer; cdecl;
    { class } function _GetSTATE_ON: Integer; cdecl;
    { class } function _GetSTATE_TURNING_OFF: Integer; cdecl;
    { class } function _GetSTATE_TURNING_ON: Integer; cdecl;
    { class } procedure disableForegroundNdefPush(activity: JActivity); cdecl;
    // Deprecated
    { class } procedure disableReaderMode(activity: JActivity); cdecl;
    { class } procedure enableForegroundDispatch(activity: JActivity;
      intent: JPendingIntent; filters: TJavaObjectArray<JIntentFilter>;
      techLists: TJavaObjectBiArray<JString>); cdecl;
    { class } function getDefaultAdapter(context: JContext): JNfcAdapter; cdecl;
    { class } function invokeBeam(activity: JActivity): Boolean; cdecl;
    { class } function isEnabled: Boolean; cdecl;
    { class } property ACTION_ADAPTER_STATE_CHANGED: JString
      read _GetACTION_ADAPTER_STATE_CHANGED;
    { class } property ACTION_NDEF_DISCOVERED: JString
      read _GetACTION_NDEF_DISCOVERED;
    { class } property ACTION_TAG_DISCOVERED: JString
      read _GetACTION_TAG_DISCOVERED;
    { class } property ACTION_TECH_DISCOVERED: JString
      read _GetACTION_TECH_DISCOVERED;
    { class } property EXTRA_ADAPTER_STATE: JString
      read _GetEXTRA_ADAPTER_STATE;
    { class } property EXTRA_ID: JString read _GetEXTRA_ID;
    { class } property EXTRA_NDEF_MESSAGES: JString
      read _GetEXTRA_NDEF_MESSAGES;
    { class } property EXTRA_READER_PRESENCE_CHECK_DELAY: JString
      read _GetEXTRA_READER_PRESENCE_CHECK_DELAY;
    { class } property EXTRA_TAG: JString read _GetEXTRA_TAG;
    { class } property FLAG_READER_NFC_A: Integer read _GetFLAG_READER_NFC_A;
    { class } property FLAG_READER_NFC_B: Integer read _GetFLAG_READER_NFC_B;
    { class } property FLAG_READER_NFC_BARCODE: Integer
      read _GetFLAG_READER_NFC_BARCODE;
    { class } property FLAG_READER_NFC_F: Integer read _GetFLAG_READER_NFC_F;
    { class } property FLAG_READER_NFC_V: Integer read _GetFLAG_READER_NFC_V;
    { class } property FLAG_READER_NO_PLATFORM_SOUNDS: Integer
      read _GetFLAG_READER_NO_PLATFORM_SOUNDS;
    { class } property FLAG_READER_SKIP_NDEF_CHECK: Integer
      read _GetFLAG_READER_SKIP_NDEF_CHECK;
    { class } property STATE_OFF: Integer read _GetSTATE_OFF;
    { class } property STATE_ON: Integer read _GetSTATE_ON;
    { class } property STATE_TURNING_OFF: Integer read _GetSTATE_TURNING_OFF;
    { class } property STATE_TURNING_ON: Integer read _GetSTATE_TURNING_ON;
  end;

  [JavaSignature('android/nfc/NfcAdapter')]
  JNfcAdapter = interface(JObject)
    ['{32AFA1CB-76FC-49AE-B378-1D044E70E72D}']
    procedure disableForegroundDispatch(activity: JActivity); cdecl;
    procedure enableForegroundDispatch(activity: JActivity;
      intent: JPendingIntent; filters: TJavaObjectArray<JIntentFilter>;
      techLists: TJavaObjectBiArray<JString>); cdecl; // <-- adicionar
    procedure enableForegroundNdefPush(activity: JActivity;
      message: JNdefMessage); cdecl;
    procedure enableReaderMode(activity: JActivity;
      callback: JNfcAdapter_ReaderCallback; flags: Integer;
      extras: JBundle); cdecl;
    function isEnabled: Boolean; cdecl;
    function isNdefPushEnabled: Boolean; cdecl;
    procedure setBeamPushUris(uris: TJavaObjectArray<Jnet_Uri>;
      activity: JActivity); cdecl;
    procedure setBeamPushUrisCallback
      (callback: JNfcAdapter_CreateBeamUrisCallback;
      activity: JActivity); cdecl;
    procedure disableReaderMode(activity: JActivity); cdecl;
  end;

  TJNfcAdapter = class(TJavaGenericImport<JNfcAdapterClass, JNfcAdapter>)
  end;

  JNfcAdapter_CreateBeamUrisCallbackClass = interface(IJavaClass)
    ['{A32FAEF6-7B66-43A8-BDD6-1167CBFF0DD5}']
  end;

  [JavaSignature('android/nfc/NfcAdapter$CreateBeamUrisCallback')]
  JNfcAdapter_CreateBeamUrisCallback = interface(IJavaInstance)
    ['{CC2612D1-E79D-49E4-9C2B-3C1B8413FC59}']
    function createBeamUris(event: JNfcEvent): TJavaObjectArray<Jnet_Uri>;
      cdecl; // Deprecated
  end;

  TJNfcAdapter_CreateBeamUrisCallback = class
    (TJavaGenericImport<JNfcAdapter_CreateBeamUrisCallbackClass,
    JNfcAdapter_CreateBeamUrisCallback>)
  end;

  JNfcAdapter_CreateNdefMessageCallbackClass = interface(IJavaClass)
    ['{54227A33-453D-4F04-82EA-F8F7F8786D7E}']
  end;

  [JavaSignature('android/nfc/NfcAdapter$CreateNdefMessageCallback')]
  JNfcAdapter_CreateNdefMessageCallback = interface(IJavaInstance)
    ['{0F628EA0-8459-44F0-9024-F5CD1E94FC23}']
    function createNdefMessage(event: JNfcEvent): JNdefMessage; cdecl;
    // Deprecated
  end;

  TJNfcAdapter_CreateNdefMessageCallback = class
    (TJavaGenericImport<JNfcAdapter_CreateNdefMessageCallbackClass,
    JNfcAdapter_CreateNdefMessageCallback>)
  end;

  JNfcAdapter_OnNdefPushCompleteCallbackClass = interface(IJavaClass)
    ['{53F83D88-6614-4E9F-878E-7E2A65F8C3D7}']
    { class } procedure onNdefPushComplete(event: JNfcEvent); cdecl;
    // Deprecated
  end;

  [JavaSignature('android/nfc/NfcAdapter$OnNdefPushCompleteCallback')]
  JNfcAdapter_OnNdefPushCompleteCallback = interface(IJavaInstance)
    ['{D13D28AE-B8CA-4E0C-8B69-5C9183BB9CDF}']
  end;

  TJNfcAdapter_OnNdefPushCompleteCallback = class
    (TJavaGenericImport<JNfcAdapter_OnNdefPushCompleteCallbackClass,
    JNfcAdapter_OnNdefPushCompleteCallback>)
  end;

  JNfcAdapter_ReaderCallbackClass = interface(IJavaClass)
    ['{0107D97F-3957-428B-B811-9F6734386871}']
  end;

  [JavaSignature('android/nfc/NfcAdapter$ReaderCallback')]
  JNfcAdapter_ReaderCallback = interface(IJavaInstance)
    ['{146B165E-6142-427A-B60F-317E6CCBCB78}']
    procedure onTagDiscovered(tag: JTag); cdecl; // Deprecated
  end;

  TJNfcAdapter_ReaderCallback = class
    (TJavaGenericImport<JNfcAdapter_ReaderCallbackClass,
    JNfcAdapter_ReaderCallback>)
  end;

  JNfcEventClass = interface(JObjectClass)
    ['{97C95B78-4CEC-4ED4-B62C-4978C4703A41}']
    { class } function _GetnfcAdapter: JNfcAdapter; cdecl;
    { class } function _GetpeerLlcpMajorVersion: Integer; cdecl;
    { class } property nfcAdapter: JNfcAdapter read _GetnfcAdapter;
    { class } property peerLlcpMajorVersion: Integer
      read _GetpeerLlcpMajorVersion;
  end;

  [JavaSignature('android/nfc/NfcEvent')]
  JNfcEvent = interface(JObject)
    ['{CED42B6F-C4CA-42DA-AA18-8258C077AC15}']
    function _GetpeerLlcpMinorVersion: Integer; cdecl;
    property peerLlcpMinorVersion: Integer read _GetpeerLlcpMinorVersion;
  end;

  TJNfcEvent = class(TJavaGenericImport<JNfcEventClass, JNfcEvent>)
  end;

  JTagClass = interface(JObjectClass)
    ['{B4ABEB98-817E-4028-B212-62E971069F34}']
    { class } function _GetCREATOR: JParcelable_Creator; cdecl;
    { class } function describeContents: Integer; cdecl; // Deprecated
    { class } function getId: TJavaArray<Byte>; cdecl; // Deprecated
    { class } function getTechList: TJavaObjectArray<JString>; cdecl;
    // Deprecated
    { class } property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/nfc/Tag')]
  JTag = interface(JObject)
    ['{110F4A27-1DD0-4D81-AE18-8D1FAB9DBA5C}']
    function getId: TJavaArray<Byte>; cdecl;
    function getTechList: TJavaObjectArray<JString>; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;

  TJTag = class(TJavaGenericImport<JTagClass, JTag>)
  end;

  JNdefClass = interface(JObjectClass)
    ['{A1B2C3D4-0001-0001-0001-000000000001}']
    {class} function get(tag: JTag): JNdef; cdecl;
  end;

  [JavaSignature('android/nfc/tech/Ndef')]
  JNdef = interface(JObject)
    ['{A1B2C3D4-0001-0001-0001-000000000002}']
    procedure close; cdecl;
    procedure connect; cdecl;
    function getNdefMessage: JNdefMessage; cdecl;
    function isConnected: Boolean; cdecl;
  end;
  TJNdef = class(TJavaGenericImport<JNdefClass, JNdef>) end;

  JPathMotionClass = interface(JObjectClass)
    ['{E1CD1A94-115C-492C-A490-37F0E72956EB}']
    { class } function init: JPathMotion; cdecl; overload; // Deprecated
    { class } function init(context: JContext; attrs: JAttributeSet)
      : JPathMotion; cdecl; overload; // Deprecated
    { class } function getPath(startX: Single; startY: Single; endX: Single;
      endY: Single): JPath; cdecl; // Deprecated
  end;

  [JavaSignature('android/transition/PathMotion')]
  JPathMotion = interface(JObject)
    ['{BDC08353-C9FB-42D7-97CC-C35837D2F536}']
  end;

  TJPathMotion = class(TJavaGenericImport<JPathMotionClass, JPathMotion>)
  end;

  JSceneClass = interface(JObjectClass)
    ['{8B9120CA-AEEA-4DE3-BDC9-15CFD23A7B07}']
    { class } function init(sceneRoot: JViewGroup): JScene; cdecl; overload;
    // Deprecated
    { class } function init(sceneRoot: JViewGroup; layout: JView): JScene;
      cdecl; overload; // Deprecated
    { class } function init(sceneRoot: JViewGroup; layout: JViewGroup): JScene;
      cdecl; overload; // Deprecated
    { class } procedure enter; cdecl;
    { class } procedure exit; cdecl;
    { class } function getSceneForLayout(sceneRoot: JViewGroup;
      layoutId: Integer; context: JContext): JScene; cdecl;
    { class } procedure setExitAction(action: JRunnable); cdecl;
  end;

  [JavaSignature('android/transition/Scene')]
  JScene = interface(JObject)
    ['{85A60B99-5837-4F1F-A344-C627DD586B82}']
    function getSceneRoot: JViewGroup; cdecl;
    procedure setEnterAction(action: JRunnable); cdecl;
  end;

  TJScene = class(TJavaGenericImport<JSceneClass, JScene>)
  end;

  JTransitionClass = interface(JObjectClass)
    ['{60EC06BC-8F7A-4416-A04B-5B57987EB18E}']
    { class } function _GetMATCH_ID: Integer; cdecl;
    { class } function _GetMATCH_INSTANCE: Integer; cdecl;
    { class } function _GetMATCH_ITEM_ID: Integer; cdecl;
    { class } function _GetMATCH_NAME: Integer; cdecl;
    { class } function init: JTransition; cdecl; overload; // Deprecated
    { class } function init(context: JContext; attrs: JAttributeSet)
      : JTransition; cdecl; overload; // Deprecated
    { class } function addTarget(targetType: Jlang_Class): JTransition;
      cdecl; overload;
    { class } function addTarget(target: JView): JTransition; cdecl; overload;
    { class } function canRemoveViews: Boolean; cdecl;
    { class } function createAnimator(sceneRoot: JViewGroup;
      startValues: JTransitionValues; endValues: JTransitionValues): JAnimator;
      cdecl; // Deprecated
    { class } function excludeChildren(targetId: Integer; exclude: Boolean)
      : JTransition; cdecl; overload; // Deprecated
    { class } function excludeTarget(targetName: JString; exclude: Boolean)
      : JTransition; cdecl; overload; // Deprecated
    { class } function excludeTarget(target: JView; exclude: Boolean)
      : JTransition; cdecl; overload; // Deprecated
    { class } function excludeTarget(type_: Jlang_Class; exclude: Boolean)
      : JTransition; cdecl; overload; // Deprecated
    { class } function getInterpolator: JTimeInterpolator; cdecl; // Deprecated
    { class } function getName: JString; cdecl; // Deprecated
    { class } function getPathMotion: JPathMotion; cdecl; // Deprecated
    { class } function getTargetNames: JList; cdecl; // Deprecated
    { class } function getTargetTypes: JList; cdecl; // Deprecated
    { class } function getTargets: JList; cdecl; // Deprecated
    { class } function removeListener(listener: JTransition_TransitionListener)
      : JTransition; cdecl;
    { class } function removeTarget(targetId: Integer): JTransition;
      cdecl; overload;
    { class } function removeTarget(targetName: JString): JTransition;
      cdecl; overload;
    { class } procedure setEpicenterCallback(epicenterCallback
      : JTransition_EpicenterCallback); cdecl;
    { class } function setInterpolator(interpolator: JTimeInterpolator)
      : JTransition; cdecl;
    { class } function setStartDelay(startDelay: Int64): JTransition; cdecl;
    { class } function toString: JString; cdecl;
    { class } property MATCH_ID: Integer read _GetMATCH_ID;
    { class } property MATCH_INSTANCE: Integer read _GetMATCH_INSTANCE;
    { class } property MATCH_ITEM_ID: Integer read _GetMATCH_ITEM_ID;
    { class } property MATCH_NAME: Integer read _GetMATCH_NAME;
  end;

  [JavaSignature('android/transition/Transition')]
  JTransition = interface(JObject)
    ['{C2F8200F-1C83-40AE-8C5B-C0C8BFF17F88}']
    function addListener(listener: JTransition_TransitionListener)
      : JTransition; cdecl;
    function addTarget(targetId: Integer): JTransition; cdecl; overload;
    function addTarget(targetName: JString): JTransition; cdecl; overload;
    procedure captureEndValues(transitionValues: JTransitionValues); cdecl;
    // Deprecated
    procedure captureStartValues(transitionValues: JTransitionValues); cdecl;
    // Deprecated
    function clone: JTransition; cdecl; // Deprecated
    function excludeChildren(target: JView; exclude: Boolean): JTransition;
      cdecl; overload; // Deprecated
    function excludeChildren(type_: Jlang_Class; exclude: Boolean): JTransition;
      cdecl; overload; // Deprecated
    function excludeTarget(targetId: Integer; exclude: Boolean): JTransition;
      cdecl; overload; // Deprecated
    function getDuration: Int64; cdecl; // Deprecated
    function getEpicenter: JRect; cdecl; // Deprecated
    function getEpicenterCallback: JTransition_EpicenterCallback; cdecl;
    // Deprecated
    function getPropagation: JTransitionPropagation; cdecl; // Deprecated
    function getStartDelay: Int64; cdecl; // Deprecated
    function getTargetIds: JList; cdecl; // Deprecated
    function getTransitionProperties: TJavaObjectArray<JString>; cdecl;
    function getTransitionValues(view: JView; start: Boolean)
      : JTransitionValues; cdecl;
    function isTransitionRequired(startValues: JTransitionValues;
      endValues: JTransitionValues): Boolean; cdecl;
    function removeTarget(target: JView): JTransition; cdecl; overload;
    function removeTarget(target: Jlang_Class): JTransition; cdecl; overload;
    function setDuration(duration: Int64): JTransition; cdecl;
    procedure setPathMotion(pathMotion: JPathMotion); cdecl;
    procedure setPropagation(transitionPropagation
      : JTransitionPropagation); cdecl;
  end;

  TJTransition = class(TJavaGenericImport<JTransitionClass, JTransition>)
  end;

  JTransition_EpicenterCallbackClass = interface(JObjectClass)
    ['{8141257A-130B-466C-A08D-AA3A00946F4C}']
    { class } function init: JTransition_EpicenterCallback; cdecl; // Deprecated
  end;

  [JavaSignature('android/transition/Transition$EpicenterCallback')]
  JTransition_EpicenterCallback = interface(JObject)
    ['{CE004917-266F-4076-8913-F23184824FBA}']
    function onGetEpicenter(transition: JTransition): JRect; cdecl;
    // Deprecated
  end;

  TJTransition_EpicenterCallback = class
    (TJavaGenericImport<JTransition_EpicenterCallbackClass,
    JTransition_EpicenterCallback>)
  end;

  JTransition_TransitionListenerClass = interface(IJavaClass)
    ['{D5083752-E8A6-46DF-BE40-AE11073C387E}']
    { class } procedure onTransitionCancel(transition: JTransition); cdecl;
    // Deprecated
    { class } procedure onTransitionEnd(transition: JTransition); cdecl;
    // Deprecated
    { class } procedure onTransitionStart(transition: JTransition); cdecl;
    // Deprecated
  end;

  [JavaSignature('android/transition/Transition$TransitionListener')]
  JTransition_TransitionListener = interface(IJavaInstance)
    ['{C32BE107-6E05-4898-AF0A-FAD970D66E29}']
    procedure onTransitionPause(transition: JTransition); cdecl; // Deprecated
    procedure onTransitionResume(transition: JTransition); cdecl; // Deprecated
  end;

  TJTransition_TransitionListener = class
    (TJavaGenericImport<JTransition_TransitionListenerClass,
    JTransition_TransitionListener>)
  end;

  JTransitionManagerClass = interface(JObjectClass)
    ['{4160EFA0-3499-4964-817E-46497BB5B957}']
    { class } function init: JTransitionManager; cdecl; // Deprecated
    { class } procedure beginDelayedTransition(sceneRoot: JViewGroup); cdecl;
      overload; // Deprecated
    { class } procedure beginDelayedTransition(sceneRoot: JViewGroup;
      transition: JTransition); cdecl; overload;
    { class } procedure endTransitions(sceneRoot: JViewGroup); cdecl;
    { class } procedure go(scene: JScene); cdecl; overload;
    { class } procedure go(scene: JScene; transition: JTransition);
      cdecl; overload;
    { class } procedure setTransition(scene: JScene; transition: JTransition);
      cdecl; overload;
    { class } procedure setTransition(fromScene: JScene; toScene: JScene;
      transition: JTransition); cdecl; overload;
  end;

  [JavaSignature('android/transition/TransitionManager')]
  JTransitionManager = interface(JObject)
    ['{FF5E1210-1F04-4F81-9CAC-3D7A5C4E972B}']
    procedure transitionTo(scene: JScene); cdecl;
  end;

  TJTransitionManager = class(TJavaGenericImport<JTransitionManagerClass,
    JTransitionManager>)
  end;

  JTransitionPropagationClass = interface(JObjectClass)
    ['{A881388A-C877-4DD9-9BAD-1BA4F56133EE}']
    { class } function init: JTransitionPropagation; cdecl; // Deprecated
    { class } procedure captureValues(transitionValues
      : JTransitionValues); cdecl;
    { class } function getPropagationProperties
      : TJavaObjectArray<JString>; cdecl;
  end;

  [JavaSignature('android/transition/TransitionPropagation')]
  JTransitionPropagation = interface(JObject)
    ['{7595B7EF-6BCE-4281-BC67-335E2FB6C091}']
    function getStartDelay(sceneRoot: JViewGroup; transition: JTransition;
      startValues: JTransitionValues; endValues: JTransitionValues): Int64;
      cdecl; // Deprecated
  end;

  TJTransitionPropagation = class
    (TJavaGenericImport<JTransitionPropagationClass, JTransitionPropagation>)
  end;

  JTransitionValuesClass = interface(JObjectClass)
    ['{3BF98CFA-6A4D-4815-8D42-15E97C916D91}']
    { class } function _Getvalues: JMap; cdecl;
    { class } function init: JTransitionValues; cdecl; // Deprecated
    { class } function hashCode: Integer; cdecl;
    { class } function toString: JString; cdecl;
    { class } property values: JMap read _Getvalues;
  end;

  [JavaSignature('android/transition/TransitionValues')]
  JTransitionValues = interface(JObject)
    ['{178E09E6-D32C-48A9-ADCF-8CCEA804052A}']
    function _Getview: JView; cdecl;
    function equals(other: JObject): Boolean; cdecl;
    property view: JView read _Getview;
  end;

  TJTransitionValues = class(TJavaGenericImport<JTransitionValuesClass,
    JTransitionValues>)
  end;

  JInterpolatorClass = interface(JTimeInterpolatorClass)
    ['{A575B46A-E489-409C-807A-1B8F2BE092E8}']
  end;

  [JavaSignature('android/view/animation/Interpolator')]
  JInterpolator = interface(JTimeInterpolator)
    ['{F1082403-52DA-4AF0-B017-DAB334325FC7}']
  end;

  TJInterpolator = class(TJavaGenericImport<JInterpolatorClass, JInterpolator>)
  end;

  JToolbar_LayoutParamsClass = interface(JActionBar_LayoutParamsClass)
    ['{6D43796C-C163-4084-BB30-6FE68AFD7ABB}']
    { class } function init(c: JContext; attrs: JAttributeSet)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
    { class } function init(width: Integer; height: Integer)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
    { class } function init(width: Integer; height: Integer; gravity: Integer)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
    { class } function init(gravity: Integer): JToolbar_LayoutParams; cdecl;
      overload; // Deprecated
    { class } function init(source: JToolbar_LayoutParams)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
    { class } function init(source: JActionBar_LayoutParams)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
    { class } function init(source: JViewGroup_MarginLayoutParams)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
    { class } function init(source: JViewGroup_LayoutParams)
      : JToolbar_LayoutParams; cdecl; overload; // Deprecated
  end;

  [JavaSignature('android/widget/Toolbar$LayoutParams')]
  JToolbar_LayoutParams = interface(JActionBar_LayoutParams)
    ['{BCD101F9-B7B7-4B2F-9460-056B3EA7B9F0}']
  end;

  TJToolbar_LayoutParams = class(TJavaGenericImport<JToolbar_LayoutParamsClass,
    JToolbar_LayoutParams>)
  end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JAnimator',
    TypeInfo(Androidapi.JNI.NFC.JAnimator));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JAnimator_AnimatorListener',
    TypeInfo(Androidapi.JNI.NFC.JAnimator_AnimatorListener));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JAnimator_AnimatorPauseListener',
    TypeInfo(Androidapi.JNI.NFC.JAnimator_AnimatorPauseListener));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JKeyframe',
    TypeInfo(Androidapi.JNI.NFC.JKeyframe));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JLayoutTransition',
    TypeInfo(Androidapi.JNI.NFC.JLayoutTransition));
  TRegTypes.RegisterType
    ('Androidapi.JNI.NFC.JLayoutTransition_TransitionListener',
    TypeInfo(Androidapi.JNI.NFC.JLayoutTransition_TransitionListener));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JPropertyValuesHolder',
    TypeInfo(Androidapi.JNI.NFC.JPropertyValuesHolder));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JStateListAnimator',
    TypeInfo(Androidapi.JNI.NFC.JStateListAnimator));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTimeInterpolator',
    TypeInfo(Androidapi.JNI.NFC.JTimeInterpolator));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTypeConverter',
    TypeInfo(Androidapi.JNI.NFC.JTypeConverter));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTypeEvaluator',
    TypeInfo(Androidapi.JNI.NFC.JTypeEvaluator));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JValueAnimator',
    TypeInfo(Androidapi.JNI.NFC.JValueAnimator));
  TRegTypes.RegisterType
    ('Androidapi.JNI.NFC.JValueAnimator_AnimatorUpdateListener',
    TypeInfo(Androidapi.JNI.NFC.JValueAnimator_AnimatorUpdateListener));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JNdefMessage',
    TypeInfo(Androidapi.JNI.NFC.JNdefMessage));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JNdefRecord',
    TypeInfo(Androidapi.JNI.NFC.JNdefRecord));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JNfcAdapter',
    TypeInfo(Androidapi.JNI.NFC.JNfcAdapter));
  TRegTypes.RegisterType
    ('Androidapi.JNI.NFC.JNfcAdapter_CreateBeamUrisCallback',
    TypeInfo(Androidapi.JNI.NFC.JNfcAdapter_CreateBeamUrisCallback));
  TRegTypes.RegisterType
    ('Androidapi.JNI.NFC.JNfcAdapter_CreateNdefMessageCallback',
    TypeInfo(Androidapi.JNI.NFC.JNfcAdapter_CreateNdefMessageCallback));
  TRegTypes.RegisterType
    ('Androidapi.JNI.NFC.JNfcAdapter_OnNdefPushCompleteCallback',
    TypeInfo(Androidapi.JNI.NFC.JNfcAdapter_OnNdefPushCompleteCallback));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JNfcAdapter_ReaderCallback',
    TypeInfo(Androidapi.JNI.NFC.JNfcAdapter_ReaderCallback));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JNfcEvent',
    TypeInfo(Androidapi.JNI.NFC.JNfcEvent));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTag',
    TypeInfo(Androidapi.JNI.NFC.JTag));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JNdef',
    TypeInfo(Androidapi.JNI.NFC.JNdef));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JPathMotion',
    TypeInfo(Androidapi.JNI.NFC.JPathMotion));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JScene',
    TypeInfo(Androidapi.JNI.NFC.JScene));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTransition',
    TypeInfo(Androidapi.JNI.NFC.JTransition));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTransition_EpicenterCallback',
    TypeInfo(Androidapi.JNI.NFC.JTransition_EpicenterCallback));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTransition_TransitionListener',
    TypeInfo(Androidapi.JNI.NFC.JTransition_TransitionListener));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTransitionManager',
    TypeInfo(Androidapi.JNI.NFC.JTransitionManager));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTransitionPropagation',
    TypeInfo(Androidapi.JNI.NFC.JTransitionPropagation));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JTransitionValues',
    TypeInfo(Androidapi.JNI.NFC.JTransitionValues));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JInterpolator',
    TypeInfo(Androidapi.JNI.NFC.JInterpolator));
  TRegTypes.RegisterType('Androidapi.JNI.NFC.JToolbar_LayoutParams',
    TypeInfo(Androidapi.JNI.NFC.JToolbar_LayoutParams));
end;

initialization

RegisterTypes;

end.
