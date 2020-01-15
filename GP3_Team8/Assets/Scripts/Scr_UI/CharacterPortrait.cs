using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XInputDotNetPure;
using UnityEngine.UI;

public class CharacterPortrait : MonoBehaviour
{
    public PlayerIndex playerIndex;
    private GameManager gameManager;
    public bool isJoined;

    public Image prefabPortraitImage;

    private Sprite playerOneOffPortrait;
    private Sprite playerTwoOffPortrait;
    private Sprite playerThreeOffPortrait;
    private Sprite playerFourOffPortrait;

    private Sprite playerOnePortrait;
    private Sprite playerTwoPortrait;
    private Sprite playerThreePortrait;
    private Sprite playerFourPortrait;

    public Sprite playerOneOffPortraitSolo;
    public Sprite playerTwoOffPortraitSolo;
    public Sprite playerThreeOffPortraitSolo;
    public Sprite playerFourOffPortraitSolo;

    public Sprite playerOnePortraitSolo;
    public Sprite playerTwoPortraitSolo;
    public Sprite playerThreePortraitSolo;
    public Sprite playerFourPortraitSolo;

    public Sprite playerOneOffPortraitTeam;
    public Sprite playerTwoOffPortraitTeam;
    public Sprite playerThreeOffPortraitTeam;
    public Sprite playerFourOffPortraitTeam;

    public Sprite playerOnePortraitTeam;
    public Sprite playerTwoPortraitTeam;
    public Sprite playerThreePortraitTeam;
    public Sprite playerFourPortraitTeam;

    public GameObject join;
    public GameObject leave;

    public Animator animator;


    private void Start()
    {
        SetTeamMode();
        if (playerIndex == PlayerIndex.One)
        {
            prefabPortraitImage.sprite = playerOneOffPortrait;
        }
        else if (playerIndex == PlayerIndex.Two)
        {
            prefabPortraitImage.sprite = playerTwoOffPortrait;
        }
        else if (playerIndex == PlayerIndex.Three)
        {
            prefabPortraitImage.sprite = playerThreeOffPortrait;
        }
        else if (playerIndex == PlayerIndex.Four)
        {
            prefabPortraitImage.sprite = playerFourOffPortrait;
        }
    }

    public void PlayerActive()
    {

        join.SetActive(false);
        leave.SetActive(true);

        if (playerIndex == PlayerIndex.One)
        {
            prefabPortraitImage.sprite = playerOnePortrait;
        }
        else if (playerIndex == PlayerIndex.Two)
        {
            prefabPortraitImage.sprite = playerTwoPortrait;
        }
        else if (playerIndex == PlayerIndex.Three)
        {
            prefabPortraitImage.sprite = playerThreePortrait;
        }
        else if (playerIndex == PlayerIndex.Four)
        {
            prefabPortraitImage.sprite = playerFourPortrait;
        }

        animator.SetBool("isJoined", true);

    }

    public void PlayerDeactivate()
    {
        join.SetActive(true);
        leave.SetActive(false);

        if (playerIndex == PlayerIndex.One)
        {
            prefabPortraitImage.sprite = playerOneOffPortrait;
        }
        else if (playerIndex == PlayerIndex.Two)
        {
            prefabPortraitImage.sprite = playerTwoOffPortrait;
        }
        else if (playerIndex == PlayerIndex.Three)
        {
            prefabPortraitImage.sprite = playerThreeOffPortrait;
        }
        else if (playerIndex == PlayerIndex.Four)
        {
            prefabPortraitImage.sprite = playerFourOffPortrait;
        }

        animator.SetBool("isJoined", false);
        AudioManager.instance.Play("CharacterDeselected_01");
    }

    public void SetTeamMode()
    {
        switch(GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:
                playerOnePortrait = playerOnePortraitSolo;
                playerOneOffPortrait = playerOneOffPortraitSolo;
                playerTwoPortrait = playerTwoPortraitSolo;
                playerTwoOffPortrait = playerTwoOffPortraitSolo;
                playerThreePortrait = playerThreePortraitSolo;
                playerThreeOffPortrait = playerThreeOffPortraitSolo;
                playerFourPortrait = playerFourPortraitSolo;
                playerFourOffPortrait = playerFourOffPortraitSolo;
                break;
            case GameManager.eTeamMode.DOUBLES:
                playerOnePortrait = playerOnePortraitTeam;
                playerOneOffPortrait = playerOneOffPortraitTeam;
                playerTwoPortrait = playerTwoPortraitTeam;
                playerTwoOffPortrait = playerTwoOffPortraitTeam;
                playerThreePortrait = playerThreePortraitTeam;
                playerThreeOffPortrait = playerThreeOffPortraitTeam;
                playerFourPortrait = playerFourPortraitTeam;
                playerFourOffPortrait = playerFourOffPortraitTeam;
                break;
        }
        if (join.activeSelf)
        {
            if (playerIndex == PlayerIndex.One)
            {
                prefabPortraitImage.sprite = playerOneOffPortrait;
            }
            else if (playerIndex == PlayerIndex.Two)
            {
                prefabPortraitImage.sprite = playerTwoOffPortrait;
            }
            else if (playerIndex == PlayerIndex.Three)
            {
                prefabPortraitImage.sprite = playerThreeOffPortrait;
            }
            else if (playerIndex == PlayerIndex.Four)
            {
                prefabPortraitImage.sprite = playerFourOffPortrait;
            }
            animator.SetBool("isJoined", true);
            Invoke("AnimationIn", 0.2f);

        }
        else
        {
            if (playerIndex == PlayerIndex.One)
            {
                prefabPortraitImage.sprite = playerOnePortrait;
            }
            else if (playerIndex == PlayerIndex.Two)
            {
                prefabPortraitImage.sprite = playerTwoPortrait;
            }
            else if (playerIndex == PlayerIndex.Three)
            {
                prefabPortraitImage.sprite = playerThreePortrait;
            }
            else if (playerIndex == PlayerIndex.Four)
            {
                prefabPortraitImage.sprite = playerFourPortrait;
            }
            animator.SetBool("isJoined", false);
            Invoke("AnimationOut", 0.2f);
        }
    }
    public void AnimationIn()
    {
        animator.SetBool("isJoined", false);
    }

    public void AnimationOut()
    {
        animator.SetBool("isJoined", true);
    }
}
