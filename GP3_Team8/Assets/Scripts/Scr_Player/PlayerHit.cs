using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XInputDotNetPure;

public class PlayerHit : MonoBehaviour {
    #region Fields

    public enum HitBy { FireBall, FireBallMerge, Dash, Reflect, Storm, Lava, Tick};

    GamePadState state;
    public PlayerIndex playerIndex;
    public int lastPlayerHittedIndex = 0; 

    private MultipleTargetCamera cameraShake;
    private MultipleTargetCamera camera;

    private HPManager playerHp;
    private PlayerStates states;
    private Rigidbody rigidbody;

    private Vector3 direction;

    //Knock back
    public float forceAmount;
    private float knockbackMultiplier;
    
    public float delayBeforeReturningToNormalStateAfterHit = 0.5f;

    private bool isVibrating = false;

    //tick damage
    private float tickDamageTimer = 0.5f;
    public float tickDamageRate = 1;

    private bool tickDamageIsEnabled = false;
    private float tickDamage = 0;

    private float dashLightningTickDamageDivider = 3;
    private float dashLightningTickIntervalls = .5f;

    public GameObject ragdoll;
    public float deadKnockbackMultiplier = 1.5f;
    
    private PlayerVibrator playerVibrator;

    [SerializeField]
    private ParticleSystem fireBallDotVFX;

    [SerializeField]
    private ParticleSystem lavaDotFX;

    [SerializeField]
    private ParticleSystem reflectDotVFX;

    [SerializeField]
    private ParticleSystem stormDotVFX;

    public List<string> hitAudioNames;

    #endregion Fields

    private void Start()
    {
        playerVibrator = gameObject.GetComponent<PlayerVibrator>();
        playerHp = GetComponent<HPManager>();
        rigidbody = GetComponent<Rigidbody>();
        states = GetComponent<PlayerStates>();

        camera = GameObject.FindWithTag("Camera").GetComponent<MultipleTargetCamera>();
    }

    //------------------------------------------

    private void OnDisable() {

         GamePad.SetVibration(playerIndex, 0f, 0f);
    }
    
    //------------------------------------------

    private void Update() {
        if (tickDamageIsEnabled)
        {
            TickDamage();
        }
    }

    //------------------------------------------

    private void TickDamage() {

        if (tickDamageTimer <= 0.0f)
        {
            OnPlayerHit(Vector3.zero, 1.0f, tickDamage, 0, 0, PlayerHit.HitBy.Lava, 0.2f, 0, 1);
            tickDamageTimer = tickDamageRate;
        }
        else
        {
            tickDamageTimer -= Time.deltaTime;
        }
    }

    //---------------------------------------------

    public void EnableTickDamage(float damageAmount)
    {
        tickDamage = damageAmount;
        tickDamageIsEnabled = true;
    }

    //---------------------------------------------

    public void DisableTickDamage()
    {
        tickDamageIsEnabled = false;
    }

    //---------------------------------------------

    // Called by an ability when it hits the player. 
    public void OnPlayerHit(Vector3 hitDirection, float multiplier, float damage, float cameraShakeDuration, float cameraShakeIntensity, HitBy hitBy, float vibTime, float vibA, float vibB, int instigatorPlayerIndex = 0) {
        

        // Does damage only if not dead
        if (!states.IsState(PlayerStates.PossibleStates.IsDead)) {

            playerHp.DecreaseHP(damage);
            
            int listIndex = Random.Range(0, hitAudioNames.Count);
            AudioManager.instance.PlayWithRandomPitch(hitAudioNames[listIndex]);

            if (instigatorPlayerIndex != 0)
            {
                lastPlayerHittedIndex = instigatorPlayerIndex;
            }

        }

        switch(hitBy) {

            case HitBy.FireBall:
                fireBallDotVFX.Play(true);

                break;

            case HitBy.Lava:
                lavaDotFX.Play(true);

                break;
            case HitBy.Reflect:
                reflectDotVFX.Play(true);

                break;
            case HitBy.Storm:
                stormDotVFX.Play(true);

                break;
        }

        playerVibrator.Vibrate(vibTime, vibA, vibB);

        // Knocks away player and shakes camera if not hit by storm or tick and is not dead
        if (hitBy != HitBy.Storm || hitBy != HitBy.Tick) {
            
            direction = hitDirection;
            knockbackMultiplier = multiplier;

            camera.ShakeCamera(cameraShakeDuration, cameraShakeIntensity);
            ApplyKnockback(direction, forceAmount, multiplier);

            if (!states.IsState(PlayerStates.PossibleStates.IsDead) && !states.IsState(PlayerStates.PossibleStates.IsWinning)) {
                states.SetStateTo(PlayerStates.PossibleStates.GotHit);
                StartCoroutine(RestoredFromHit());
            }

        }
        
        // If hit by dash and isnt dead then does lightning tick dmg
        if (hitBy == HitBy.Dash && !states.IsState(PlayerStates.PossibleStates.IsDead)) 
            StartCoroutine(LightningDamageTick(damage));

    }

    //---------------------------------------------

    private IEnumerator LightningDamageTick(float damage) {

        float tickDamage = damage / dashLightningTickDamageDivider;

        yield return new WaitForSeconds(dashLightningTickIntervalls);

        OnPlayerHit(new Vector3(0,0,0), 0, tickDamage, 0, 0, HitBy.Tick, 0, 0, 0);

        yield return new WaitForSeconds(dashLightningTickIntervalls);

        OnPlayerHit(new Vector3(0, 0, 0), 0, tickDamage, 0, 0, HitBy.Tick, 0, 0, 0);
        
        yield return null;
    }


    //---------------------------------------------

    private void ApplyKnockback(Vector3 direction, float force, float multiplier) {
        
        if (!states.IsState(PlayerStates.PossibleStates.IsDead)) {

            direction.Normalize();

            rigidbody.AddForce(direction * force * multiplier);
        }

        else {

            ragdoll.transform.parent = null;

            Rigidbody[] childrenUnderRagdoll;

            childrenUnderRagdoll = ragdoll.GetComponentsInChildren<Rigidbody>();

            foreach (Rigidbody rb in childrenUnderRagdoll) {

                rb.AddForce(direction * forceAmount * multiplier * deadKnockbackMultiplier);
            }
            
        }
    }

    //---------------------------------------------

    private IEnumerator RestoredFromHit() {

        yield return new WaitForSeconds(delayBeforeReturningToNormalStateAfterHit);
        
        if (!states.IsState(PlayerStates.PossibleStates.IsDead) && !states.IsState(PlayerStates.PossibleStates.IsWinning)) {
            
            states.SetStateTo(PlayerStates.PossibleStates.IsNormal);
        }

        yield return null;
    }
}
