using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerDissolve : MonoBehaviour
{
    private Material currentMaterial;
    public float lerpTime = 0.2f;

    private float burnAmount = 0;
    private bool canDissolve = false;
    private float safetyTimer = 0;

    public void OnPlayerDeath()
    {
        currentMaterial = GetComponentInChildren<SkinnedMeshRenderer>().material;

        safetyTimer = GetComponent<PlayerStates>().timeAfterDiedUntilFallThroughGround;
        currentMaterial.SetFloat("_DeathAnimation", 1);
        currentMaterial.SetFloat("_Burn", 0);

        Debug.Log(currentMaterial);

        canDissolve = true;
    }

    private void Update()
    {
        if (canDissolve)
        {
            DissolvePlayer();
            safetyTimer -= Time.deltaTime;
        }

    }

    private void DissolvePlayer()
    {
        burnAmount = Mathf.Lerp(burnAmount, 1.1f, lerpTime);
        currentMaterial.SetFloat("_Burn", burnAmount);
        lerpTime += Time.deltaTime * 0.1f;
    }
}
