using UnityEngine;
using XInputDotNetPure;


public class OtherInput : MonoBehaviour
{
    #region Fields   
    [System.NonSerialized] public GamePadState state;
    [System.NonSerialized] public GamePadState prevState;
    public GameManager gameManager;

    GameManager.eGameState gameState;

    public PlayerIndex playerIndex;


    #endregion Fields


    private void Update()
    {
        prevState = state;
        state = GamePad.GetState(playerIndex);

        switch (GameManager.managerInstance.gameState)
        {
            case GameManager.eGameState.CINEMATIC: //Press Start to go to next scene
                if (IsButtonDown(state.Buttons.Start, prevState.Buttons.Start))
                {
                    gameManager.LoadScene(1);
                }
                break;
            case GameManager.eGameState.START: //Press Start to go to next scene
                if (IsButtonDown(state.Buttons.Start, prevState.Buttons.Start))
                {
                    gameManager.LoadScene(2);
                }
                if (IsButtonDown(state.Buttons.Y, prevState.Buttons.Y))
                {
                    gameManager.gameState = GameManager.eGameState.QUIT;
                    gameManager.OnGameStateSet();
                }
                break;

            case GameManager.eGameState.SELECT:
                if (IsButtonDown(state.Buttons.A, prevState.Buttons.A))
                {
                    gameManager.PlayerJoin(playerIndex);
                }

                if (IsButtonDown(state.Buttons.B, prevState.Buttons.B))
                {
                    gameManager.PlayerLeave(playerIndex);
                }
                if (IsButtonDown(state.Buttons.Start, prevState.Buttons.Start))
                {
                    gameManager.PlayerStartMatch(playerIndex);
                }
                if (IsButtonDown(state.Buttons.Guide, prevState.Buttons.Guide))
                {
                    gameManager.PlayerLeave(playerIndex);
                }
                if (IsButtonDown(state.Buttons.Y, prevState.Buttons.Y))
                {
                    gameManager.gameState = GameManager.eGameState.CREDITS;
                    gameManager.OnGameStateSet();
                }
                if (IsButtonDown(state.Buttons.X, prevState.Buttons.X))
                {
                    gameManager.gameState = GameManager.eGameState.HELP;
                    gameManager.OnGameStateSet();
                }
                if (IsButtonDown(state.Buttons.LeftShoulder, prevState.Buttons.LeftShoulder) || IsButtonDown(state.Buttons.RightShoulder, prevState.Buttons.RightShoulder))
                {
                    gameManager.ChangeTeamMode();
                }

                    break;

            case GameManager.eGameState.ROUNDOVER:
                if (IsButtonDown(state.Buttons.A, prevState.Buttons.A))
                {
                    //Continue to next round ??do we want 2 players to ok this??
                }
                break;

            case GameManager.eGameState.GAMEOVER:

                if (IsButtonDown(state.Buttons.X, prevState.Buttons.X))
                {
                    gameManager.LoadScene(3);
                }
                break;

            case GameManager.eGameState.HELP:

                if (IsButtonDown(state.Buttons.B, prevState.Buttons.B))
                {
                        gameManager.gameState = GameManager.eGameState.SELECT;
                        gameManager.charSelectionTimer.DisableHelpWindow();
                }
                break;

            case GameManager.eGameState.CREDITS:
                if (IsButtonDown(state.Buttons.B, prevState.Buttons.B))
                {
                    gameManager.gameState = GameManager.eGameState.SELECT;
                    gameManager.charSelectionTimer.DisableCreditsWindow();
                }
                break;
            case GameManager.eGameState.PAUSE:
                if (IsButtonDown(state.Buttons.LeftShoulder, prevState.Buttons.LeftShoulder) && IsButtonDown(state.Buttons.RightShoulder, prevState.Buttons.RightShoulder))
                {
                    gameManager.UnpauseGame();
                    gameManager.LoadScene(2);
                    AudioManager.instance.Stop("GamePlay_01");
                }

                break;
            case GameManager.eGameState.QUIT:
                if (IsButtonDown(state.Buttons.A, prevState.Buttons.A))
                {
                    gameManager.QuitGame();
                }
                if (IsButtonDown(state.Buttons.B, prevState.Buttons.B))
                {
                    gameManager.gameState = GameManager.eGameState.START;
                    gameManager.OnGameStateSet();
                }
                break;
        }
    }

    private bool IsButtonDown(ButtonState button, ButtonState previousState)
    {
        return previousState == ButtonState.Released && button == ButtonState.Pressed;
    }
}
