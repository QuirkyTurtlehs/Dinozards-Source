using UnityEngine;
using UnityEngine.UI;

public class CharacterSelectionTimer : MonoBehaviour
{
    [HideInInspector]
    public float matchStartTimer;
    private float currentMatchStartTimer;
    private int numberOfActivePlayers = 0;

    public Text preMatchCounterText;
    public GameObject minimumPlayersRequiredObj;
    public GameObject preCounterText;

    public GameObject helpWindow;
    public GameObject creditsWindow;

    [Header("Team Mode")]
    public Text teamModeText;
    public Text minimumPlayerRequiredText;

    private void OnEnable()
    {
        Invoke("PlayWizardSound", 0.2f);
    }

    private void PlayWizardSound()
    {
        AudioManager.instance.Play("WizardIn_01");
    }

    public void ResetCounter()
    {
        currentMatchStartTimer = matchStartTimer;
    }


    public void CheckActivePlayers(int numberOfPlayers)
    {
        numberOfActivePlayers = numberOfPlayers;
        ResetCounter();
        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                if (numberOfActivePlayers >= 2)
                {
                    minimumPlayersRequiredObj.SetActive(false);
                    preCounterText.SetActive(true);
                }
                else
                {
                    minimumPlayersRequiredObj.SetActive(true);
                    preCounterText.SetActive(false);
                }
                break;
            case GameManager.eTeamMode.DOUBLES:
                if (numberOfActivePlayers >= 4)
                {
                    minimumPlayersRequiredObj.SetActive(false);
                    preCounterText.SetActive(true);
                }
                else
                {
                    minimumPlayersRequiredObj.SetActive(true);
                    preCounterText.SetActive(false);
                }
                break;
        }
    }

    private void Update()
    {
        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                if (numberOfActivePlayers >= 2 && GameManager.managerInstance.gameState == GameManager.eGameState.SELECT)
                {
                    PreMatchCounter();
                }
                break;
            case GameManager.eTeamMode.DOUBLES:
                if (numberOfActivePlayers >= 4 && GameManager.managerInstance.gameState == GameManager.eGameState.SELECT)
                {
                    PreMatchCounter();
                }
                break;
        }
    }

    void PreMatchCounter()
    {
        currentMatchStartTimer -= Time.deltaTime;
        if (currentMatchStartTimer < 0)
        {
            GameManager.managerInstance.StartMatch();
        }
        else
        {
            preMatchCounterText.text = currentMatchStartTimer.ToString("0");
        }
    }

    public void EnableHelpWindow()
    {
        helpWindow.SetActive(true);
    }

    public void EnableCreditsWindow()
    {
        creditsWindow.SetActive(true);
    }

    public void DisableHelpWindow()
    {
        helpWindow.SetActive(false);
    }

    public void DisableCreditsWindow()
    {
        creditsWindow.SetActive(false);
    }

    public void UpdateTeamText(GameManager.eTeamMode teamMode)
    {
        switch (teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                teamModeText.text = "SOLO MODE";
                minimumPlayerRequiredText.text = "Minimum 2 players required";
                break;
            case GameManager.eTeamMode.DOUBLES:
                teamModeText.text = "2 vs 2";
                minimumPlayerRequiredText.text = "Minimum 4 players required";
                break;
        }
    }
}
