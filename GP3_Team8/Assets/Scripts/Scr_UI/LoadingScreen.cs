using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LoadingScreen : MonoBehaviour
{
    public Image hintText;
    public List<Sprite> hintTextList;

    // Start is called before the first frame update
    void Start()
    {
        int index;
        index = Random.Range(0, hintTextList.Count);
        hintText.sprite = hintTextList[index];
    }

    void LoadGameplayScene()
    {
        GameManager.managerInstance.LoadScene(3);
    }

}
