using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XInputDotNetPure;


public class PlayerVibrator : MonoBehaviour {

    public PlayerIndex playerIndex;
    bool vibrating;

    //----------------------------------------------

    public void Vibrate(float vibrationDuration, float vibrationIntensityA, float vibrationIntensityB) {
        
        if (!vibrating) {

            GamePad.SetVibration(playerIndex, vibrationIntensityA, vibrationIntensityB);

            StartCoroutine(VibrationDuration(vibrationDuration));
        }
    }

    //----------------------------------------------

    IEnumerator VibrationDuration(float duration) {

        vibrating = true;

        yield return new WaitForSeconds(duration);

        vibrating = false;

        GamePad.SetVibration(playerIndex, 0f, 0f);
    }
}
