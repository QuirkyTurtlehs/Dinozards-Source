using System.Collections.Generic;
using UnityEngine;

public class GamePlayHandler : MonoBehaviour
{

    #region Fields

    [SerializeField]
    private GameObject player1Prefab;

    [SerializeField]
    private GameObject player2Prefab;

    [SerializeField]
    private GameObject player3Prefab;

    [SerializeField]
    private GameObject player4Prefab;

    public int preGameCounter = 3;

    public int nextGameCounter = 5;

    [SerializeField]
    private GamePlayUI gamePlayUI;

    [HideInInspector]
    public LavaGround lavaGround;

    [HideInInspector]
    public List<GameObject> playerCharacters = new List<GameObject>();

    [HideInInspector]
    public List<Transform> playersTransform = new List<Transform>();

    private int currentRound;

    private bool isGameStarted;

    [HideInInspector]
    public int activePlayers;

    private int blueTeamPlayers;

    private int redTeamPlayers;

    [HideInInspector]
    public int blueTeamScore;

    [HideInInspector]
    public int redTeamScore;

    [HideInInspector]
    public int playerOneScore;

    [HideInInspector]
    public int playerTwoScore;

    [HideInInspector]
    public int playerThreeScore;

    [HideInInspector]
    public int playerFourScore;

    [HideInInspector]
    private StormBehavior storm;

    private Vector3 p1Position;

    private Vector3 p2Position;

    private Vector3 p3Position;

    private Vector3 p4Position;

    private Quaternion p1Rotation;

    private Quaternion p2Rotation;

    private Quaternion p3Rotation;

    private Quaternion p4Rotation;

    private MultipleTargetCamera newCamera;

    public float player1Damage = 0f;

    public float player2Damage = 0f;

    public float player3Damage = 0f;

    public float player4Damage = 0f;

    public int p1Kills;

    public int p2Kills;

    public int p3Kills;

    public int p4Kills;

    public delegate void PlayerVictory(int index);

    public static event PlayerVictory PlayerVictoryInfo;

    #endregion Fields

    #region Awake
    public void AwakeLevel(GameManager currentGameManager)
    {
        InitializeVariables();

        storm = FindObjectOfType<StormBehavior>();
        newCamera = FindObjectOfType<MultipleTargetCamera>();

        GetPlayersInitialLocation();
    }

    private void InitializeVariables()
    {
        isGameStarted = false;
    }

    #endregion Awake

    #region Start
    private void Start()
    {
        SetPlayersTeams(); //Set proper teams according to game team mode
        DeactivateAllPlayers();
        gamePlayUI.StartPreGame();  //Triggers StartRound() + Trigger UI Panel check GamePlayUI.cs for more details --- 

        DashAbility.damageDealtInfo += PlayerDamageDealtHandle;
        Projectile.damageDealtInfo += PlayerDamageDealtHandle;
        ProjectileMergeExplosion.damageDealtInfo += PlayerDamageDealtHandle;
    }

    void PlayerDamageDealtHandle(int index, float amount)
    {
        switch (index)
        {
            case 1:
                player1Damage += amount;
                break;

            case 2:
                player2Damage += amount;
                break;

            case 3:
                player3Damage += amount;
                break;

            case 4:
                player4Damage += amount;
                break;

            default:
                break;
        }
    }

    public void StartRound()
    {

        if (GameManager.managerInstance.p1Active)
        {
            player1Prefab.SetActive(true);
        }

        if (GameManager.managerInstance.p2Active)
        {
            player2Prefab.SetActive(true);
        }

        if (GameManager.managerInstance.p3Active)
        {
            player3Prefab.SetActive(true);
        }

        if (GameManager.managerInstance.p4Active)
        {
            player4Prefab.SetActive(true);
        }

        SetPlayersInitialLocation();
        newCamera.StartCamera();
        GetPlayersInSession();
        currentRound++;

            if (currentRound > 1)
            {
                storm.RestartStorm();
            }
        isGameStarted = true;
    }

    private void GetPlayersInSession()
    {
        activePlayers = 0;
        playerCharacters.Clear();
        foreach (var item in GameObject.FindGameObjectsWithTag("Player"))
        {
            playerCharacters.Add(item);
            playersTransform.Add(item.transform);
            activePlayers++;
        }
    }

    #endregion Start       

    private void Update()
    {
        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                if (isGameStarted && activePlayers <= 1)
                {
                    isGameStarted = false;
                    EndRound();
                }
                break;

            case GameManager.eTeamMode.DOUBLES:
                if (isGameStarted && (redTeamPlayers == 0 || blueTeamPlayers == 0))
                {
                    isGameStarted = false;
                    EndRound();
                }
                break;
        }
    }

    private void EndRound()
    {
        isGameStarted = false;

        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                if (playerCharacters.Count == 0)
                {
                    PlayerVictoryInfo(0);
                }

                else if (playerCharacters[0].GetComponent<PlayerInput>().playerIndex.ToString() == "One")
                {
                    playerOneScore++;
                    PlayerVictoryInfo(1);
                }
                else if (playerCharacters[0].GetComponent<PlayerInput>().playerIndex.ToString() == "Two")
                {
                    playerTwoScore++;
                    PlayerVictoryInfo(2);
                }
                else if (playerCharacters[0].GetComponent<PlayerInput>().playerIndex.ToString() == "Three")
                {
                    playerThreeScore++;
                    PlayerVictoryInfo(3);
                }
                else if (playerCharacters[0].GetComponent<PlayerInput>().playerIndex.ToString() == "Four")
                {
                    playerFourScore++;
                    PlayerVictoryInfo(4);
                }
                break;

            case GameManager.eTeamMode.DOUBLES:
                if (playerCharacters.Count == 0)
                {
                    PlayerVictoryInfo(0);
                }

                else if (redTeamPlayers == 0)
                {
                    blueTeamScore++;
                }
                else if (blueTeamScore == 0)
                {
                    redTeamScore++;
                }
                break;
        }

        storm.StopStorm();
        CheckRoundEnd();
    }

    private void CheckRoundEnd()
    {
        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                if (playerOneScore >= GameManager.managerInstance.maxNumberOfRounds)
                {
                    EndGame(1);
                }
                else if (playerTwoScore >= GameManager.managerInstance.maxNumberOfRounds)
                {
                    EndGame(2);
                }
                else if (playerThreeScore >= GameManager.managerInstance.maxNumberOfRounds)
                {
                    EndGame(3);
                }
                else if (playerFourScore >= GameManager.managerInstance.maxNumberOfRounds)
                {
                    EndGame(4);
                }
                else
                {
                    EndGame(0);  
                    DeactivateAllPlayers();
                }
                break;

            case GameManager.eTeamMode.DOUBLES:
                if (blueTeamScore >= GameManager.managerInstance.maxNumberOfRounds)
                {
                    blueTeamScore++;
                    EndGame(1);
                }
                else if (redTeamScore >= GameManager.managerInstance.maxNumberOfRounds)
                {
                    redTeamScore++;
                    EndGame(2);
                }
                break;
        }
    }

    private void EndGame(int winnerPlayer)
    {
        GameManager.managerInstance.FinishMatch();

        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                switch (winnerPlayer)
                {
                    case 1:
                        player1Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player1Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        break;

                    case 2:
                        player2Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player2Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        break;

                    case 3:
                        player3Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player3Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        break;

                    case 4:
                        player4Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player4Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        break;
                }
                break;

            case GameManager.eTeamMode.DOUBLES:
                switch (winnerPlayer)
                {

                    case 1:
                        player1Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player1Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        player2Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player2Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        break;

                    case 2:
                        player3Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player3Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        player4Prefab.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsWinning);
                        player4Prefab.transform.rotation = new Quaternion(0, 260, 0, 0);
                        break;
                }
                 break;
        }

        storm.StopStorm();
        gamePlayUI.StartGameOver(winnerPlayer);
    }

    public void PlayerKilled(GameObject killedPlayer, int instigator) {

        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                activePlayers--;
                break;
            case GameManager.eTeamMode.DOUBLES:
                if (killedPlayer.GetComponentInParent<PlayerStates>().inTeam == PlayerStates.Team.Team1)
                {
                    blueTeamPlayers--;
                }
                else if (killedPlayer.GetComponentInParent<PlayerStates>().inTeam == PlayerStates.Team.Team2)
                {
                    redTeamPlayers--;
                }
                break;
        }
        playerCharacters.Remove(killedPlayer);


        if (instigator == 1)
        {
            p1Kills++;
        }
        else if (instigator == 2)
        {
            p2Kills++;
        }
        else if (instigator == 3)
        {
            p3Kills++;
        }
        else if (instigator == 4)
        {
            p4Kills++;
        }

        killedPlayer.GetComponent<PlayerStates>().SetStateTo(PlayerStates.PossibleStates.IsDead); // Here a bunch of other Dead Stuff gets set as well       
        newCamera.RemovePlayer(killedPlayer);

    }

    public void SetPlayersTeams()
    {
        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                player1Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team1;
                player2Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team2;
                player3Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team3;
                player4Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team4;
                break;

            case GameManager.eTeamMode.DOUBLES:
                player1Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team1;
                player2Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team1;
                player3Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team2;
                player4Prefab.GetComponentInParent<PlayerStates>().inTeam = PlayerStates.Team.Team2;
                redTeamPlayers = 2;
                blueTeamPlayers = 2;
                break;
        }
    }

    public void DeactivateAllPlayers()
    {
        player1Prefab.SetActive(false);
        player2Prefab.SetActive(false);
        player3Prefab.SetActive(false);
        player4Prefab.SetActive(false);
    }

    private void GetPlayersInitialLocation()
    {
        p1Position = player1Prefab.transform.position;
        p2Position = player2Prefab.transform.position;
        p3Position = player3Prefab.transform.position;
        p4Position = player4Prefab.transform.position;
        p1Rotation = player1Prefab.transform.rotation;
        p2Rotation = player2Prefab.transform.rotation;
        p3Rotation = player3Prefab.transform.rotation;
        p4Rotation = player4Prefab.transform.rotation;
    }

    private void SetPlayersInitialLocation()
    {
        player1Prefab.transform.position = p1Position;
        player1Prefab.transform.rotation = p1Rotation;
        player2Prefab.transform.position = p2Position;
        player2Prefab.transform.rotation = p2Rotation;
        player3Prefab.transform.position = p3Position;
        player3Prefab.transform.rotation = p3Rotation;
        player4Prefab.transform.position = p4Position;
        player4Prefab.transform.rotation = p4Rotation;
    }
    public void PauseGame()
    {
        Time.timeScale = 0f;
        gamePlayUI.ShowPauseMenu();
    }

    public void UnpauseGame()
    {
        Time.timeScale = 1f;
        gamePlayUI.HidePauseMenu();
    }
}