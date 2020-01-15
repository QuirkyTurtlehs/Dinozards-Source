using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XInputDotNetPure;
using UnityEngine.Assertions;



public class LavaGround : MonoBehaviour {

    private PlayerVibrator player1Vibrator;
    private PlayerVibrator player2Vibrator;
    private PlayerVibrator player3Vibrator;
    private PlayerVibrator player4Vibrator;
    public GameObject Player1;
    public GameObject Player2;
    public GameObject Player3;
    public GameObject Player4;
    public GameObject Planks;
    private Transform planksTransform;
    public ParticleSystem lavaPreShine;

    public bool callLavaPreShineDuringRaise;
    public float secondsBeforeRaiseToCallLavaPreShine;

    public bool callLavaPreShineAfterRaise;

    private MultipleTargetCamera camera;

    public float lavaYPositionToRaiseItTo = 0;

    public float lavaRaiseDuration = 0;

    public float cameraShakeDuration = 0.1f;

    public float cameraShakeIntensity = 0.015f;

    public float vibrationIntenstiy = 1;

    public float planksYPositionToLowerItTo = 0;

    public float planksLowerDuration = 0;

    //-------------------------------------
    private void OnEnable()
    {
        StormBehavior.LavaActivatedInfo += Shaker;
    }

    private void OnDisable()
    {
        StormBehavior.LavaActivatedInfo -= Shaker;
    }

    private void Start() {

        if (Player1.activeSelf)
        {
        player1Vibrator = Player1.GetComponent<PlayerVibrator>();
        Assert.IsNotNull(player1Vibrator, "PlayerVibrator1 was not found.");
        }

        if (Player2.activeSelf)
        {
            player2Vibrator = Player2.GetComponent<PlayerVibrator>();
            Assert.IsNotNull(player2Vibrator, "PlayerVibrator2 was not found.");
        }

        if (Player3.activeSelf)
        {
            player3Vibrator = Player3.GetComponent<PlayerVibrator>();
            Assert.IsNotNull(player3Vibrator, "PlayerVibrator3 was not found.");
        }

        if (Player4.activeSelf)
        {
            player4Vibrator = Player4.GetComponent<PlayerVibrator>();
            Assert.IsNotNull(player4Vibrator, "PlayerVibrator4 was not found.");
        }

        planksTransform = Planks.GetComponent<Transform>();

        // Raises The Lava with a certain duration to a Y Position
        StartCoroutine(LavaRising(lavaRaiseDuration, lavaYPositionToRaiseItTo));

        camera = GameObject.FindWithTag("Camera").GetComponent<MultipleTargetCamera>();
    }

    IEnumerator LavaRising(float duration, float YPosition) {

        float counter = 0;

        float initialYPos = gameObject.transform.position.y;

        float newYPos;

        float lerp = 0;

        bool lavaPreShineFirstPhase = false;

        // Vibrates with a certain duration and intensity
        if (Player1.activeSelf)
        {
            player1Vibrator.Vibrate(duration, vibrationIntenstiy, 0);
        }

        if (Player2.activeSelf)
        {
            player2Vibrator.Vibrate(duration, vibrationIntenstiy, 0);
        }

        if (Player3.activeSelf)
        {
            player3Vibrator.Vibrate(duration, vibrationIntenstiy, 0);
        }

        if (Player4.activeSelf)
        {
            player4Vibrator.Vibrate(duration, vibrationIntenstiy, 0);
        }

        while (counter <= duration) {

            counter += Time.deltaTime;
            
            // Depending on counter and duration it makes it so lerp goes from 0 - 1 with the time it takes for counter to reach duration
            lerp = counter / duration;

            // Lerps the value from the starting pos to the target Y
            newYPos = Mathf.Lerp(initialYPos, YPosition, lerp);

            // Moves the lavas position to new
            gameObject.transform.position = new Vector3(gameObject.transform.position.x, newYPos, gameObject.transform.position.z);

            if (callLavaPreShineDuringRaise) {

                if (counter >= (duration - secondsBeforeRaiseToCallLavaPreShine) && !lavaPreShineFirstPhase) {

                    lavaPreShineFirstPhase = true;

                    lavaPreShine.Play(true);
                }
            }

                


            yield return null;
        }

        if (callLavaPreShineAfterRaise)
           lavaPreShine.Play(true);

        if (Player1.activeSelf)
        {
            player1Vibrator.Vibrate(1, 0, 0);
        }

        if (Player2.activeSelf)
        {
            player2Vibrator.Vibrate(1, 0, 0);
        }

        if (Player3.activeSelf)
        {
            player3Vibrator.Vibrate(1, 0, 0);
        }

        if (Player4.activeSelf)
        {
            player4Vibrator.Vibrate(1, 0, 0);
        }

        PlanksLowering(planksLowerDuration, planksYPositionToLowerItTo);

        StartCoroutine(PlanksLowering(planksLowerDuration, planksYPositionToLowerItTo));

        yield return null;
    }

    //PlankStuff (Should probs be moved to another place later)
    IEnumerator PlanksLowering(float duration, float YPosition)
    {

        float counter = 0;

        float initialYPos = planksTransform.position.y;

        float newYPos;

        float lerp = 0;

        while (counter <= duration)
        {

            counter += Time.deltaTime;

            // Depending on counter and duration it makes it so lerp goes from 0 - 1 with the time it takes for counter to reach duration
            lerp = counter / duration;

            // Lerps the value from the starting pos to the target Y
            newYPos = Mathf.Lerp(initialYPos, YPosition, lerp);

            // Moves the lavas position to new
            planksTransform.position = new Vector3(planksTransform.position.x, newYPos, planksTransform.position.z);

            yield return null;
        }

        yield return null;
    }

    void Shaker()
    {
        // Shakes the camera for the duration and intensity
        camera.ShakeCamera(cameraShakeDuration, cameraShakeIntensity);
    }
}
