using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using XInputDotNetPure;

public class PlayerDirectionalRingColor : MonoBehaviour
{

    public Color player01Color;
    public Color player02Color;
    public Color player03Color;
    public Color player04Color;
    public SpriteRenderer spriteRenderer;

    // Start is called before the first frame update
    void Start()
    {
                PlayerStates playerStates = GetComponentInParent<PlayerStates>();

                if (playerStates.inTeam == PlayerStates.Team.Team1)
                {
                    spriteRenderer.color = player01Color;
                }
                else if (playerStates.inTeam == PlayerStates.Team.Team2)
                {
                    spriteRenderer.color = player02Color;
                }
                else if (playerStates.inTeam == PlayerStates.Team.Team3)
                {
                    spriteRenderer.color = player03Color;
                }
                else if (playerStates.inTeam == PlayerStates.Team.Team4)
                {
                    spriteRenderer.color = player04Color;
                }
    }


}
