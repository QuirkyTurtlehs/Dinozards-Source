using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lightning : MonoBehaviour
{

    public GameObject strike1;
    public GameObject strike2;
    public GameObject strike3;
    public GameObject strike4;
    public GameObject strike5;


    public void PlayStrike1()
        {
        strike1.SetActive(true);
        }

    public void PlayStrike2()
    {
        strike2.SetActive(true);
    }

    public void PlayStrike3()
    {
        strike3.SetActive(true);
    }

    public void PlayStrike4()
    {
        strike4.SetActive(true);
    }

    public void PlayStrike5()
    {
        strike5.SetActive(true);
    }

    public void DeactivatePlayer()
    {
        gameObject.SetActive(false);
    }
}
