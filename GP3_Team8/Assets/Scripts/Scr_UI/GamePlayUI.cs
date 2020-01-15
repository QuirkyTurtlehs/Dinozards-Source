using UnityEngine;
using UnityEngine.UI;

public class GamePlayUI : MonoBehaviour
{

    #region Fields
    [SerializeField]
    private GamePlayHandler gamePlayHandler;

    [SerializeField, Header("Pre-Game")]
    private GameObject preCounterPanel;

    [SerializeField]
    private Text preGameCounterText;

    [SerializeField, Header("Round Over Screen")]
    private GameObject nextRoundPanel;

    [SerializeField]
    private Text p1KillScore;

    [SerializeField]
    private Text p2KillScore;

    [SerializeField]
    private Text p3KillScore;

    [SerializeField]
    private Text p4KillScore;

    [SerializeField]
    private Text p1DamageScore;

    [SerializeField]
    private Text p2DamageScore;

    [SerializeField]
    private Text p3DamageScore;

    [SerializeField]
    private Text p4DamageScore;

    [SerializeField]
    private Text nextRoundTimer;

    [SerializeField, Header("Game Over Screen")]
    private GameObject gameOverPanel;

    [SerializeField]
    private Text winner;

    [SerializeField]
    private float timeToShowEndScreen = 3f;

    [SerializeField]
    private Sprite p1WinnerPortrait;

    [SerializeField]
    private Sprite p2WinnerPortrait;

    [SerializeField]
    private Sprite p3WinnerPortrait;

    [SerializeField]
    private Sprite p4WinnerPortrait;

    [SerializeField]
    private Sprite blueTeamWinnerPortrait;

    [SerializeField]
    private Sprite redTeamWinnerPortrait;

    [SerializeField]
    private Sprite drawPortrait;

    [SerializeField]
    private Sprite winnerTextImage;

    [SerializeField]
    private Sprite drawTextImage;

    [SerializeField]
    private Image winnerPortrait;

    [SerializeField]
    private Image resultScreenImage;

    private bool preGameTimerStarted = false;

    private bool nextRoundTimerStarted = false;

    private float uiNextGameCounter;

    [SerializeField, Header("Wizard Warnings")]
    private GameObject wizardWarning;

    [SerializeField]
    private GameObject wizardWarning2;

    [SerializeField, Header("Pause Menu")]
    private GameObject pauseMenu;

    private int warningsListIndex;

    private int preGameCounterIndex;

    private float soundCounterTimer = 0.9f;

    private bool matchStarted;

    #endregion Fields

    public void StartPreGame() //Set Countdown condition true
    {
        Invoke("CountdownBegin", 1f);
    }

    public void CountdownBegin()
    {
        preCounterPanel.SetActive(true);
        AudioManager.instance.Play("GameStart_01");
        Invoke("CountdownEnd", 2.5f);
    }

    public void CountdownEnd()
    {
        gamePlayHandler.StartRound();
    }

    public void StartRoundOver()
    {
        uiNextGameCounter = gamePlayHandler.nextGameCounter;
        nextRoundPanel.SetActive(true);
        nextRoundTimerStarted = true;       //Start Timer
    }

    public void StartGameOver(int winnerPlayer)
    {

        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                if (winnerPlayer == 0)
                {
                    winnerPortrait.sprite = drawPortrait;
                    resultScreenImage.sprite = drawTextImage;
                }
                else if (winnerPlayer == 1)
                {
                    winnerPortrait.sprite = p1WinnerPortrait;
                    resultScreenImage.sprite = winnerTextImage;
                }
                else if (winnerPlayer == 2)
                {
                    winnerPortrait.sprite = p2WinnerPortrait;
                    resultScreenImage.sprite = winnerTextImage;
                }
                else if (winnerPlayer == 3)
                {
                    winnerPortrait.sprite = p3WinnerPortrait;
                    resultScreenImage.sprite = winnerTextImage;
                }
                else if (winnerPlayer == 4)
                {
                    winnerPortrait.sprite = p4WinnerPortrait;
                    resultScreenImage.sprite = winnerTextImage;
                }
                break;
                
            case GameManager.eTeamMode.DOUBLES:
                if (winnerPlayer == 0)
                {
                    winnerPortrait.sprite = drawPortrait;
                    resultScreenImage.sprite = drawTextImage;
                }
                else if (winnerPlayer == 1)
                {
                    winnerPortrait.sprite = blueTeamWinnerPortrait;
                    resultScreenImage.sprite = winnerTextImage;
                }
                else if (winnerPlayer == 2)
                {
                    winnerPortrait.sprite = redTeamWinnerPortrait;
                    resultScreenImage.sprite = winnerTextImage;
                }
                break;
        }

        p1KillScore.text = gamePlayHandler.p1Kills.ToString();
        p2KillScore.text = gamePlayHandler.p2Kills.ToString();
        p3KillScore.text = gamePlayHandler.p3Kills.ToString();
        p4KillScore.text = gamePlayHandler.p4Kills.ToString();

        p1DamageScore.text = gamePlayHandler.player1Damage.ToString("0") + "hp";
        p2DamageScore.text = gamePlayHandler.player2Damage.ToString("0") + "hp";
        p3DamageScore.text = gamePlayHandler.player3Damage.ToString("0") + "hp";
        p4DamageScore.text = gamePlayHandler.player4Damage.ToString("0") + "hp";

        Invoke("ShowEndScreen", timeToShowEndScreen);
    }

    private void ShowEndScreen()
    {
        gameOverPanel.SetActive(true);
        GetComponent<GamePlayHandler>().DeactivateAllPlayers();
    }

    private void Update()
    {
        NextRoundTimer();
    }

    private void NextRoundTimer()
    {
        if (nextRoundTimerStarted)
        {
            uiNextGameCounter -= Time.deltaTime;
            nextRoundTimer.text = (uiNextGameCounter).ToString("0");
            if (uiNextGameCounter < 0)
            {
                nextRoundTimerStarted = false;
                nextRoundPanel.SetActive(false);
                gamePlayHandler.StartRound();
            }
        }
    }

    public void ShowWizardWarning01()
    {
        wizardWarning.SetActive(true);
    }

    public void DeactivateWizard()
    {
        wizardWarning.SetActive(false);
    }

    public void ShowWizardWarning02()
    {
        wizardWarning2.SetActive(true);
    }

    public void DeactivateWizard2()
    {
        wizardWarning2.SetActive(false);
    }

    public void ShowPauseMenu()
    {
        pauseMenu.SetActive(true);
    }

    public void HidePauseMenu()
    {
        pauseMenu.SetActive(false);
    }
}
