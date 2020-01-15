using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InitialScreen : MonoBehaviour
{
    public GameObject quitGame;

    public void PlaySound()
    {
        AudioManager.instance.Play("PlayerJoined_01");
    }

    public void EnableQuitGame()
    {
        quitGame.SetActive(true);
    }

    public void DisableQuitGame()
    {
        quitGame.SetActive(false);
    }
}

