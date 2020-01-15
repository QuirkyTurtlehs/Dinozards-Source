using System.Collections.Generic;
using UnityEngine;

public class StormBehavior : MonoBehaviour
{
    private static StormBehavior instance;

    private Transform circleTransform;

    private Vector3 circleCurrentSize;

    private Vector3 circleCurrentPosition;

    private bool isStormFollowingPath;

    private float shrinkingSpeed;

    private StormPathFollower stormFollower;

    private int listIndex;

    private bool doneBroadcasting = false;

    [HideInInspector]
    public bool isShrinking = false;

    [SerializeField, Header("Storm Visual Reference")]
    private bool showVisualReference = true;

    [HideInInspector]
    public float stormCurrentRadius;

    [SerializeField]
    private GameObject stormVR;

    [SerializeField]
    private GameObject stormCenter;

    [SerializeField]
    private GameObject stormStencil;

    [SerializeField]
    private GameObject stormTop;

    [SerializeField]
    private GameObject stormBottom;

    [SerializeField]
    private GameObject stormRight;

    [SerializeField]
    private GameObject stormLeft;

    [SerializeField, Header("Rain")]
    private GameObject rain;

    [SerializeField]
    private GameObject lightning;

    [SerializeField]
    private GameObject lightningScreen;

    [Space]

    [Header("Storm General")]
    [SerializeField, Tooltip("How many seconds to enable the storm.")]
    private float stormStartTimer = 0f;

    [SerializeField]
    private float stormTargetRadius = 25f;

    public float stormInitialRadius = 25f;

    [SerializeField]
    private float minimumRadius = 5f;

    [SerializeField]
    private float newTargetRadius = 50f;

    [Range(0f,10f)]
    public float stormSpeed = 2f;

    [SerializeField]
    private float movementStopInterval;

    [SerializeField, Tooltip("This will only be used if the intervals list is empty. The higher this value, fast will be.")]
    private float defautShrinkingSpeed = 3f;

    [SerializeField]
    private float stormHeight = 10f;

    [SerializeField]
    private List<string> wizardLaughsAudioNames;

    [HideInInspector]
    public bool enableDamage;

    [Space]

    [Header("Storm Damage")]
    public float stormDamageValue = 0.1f;

    [Space]

    [SerializeField, Header("Shrinking Intervals")]
    private IntervalRangeClass[] shrinkIntervals;

    [SerializeField]
    private LavaGround lavaGround;

    [SerializeField]
    private float timeToRaiseLava = 3f;

    public bool isMoving;

    public delegate void LavaActivated();

    public static event LavaActivated LavaActivatedInfo;

    public delegate void StormActivated();

    public static event StormActivated StormActivatedInfo;

    [Range(0.1f, 5f)]
    public float timerDuration = 1f;

    private void Awake()
    {
        instance = this;
        stormFollower = FindObjectOfType<StormPathFollower>();
    }

    private void Start()
    {      
        stormFollower.SetPath();
        circleTransform = transform;
        stormCurrentRadius = stormInitialRadius;
        circleCurrentSize = new Vector3(stormCurrentRadius, stormCurrentRadius, stormCurrentRadius);
        newTargetRadius = stormInitialRadius;
        listIndex = 0;
        stormVR.SetActive(showVisualReference);
        Invoke("StartStorm", stormStartTimer);
    }

    private void StartStorm()
    {
        enableDamage = true;
        StartShrinkInterval();
        FindObjectOfType<GamePlayUI>().ShowWizardWarning01();
        if (movementStopInterval != 0)
        {
            Invoke("ToggleMoving", movementStopInterval);
        }
    }

    private void Update()
    {      
        SetCircleSizeAndPosition(circleCurrentSize);
        StormShrinking(newTargetRadius, shrinkingSpeed);
        if (isShrinking && stormCurrentRadius - newTargetRadius < 0.01)
        {
            isShrinking = false;
            NextShrinkInterval();
        }
        if (!doneBroadcasting && stormCurrentRadius <= 35)
        {
            doneBroadcasting = true;
        }

    }

    private void SetCircleSizeAndPosition(Vector3 size) 
    {
        circleTransform.localScale = size;
    }

    private bool IsOutsideCircle(Vector3 position)
    {
        return Vector3.Distance(position, transform.position) > circleCurrentSize.x * .5f;
    }

    public static bool IsOutsideCircle_Static(Vector3 position)
    {
        return instance.IsOutsideCircle(position);
    }


    //Lerp the Storm Radius circle values
    private void StormShrinking(float targetSize, float speed)
    {
        if (stormCurrentRadius != targetSize)
        {
            stormCurrentRadius = Mathf.Lerp(stormCurrentRadius, targetSize, Time.deltaTime * speed/10);
            circleCurrentSize = new Vector3(stormCurrentRadius, stormCurrentRadius, stormHeight);
        }
    }

    private void ToggleMoving()
    {
        if (isMoving)
        {
            isMoving = false;
            Invoke("ToggleMoving", movementStopInterval);
        }
        else
        {
            isMoving = true;
            Invoke("ToggleMoving", movementStopInterval);
        }
    }

    private void StartShrinkInterval()
    {
        if (shrinkIntervals.Length != 0) //Use the list parameters
        {
            float intervalTimer;
            intervalTimer = shrinkIntervals[listIndex].preCounter;
            Invoke("ShrinkInterval", intervalTimer);
        }
    }

    private void ShrinkInterval()
    {
        shrinkingSpeed = shrinkIntervals[listIndex].shrinkSpeed;
        newTargetRadius = stormCurrentRadius - shrinkIntervals[listIndex].units;
        isShrinking = true;
        isMoving = shrinkIntervals[listIndex].moveStorm;

        if (shrinkIntervals[listIndex].raiseLava)
        {
            Invoke("EnableLava", timeToRaiseLava);
            int listIndex = Random.Range(0, wizardLaughsAudioNames.Count);

            AudioManager.instance.Play(wizardLaughsAudioNames[listIndex]);
        }

        if (shrinkIntervals[listIndex].thunderWeak)
        {
            lightningScreen.SetActive(true);

            AudioManager.instance.Play("Thunderstorm_02");
        }

        if (shrinkIntervals[listIndex].thunderStrong)
        {
            FindObjectOfType<GamePlayUI>().ShowWizardWarning02();
            int listIndex = Random.Range(0, wizardLaughsAudioNames.Count);
            rain.SetActive(true);
            lightning.SetActive(true);
            lightningScreen.SetActive(true);

            AudioManager.instance.Play(wizardLaughsAudioNames[listIndex]);
            AudioManager.instance.Play("Thunderstorm_01");
            AudioManager.instance.Play("ThunderstormAmbience_01");
            AudioManager.instance.Play("Rain_01");
        }
    }

    private void EnableLava()
    {
        lavaGround.enabled = true;
        DamagingZoneBehaviour.EnableZone();

        AudioManager.instance.Play("LavaRaising_01");
    }

    private void NextShrinkInterval()
    {
        if (stormCurrentRadius >= minimumRadius)
        {
            listIndex++;
            StartShrinkInterval();
        }
    }

    public void RestartStorm()
    {
        stormFollower.distanceTraveled = 0f;

        Start();
    }

    public void StopStorm()
    {
        enableDamage = false;
        isMoving = false;
        isShrinking = false;

        AudioManager.instance.Stop("ThunderstormAmbience_01");
        AudioManager.instance.Stop("Rain_01");
    }
}
