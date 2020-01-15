using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RagdollTest : MonoBehaviour
{


    public Vector3 direction = new Vector3(1, 1, 1);

    public float forceAmount = 200;

    public float knockback = 6;

    public GameObject kid;

    // Start is called before the first frame update
    void Start()
    {
        

        // rb.WakeUp();
        Invoke("walla", .1f);
        
    }

    void walla() {

        // Rigidbody rbd = gameObject.GetComponent<Rigidbody>();

        //rbd.AddForce(direction * forceAmount * knockback);

        
        Rigidbody[] childrenUnderRagdoll;

          childrenUnderRagdoll = gameObject.GetComponentsInChildren<Rigidbody>();

          foreach (Rigidbody rb in childrenUnderRagdoll) {

            rb.AddForce(direction * forceAmount * knockback);
          }
    }

    void Update() {


        Debug.Log(kid.transform.position);

        gameObject.transform.position = kid.transform.position;
    }
}
