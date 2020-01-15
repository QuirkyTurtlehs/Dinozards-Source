using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameOver : MonoBehaviour
{
    public float gameRestartTimer;
    private float currentGameRestartTimer;
    private bool isGameOverTriggered;

    public Text gameRestartCounterText;

    public GameObject smoke;

    void TriggerGameOver()
    {
        GameManager.managerInstance.gameState = GameManager.eGameState.GAMEOVER;
    }

    public void ResetCounter()
    {
        isGameOverTriggered = true;
        currentGameRestartTimer = gameRestartTimer;
        isGameOverTriggered = true;
    }

    private void Update()
    {
        if (isGameOverTriggered)
        {
            GameRestartCounter();
        }

    }

    void GameRestartCounter()
    {
        currentGameRestartTimer -= Time.deltaTime;
        if (currentGameRestartTimer < 0)
        {
            GameManager.managerInstance.RestartGame();
        }
        else
        {
            gameRestartCounterText.text = currentGameRestartTimer.ToString("0");
        }
    }

    public void TriggerSmoke()
    {
        smoke.SetActive(true);
        AudioManager.instance.Play("PlayerJoined_01");
    }

    public void PlayWinner()
    {
        AudioManager.instance.Play("Winner_01");
        AudioManager.instance.Play("Claps_01");
    }
}
