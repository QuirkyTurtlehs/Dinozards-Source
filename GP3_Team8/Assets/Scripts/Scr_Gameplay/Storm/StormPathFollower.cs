using PathCreation;
using System.Collections.Generic;
using UnityEngine;

public class StormPathFollower : MonoBehaviour
{
    [SerializeField]
    private List<PathCreator> pathCreatorList;

    private float speed;

    [SerializeField]
    private bool alignRotation = false;

    private StormBehavior stormInstance;

    [SerializeField]
    private PathCreator pathCreator;

    public float distanceTraveled;

    public void SetPath()
    {
        int myInt = Random.Range(0, pathCreatorList.Count);
        pathCreator = pathCreatorList[myInt];
    }

    private void Awake()
    {
        stormInstance = FindObjectOfType<StormBehavior>();
        speed = stormInstance.stormSpeed;
    }

    private void Update()
    {
        if (stormInstance.isMoving)
            distanceTraveled += speed * Time.deltaTime;

        transform.position = pathCreator.path.GetPointAtDistance(distanceTraveled); //Follows the path

        if (alignRotation)
        {
            transform.rotation = pathCreator.path.GetRotationAtDistance(distanceTraveled); //Rotates toward the path
        }
    }
}
