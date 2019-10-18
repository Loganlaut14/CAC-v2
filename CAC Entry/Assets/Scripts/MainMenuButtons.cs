using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenuButtons : MonoBehaviour {

	public void NewGame()
    {
        SceneManager.LoadScene("Level 1 Updated");
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}
