using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public class PostProcessBehaviour : MonoBehaviour
{
    public float maxTemperature;
    public float minTemperature;
    public float lavaDelay = 2f;

    private float targetTemp;

    private float smoothTime;

    public float defaultSmoothTime = 0.005f;

    private bool increaseTemp = false;
    private bool decreaseTemp = false;

    private bool lavaActive = false;
    private bool stormActive = false;

    private float currentTemp = 0;
    private float offset = 5f;

    private PostProcessVolume volume;

    private ColorGrading grading = null;

    private void Start()
    {
        volume = GetComponent<PostProcessVolume>();
        volume.profile.TryGetSettings(out grading);

        StormBehavior.LavaActivatedInfo += OnLavaActivated;
        StormBehavior.StormActivatedInfo += OnStormActive;
        smoothTime = defaultSmoothTime;
    }

    public void OnLavaActivated()
    {
        StartCoroutine(WaitForLava());
    }
    public void OnStormActive()
    {
        decreaseTemp = true;
        stormActive = true;
        targetTemp = minTemperature;
        //Debug.Log("Storm");
    }

    private IEnumerator WaitForLava()
    {
        yield return new WaitForSeconds(lavaDelay);

        increaseTemp = true;
        lavaActive = true;
        targetTemp = maxTemperature;
        //Debug.Log("Lava");

        yield return null;
    }

    private void IncreaseTemperature()
    {
        currentTemp = Mathf.Lerp(currentTemp, targetTemp, smoothTime);
        grading.temperature.value = currentTemp;
        smoothTime += Time.deltaTime * 0.1f;

        //Debug.Log("increase " + grading.temperature.value);
        if (Mathf.Approximately(grading.temperature.value, targetTemp))
        {
            increaseTemp = false;
            targetTemp = 0;
            smoothTime = defaultSmoothTime;
            decreaseTemp = true;

        }
    }

    private void DecreaseTemperature()
    {
        currentTemp = Mathf.Lerp(currentTemp, targetTemp, smoothTime);
        grading.temperature.value = currentTemp;

        smoothTime += Time.deltaTime * 0.05f;

        //Debug.Log("Decrease " + grading.temperature.value);
        if (Mathf.Approximately(grading.temperature.value, targetTemp))
        {
            decreaseTemp = false;
            smoothTime = defaultSmoothTime;
            if (stormActive)
            {
                increaseTemp = true;               
                targetTemp = 0;

            }
        }
    }

    private void Update()
    {
        if (increaseTemp)
        {
            IncreaseTemperature();
        }
        if (decreaseTemp)
        {
            DecreaseTemperature();
        }
    }
}
