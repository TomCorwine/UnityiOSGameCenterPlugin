using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;
using AOT;

public class FrameworkBridge : MonoBehaviour
{
  public delegate void GameLoadedHandler(string gameData, string errorString);
  public delegate void GameSavedHandler(bool success, string errorString);

  private static GameLoadedHandler gameLoadedCallback;
  private static GameSavedHandler gameSavedCallback;

  #if UNITY_IOS
  [DllImport ("__Internal")]
  private static extern void framework_setSaveDelegate(DelegateSaveMessage callback);

  [DllImport ("__Internal")]
  private static extern void framework_saveGame(string dictionaryString);

  [DllImport ("__Internal")]
  private static extern void framework_setLoadDelegate(DelegateLoadMessage callback);

  [DllImport ("__Internal")]
  private static extern void framework_loadGame();

  private delegate void DelegateSaveMessage(bool success, string errorString);

  [MonoPInvokeCallback(typeof(DelegateSaveMessage))] 
  private static void delegateSaveMessageReceived(bool success, string errorString)
  {
    if (null != gameSavedCallback) {
      gameSavedCallback(success, errorString);
    }
  }

  private delegate void DelegateLoadMessage(string dictionaryString, string errorString);

  [MonoPInvokeCallback(typeof(DelegateLoadMessage))] 
  private static void delegateLoadMessageReceived(string dictionaryString, string errorString)
  {
    if (null != gameLoadedCallback) {
      gameLoadedCallback(dictionaryString, errorString);
    }
  }
  #endif

  public static void saveGame(string dictionaryString, GameSavedHandler callback)
  {
    gameSavedCallback = callback;

    #if UNITY_IOS
    if (Application.platform == RuntimePlatform.IPhonePlayer) {
      framework_saveGame(dictionaryString);
    }
    #endif
  }

  public static void loadGame(GameLoadedHandler callback)
  {
    gameLoadedCallback = callback;

    #if UNITY_IOS
    if (Application.platform == RuntimePlatform.IPhonePlayer) {
      framework_loadGame();
    }
    #endif
  }

  public static void initializeDelegate()
  {
    #if UNITY_IOS
    if (Application.platform == RuntimePlatform.IPhonePlayer)
    {
      framework_setSaveDelegate(delegateSaveMessageReceived);
      framework_setLoadDelegate(delegateLoadMessageReceived);
    }
    #endif
  }
}
