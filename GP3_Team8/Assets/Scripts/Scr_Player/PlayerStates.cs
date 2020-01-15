using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XInputDotNetPure;

public class PlayerStates : MonoBehaviour
{
    #region Fields

    private Animator animator;

    public enum Team { Team1, Team2, Team3, Team4 };

    public Team inTeam;

    public PlayerInput playerInput;

    public enum PossibleStates { IsNormal, IsDashing, IsReflecting, IsShooting, GotHit, GotStunned, IsDead, IsWinning};

    public PossibleStates currentState = PossibleStates.IsNormal;

    public GameObject ragDollSkinnedMeshRef;

    public GameObject HP_BarTurnofFWhenDead;
    public GameObject DirectionalRingTurnOffWhenDead;
    public GameObject walkSmokeClouds;

    public float timeAfterDiedUntilFallThroughGround = 2f;

    #endregion Fields

    private void Awake()
    {

    }

    private void Start() {

        SetPlayerTeam();
        animator = GetComponent<Animator>();
        SetStateTo(PossibleStates.IsNormal);
    }

    private void OnEnable()
    {
        animator = GetComponent<Animator>();
        SetStateTo(PossibleStates.IsNormal);
    }
    //---------------------------------------------------
    // Returns if it is certain state

    public bool IsState(PossibleStates stateToCheck) {

        return animator.GetBool(stateToCheck.ToString());
    }

    //---------------------------------------------------
    // Returns Current State Enum. 

    public PossibleStates GetCurrentState()
    {
        return currentState;
    }

    //---------------------------------------------------
    // Sets State and Animator Controller bool true and the rest of the bools to false

    public void SetStateTo(PossibleStates stateToSet) {
        
        for (int i = 0; i < animator.parameterCount; i++) {

            if (animator.GetParameter(i).name == stateToSet.ToString()) {

                animator.SetBool(stateToSet.ToString(), true);
                currentState = stateToSet;
            }

            else {
                
                // If it is a Bool then sets it to false. So it doesn't try to set the Speed Variable
                if (animator.GetParameter(i).type == AnimatorControllerParameterType.Bool) {

                         animator.SetBool(animator.GetParameter(i).name, false);
                 }
            }
        }

        if (stateToSet == PossibleStates.IsDead)
            StartCoroutine(SetRagDollMode());

    }

    private IEnumerator SetRagDollMode() {

        HP_BarTurnofFWhenDead.SetActive(false);
        DirectionalRingTurnOffWhenDead.SetActive(false);
        walkSmokeClouds.SetActive(false);
        GetComponent<Animator>().enabled = false;
        GetComponent<CapsuleCollider>().enabled = false;

        Rigidbody[] childrenUnderRagdoll;
        BoxCollider[] collidersUnderRagdoll;
        CapsuleCollider[] capsCollUnderRagDoll;
        SphereCollider[] sphereCollUnderRagDoll;

        // GetComponent<PlayerDissolve>().OnPlayerDeath();

        childrenUnderRagdoll = ragDollSkinnedMeshRef.GetComponentsInChildren<Rigidbody>();
        collidersUnderRagdoll = ragDollSkinnedMeshRef.GetComponentsInChildren<BoxCollider>();
        capsCollUnderRagDoll = ragDollSkinnedMeshRef.GetComponentsInChildren<CapsuleCollider>();
        sphereCollUnderRagDoll = ragDollSkinnedMeshRef.GetComponentsInChildren<SphereCollider>();

        // Sets all rigidbody children
        foreach (Rigidbody rb in childrenUnderRagdoll) {
            
            rb.isKinematic = false;
        }

        foreach (BoxCollider coll in collidersUnderRagdoll) {

             coll.enabled = true;
        }

        foreach (CapsuleCollider coll in capsCollUnderRagDoll) {

            coll.enabled = true;
        }

        foreach (SphereCollider coll in sphereCollUnderRagDoll) {

            coll.enabled = true;
        }

        // After a delay the body falls through the ground. This doesnt need to happen if we can get the dissolve in, then we can just disable the player after its done
        yield return new WaitForSeconds(timeAfterDiedUntilFallThroughGround);


        foreach (BoxCollider coll in collidersUnderRagdoll) {

            coll.enabled = false;
        }

        foreach (CapsuleCollider coll in capsCollUnderRagDoll) {

            coll.enabled = false;
        }

        foreach (SphereCollider coll in sphereCollUnderRagDoll) {

            coll.enabled = false;
        }

        // After fallen through ground then disables entire actor
        yield return new WaitForSeconds(1);

        gameObject.SetActive(false);

        yield return null;
    }

    public void SetPlayerTeam()
    {
        switch (GameManager.managerInstance.teamMode)
        {
            case GameManager.eTeamMode.SOLO:

                if (playerInput.playerIndex == PlayerIndex.One)
                {
                    inTeam = Team.Team1;
                }
                else if (playerInput.playerIndex == PlayerIndex.Two)
                {
                    inTeam = Team.Team2;
                }
                else if (playerInput.playerIndex == PlayerIndex.Three)
                {
                    inTeam = Team.Team3;
                }
                else if (playerInput.playerIndex == PlayerIndex.Four)
                {
                    inTeam = Team.Team4;
                }
                break;
            case GameManager.eTeamMode.DOUBLES:


                if (playerInput.playerIndex == PlayerIndex.One)
                {
                    inTeam = Team.Team1;
                }
                else if (playerInput.playerIndex == PlayerIndex.Two)
                {
                    inTeam = Team.Team1;
                }
                else if (playerInput.playerIndex == PlayerIndex.Three)
                {
                    inTeam = Team.Team2;
                }
                else if (playerInput.playerIndex == PlayerIndex.Four)
                {
                    inTeam = Team.Team2;
                }
                break;
        }
    }
}
