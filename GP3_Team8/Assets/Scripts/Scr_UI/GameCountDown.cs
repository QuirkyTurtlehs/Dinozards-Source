using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameCountDown : MonoBehaviour
{
    public GameObject bigSpark;

    public void PlaySplash()
    {
        AudioManager.instance.Play("Splash_01");
    }

    public void PlayGongo()
    {
        AudioManager.instance.Play("CountdownOver_01");
        bigSpark.SetActive(true);
    }

    public void PlayReady()
    {
        AudioManager.instance.Play("Ready_01");
    }
}
