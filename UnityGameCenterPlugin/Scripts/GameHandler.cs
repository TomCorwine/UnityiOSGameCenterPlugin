using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SocialPlatforms.GameCenter;

public class GameHandler : MonoBehaviour
{
  public Text gameText;
  public Text inputText;

  void Start()
  {
    FrameworkBridge.initializeDelegate();

    Social.localUser.Authenticate(success => {
      if (success)
      {
        Debug.Log("Authenticated, checking achievements");

        FrameworkBridge.GameLoadedHandler gameLoaded = new FrameworkBridge.GameLoadedHandler(OnGameLoaded);
        FrameworkBridge.loadGame(gameLoaded);
      }
      else
      {
        Debug.Log("Failed to authenticate");
      }
    });

    GameCenterPlatform.ShowDefaultAchievementCompletionBanner(true);
  }

  public void SaveGame()
  {
    FrameworkBridge.GameSavedHandler gameSaved = new FrameworkBridge.GameSavedHandler(OnGameSaved);
    FrameworkBridge.saveGame(inputText.text, gameSaved);
  }

  void OnGameSaved(bool success, string errorString)
  {
    if (success) {
      gameText.text = string.Format("Saved: {0}", inputText.text);
    } else {
      gameText.text = string.Format("Error: {0}", errorString);
    }
  }

  void OnGameLoaded(string gameData, string errorString)
  {
    if (null != gameData) {
      gameText.text = string.Format("Loaded: {0}", gameData);
    } else {
      gameText.text = string.Format("Error: {0}", errorString);
    }
  }
}
