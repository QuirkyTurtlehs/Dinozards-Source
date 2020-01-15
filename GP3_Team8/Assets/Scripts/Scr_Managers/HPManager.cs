using UnityEngine;
using UnityEngine.UI;

public class HPManager : MonoBehaviour
{
    public float maxHP = 100f;
    public float currentHP;
    public bool invencible;
    public float velocity;
    public float lerpVelocity;
    public float smoothTime;
    public float lerpSmoothTime;

    [Header("HP Bar UI"), Tooltip("Drag the character HP Bar UI object here.")]
    public Image healthBar;
    public Image healthBarFeedback;
    public Image healthBarHitFeedback;
    

    private GamePlayHandler gamePlayHandler;

    public Color whiteColor;
    public Color noColor;


    private bool hitBarLerping = false;
    private float lerpValue = 0.15f;
    private bool isDead = false;

    //Properties


    public float CurrentHP {

        get {return currentHP;}

        set
        {
            if (currentHP != value)
            {
                UpdateHitFeedBackBar();
            }
            currentHP = value;
            UpdateHPBar();


            if (currentHP <= 0 && !invencible) {
                currentHP = 0;
                OnPlayerDeath();
            }
        }
    }

    //Methods


    void Start()
    {
        CurrentHP = maxHP;
        gamePlayHandler = FindObjectOfType<GamePlayHandler>();
    }

    void Update()
    {
        UpdateFeedbackBar(); //Updates FeedbackBars Hit+SmoothDamage
    }

    private void UpdateFeedbackBar()
    {
        healthBarFeedback.fillAmount = Mathf.SmoothDamp(healthBarFeedback.fillAmount, healthBar.fillAmount, ref velocity, smoothTime);
        lerpValue -= Time.deltaTime;
        if (lerpValue < 0)
        {
            healthBarHitFeedback.color = noColor;
        }
    }

    //Update the UI HP Bar
    void UpdateHPBar()
    {
        healthBar.fillAmount = currentHP/maxHP;
    }

    void UpdateHitFeedBackBar()
    {
        healthBarHitFeedback.fillAmount = currentHP / maxHP;
        healthBarHitFeedback.color = whiteColor;
        lerpValue = 0.15f;

    }

    public void DecreaseHP(float value)
    {
        CurrentHP = (currentHP - value);
    }

    private void OnPlayerDeath() {

        if (!isDead)
        {
            isDead = true;

            if (gamePlayHandler != null)
            {

                int instigator = GetComponent<PlayerHit>().lastPlayerHittedIndex;
                gamePlayHandler.PlayerKilled(gameObject, instigator);
            }
        }
        //gameObject.SetActive(false);
    }

    private void OnEnable()
    {
        Start();
    }
}
