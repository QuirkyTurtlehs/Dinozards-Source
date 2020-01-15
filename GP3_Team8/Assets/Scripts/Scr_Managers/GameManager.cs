using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using XInputDotNetPure;


public class GameManager : MonoBehaviour
{

    // Public
    public static GameManager managerInstance;

    #region Fields    
    public enum eGameState
    {
        CINEMATIC,
        START,
        SELECT,
        PLAYING,
        WAITING,
        DEAD,
        ROUNDOVER,
        GAMEOVER,
        CREDITS,
        HELP,
        PAUSE,
        QUIT,
        NULL
    }

    public eGameState gameState;

    public enum eTeamMode
    {
        SOLO,
        DOUBLES
    }

    public eTeamMode teamMode;

    [HideInInspector]
    public bool p1Active = true;
    [HideInInspector]
    public bool p2Active = true;
    [HideInInspector]
    public bool p3Active = true;
    [HideInInspector]
    public bool p4Active = true;

    [SerializeField, Header("Character Selection Settings")]
    private float characterSelectionCountdownTimer = 5f;

    [SerializeField, Header("Match Settings")]
    private float roundCountdownTimer = 3f;

    public int maxNumberOfRounds = 3;

    [SerializeField, Header("Audio")]
    private List<string> playerJoinedAudioNames;

    //Private

    private int numberOfPlayersJoined;

    public CharacterSelectionTimer charSelectionTimer;

    private GamePlayHandler gamePlayHandler;

    private CharacterPortrait p1Portrait;

    private CharacterPortrait p2Portrait;

    private CharacterPortrait p3Portrait;

    private CharacterPortrait p4Portrait;

    [HideInInspector]
    public int player1Victories = 0;

    [HideInInspector]
    public int player2Victories = 0;

    [HideInInspector]
    public int player3Victories = 0;

    [HideInInspector]
    public int player4Victories = 0;

    [HideInInspector]
    public int draws = 0;

    #endregion Fields

    private void Awake()
    {
        DontDestroyOnLoad(gameObject);

        if (managerInstance == null)
        {
            managerInstance = this;
            OnLevelWasLoaded(SceneManager.GetActiveScene().buildIndex);
            return;
        }
        else
        {
            Destroy(gameObject);
        }

    }

    private void Start()
    {
        GamePlayHandler.PlayerVictoryInfo += HandlePlayerVictory;
    }

    public void InitiateVariables()
    {
        p1Active = false;
        p2Active = false;
        p3Active = false;
        p4Active = false;
        numberOfPlayersJoined = 0;
        teamMode = eTeamMode.SOLO;
    }

    #region Character Selection
    public void PlayerJoin(PlayerIndex playerIndex)
    {
        if (playerIndex == PlayerIndex.One)
        {
            if (!p1Active)
            {
                p1Active = true;
                CheckNumberOfPlayers(true);

                p1Portrait.PlayerActive();
            }
            else
            {
                //Add visual animation if needed
                return;
            }
        }

        else if (playerIndex == PlayerIndex.Two)
        {
            if (!p2Active)
            {
                p2Active = true;
                CheckNumberOfPlayers(true);

                p2Portrait.PlayerActive();
            }
            else
            {
                //Add visual animation
                return;
            }
        }

        else if (playerIndex == PlayerIndex.Three)
        {
            if (!p3Active)
            {
                p3Active = true;
                CheckNumberOfPlayers(true);

                p3Portrait.PlayerActive();
            }
            else
            {
                //Add visual animation
                return;
            }
        }

        else if (playerIndex == PlayerIndex.Four)
        {
            if (!p4Active)
            {
                p4Active = true;
                CheckNumberOfPlayers(true);

                p4Portrait.PlayerActive();
            }
            else
            {
                //Add visual animation
                return;
            }
        }
    }

    public void PlayerLeave(PlayerIndex playerIndex)
    {
        if (numberOfPlayersJoined == 0)
        {
            LoadScene(1);
        }
        else if (playerIndex == PlayerIndex.One)
        {
            if (p1Active)
            {
                p1Active = false;
                CheckNumberOfPlayers(false);
                p1Portrait.PlayerDeactivate();
            }
        }

        else if (playerIndex == PlayerIndex.Two)
        {
            if (p2Active)
            {
                p2Active = false;
                CheckNumberOfPlayers(false);
                p2Portrait.PlayerDeactivate();
            }
        }

        else if (playerIndex == PlayerIndex.Three)
        {
            if (p3Active)
            {
                p3Active = false;
                CheckNumberOfPlayers(false);
                p3Portrait.PlayerDeactivate();
            }
        }

        else if (playerIndex == PlayerIndex.Four)
        {
            if (p4Active)
            {
                p4Active = false;
                CheckNumberOfPlayers(false);
                p4Portrait.PlayerDeactivate();
            }
        }
    }

    private void CheckNumberOfPlayers(bool isPlayerActive)
    {
        if (isPlayerActive)
        {
            numberOfPlayersJoined++;
            int listIndex = Random.Range(0, playerJoinedAudioNames.Count);
            AudioManager.instance.Play(playerJoinedAudioNames[listIndex]);
            AudioManager.instance.Play("PlayerJoined_01");
        }
        else
        {
            numberOfPlayersJoined--;
        }

        if (charSelectionTimer)
        {
            charSelectionTimer.CheckActivePlayers(numberOfPlayersJoined);
        }
    }

    public void PlayerStartMatch(PlayerIndex playerIndex)
    {
        if (playerIndex == PlayerIndex.One)
        {
            if (p1Active)
            {
                StartMatch();
            }
            else
            {
                //TODO Add visual animation???
                return;
            }
        }

        else if (playerIndex == PlayerIndex.Two)
        {
            if (p2Active)
            {
                StartMatch();
            }
            else
            {
                //TODO Add visual animation???
                return;
            }
        }

        else if (playerIndex == PlayerIndex.Three)
        {
            if (p3Active)
            {
                StartMatch();
            }
            else
            {
                //TODO Add visual animation???
                return;
            }
        }

        else if (playerIndex == PlayerIndex.Four)
        {
            if (p4Active)
            {
                StartMatch();
            }
            else
            {
                //TODO Add visual animation???
                return;
            }
        }
    }

    public void StartMatch()
    {
        switch (teamMode)
        {
            case eTeamMode.SOLO:
                if (numberOfPlayersJoined >= 2)
                {
                    AudioManager.instance.Play("PressStart_01");
                    LoadScene(4);
                }
                break;
            case eTeamMode.DOUBLES:
                if (numberOfPlayersJoined >= 3)
                {
                    AudioManager.instance.Play("PressStart_01");
                    LoadScene(4);
                }
                break;
        }
    }

    #endregion Character Selection

    #region GameOver

    public void FinishMatch()
    {
        AudioManager.instance.Stop("GamePlay_01");
        AudioManager.instance.Play("GameOver_01");
    }

    public void RestartGame()
    {
        LoadScene(2);
    }


    #endregion GameOver
    public void LoadScene(int sceneIndex)
    {
        SceneManager.LoadScene(sceneIndex);
    }

    private void OnLevelWasLoaded(int level)
    {
        if (level == 0)
        {
            gameState = eGameState.CINEMATIC;
        }
        else if (level == 1)
        {
            gameState = eGameState.START;
        }
        else if (level == 2)
        {
            gameState = eGameState.SELECT;
        }
        else if (level == 3)
        {
            gameState = eGameState.PLAYING;
        }
        else if (level == 4)
        {
            gameState = eGameState.WAITING;
        }
        OnGameStateSet();
    }

    private void HandlePlayerVictory(int index)
    {
        switch (index)
        {
            case 0:
                draws++;
                break;
            case 1:
                player1Victories++;
                break;
            case 2:
                player2Victories++;
                break;
            case 3:
                player3Victories++;
                break;
            case 4:
                player4Victories++;
                break;
        }
    }

    public void OnGameStateSet()
    {
        switch (gameState)
        {
            case eGameState.CINEMATIC:
                InitiateVariables();

                break;

            case eGameState.START:
                InitiateVariables();
                InitialScreen initialScreen = FindObjectOfType<InitialScreen>();
                initialScreen.DisableQuitGame();
                break;

            case eGameState.SELECT:
                InitiateVariables();

                p1Portrait = GameObject.FindGameObjectWithTag("Player_01_Portrait").GetComponent<CharacterPortrait>();
                p2Portrait = GameObject.FindGameObjectWithTag("Player_02_Portrait").GetComponent<CharacterPortrait>();
                p3Portrait = GameObject.FindGameObjectWithTag("Player_03_Portrait").GetComponent<CharacterPortrait>();
                p4Portrait = GameObject.FindGameObjectWithTag("Player_04_Portrait").GetComponent<CharacterPortrait>();

                charSelectionTimer = FindObjectOfType<CharacterSelectionTimer>();
                charSelectionTimer.matchStartTimer = characterSelectionCountdownTimer;
                charSelectionTimer.ResetCounter();

                AudioManager.instance.Play("PressStart_01");
                break;

            case eGameState.PLAYING:
                gamePlayHandler = FindObjectOfType<GamePlayHandler>();
                gamePlayHandler.AwakeLevel(this);

                AudioManager.instance.Play("GamePlay_01");
                break;

            case eGameState.WAITING:
                break;

            case eGameState.GAMEOVER:
                break;

            case eGameState.HELP:
                charSelectionTimer.EnableHelpWindow();
                break;

            case eGameState.CREDITS:
                charSelectionTimer.EnableCreditsWindow();
                break;

            case eGameState.PAUSE:
                gamePlayHandler = FindObjectOfType<GamePlayHandler>();
                gamePlayHandler.PauseGame();
                break;

            case eGameState.QUIT:
                InitialScreen initialScreen2 = FindObjectOfType<InitialScreen>();
                initialScreen2.EnableQuitGame();
                break;

            case eGameState.NULL:
                break;

            default:
                break;
        }
    }

    public void ChangeTeamMode()
    {
        switch (teamMode)
        {
            case eTeamMode.SOLO:
                teamMode = eTeamMode.DOUBLES;
                if (charSelectionTimer)
                {
                    charSelectionTimer.UpdateTeamText(teamMode);
                }
                break;

            case eTeamMode.DOUBLES:
                teamMode = eTeamMode.SOLO;
                if (charSelectionTimer)
                {
                    charSelectionTimer.UpdateTeamText(teamMode);
                }
                break;

        }
        if (charSelectionTimer)
        {
            charSelectionTimer.CheckActivePlayers(numberOfPlayersJoined);
            charSelectionTimer.ResetCounter();
        }

        p1Portrait.SetTeamMode();
        p2Portrait.SetTeamMode();
        p3Portrait.SetTeamMode();
        p4Portrait.SetTeamMode();

        AudioManager.instance.Play("PressStart_01");
    }

    public void UnpauseGame()
    {
        gameState = eGameState.PLAYING;
        gamePlayHandler = FindObjectOfType<GamePlayHandler>();
        gamePlayHandler.UnpauseGame();
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}
