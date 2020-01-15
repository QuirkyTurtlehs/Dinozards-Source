using UnityEngine;
using System;

public class AudioManager : MonoBehaviour
{

    public Sound[] singleSounds;

    public static AudioManager instance;

    void Awake()
    {

        if (instance == null)
        {
            instance = this;
        }
        else
        {
            Destroy(gameObject);
            return;
        }

        DontDestroyOnLoad(gameObject);

        foreach (Sound s in singleSounds)
        {
            s.source = gameObject.AddComponent<AudioSource>();
            s.source.clip = s.clip;

            s.source.volume = s.volume;
            s.source.pitch = s.pitch;
            s.source.loop = s.loop;
        }
    }


    public void Play(string name)
    {
        Sound s = Array.Find(singleSounds, sound => sound.name == name);
        if (s == null)
        {
            Debug.LogWarning("Sound: " + name + " not found! Miss typo?");
            return;
        }
        s.source.Play();
    }

    public void PlayWithPitch(string name, float newPitch)
    {
        Sound s = Array.Find(singleSounds, sound => sound.name == name);
        if (s == null)
        {
            Debug.LogWarning("Sound: " + name + " is missing");
            return;
        }
        s.source.pitch = Mathf.Lerp(1f, 2f, (newPitch / 10));
        s.source.Play();

    }

    public void PlayWithRandomPitch(string name)
    {
        Sound s = Array.Find(singleSounds, sound => sound.name == name);
        if (s == null)
        {
            Debug.LogWarning("Sound: " + name + " is missing");
            return;
        }
        s.source.pitch = UnityEngine.Random.Range(0.75f, 2f);
        s.source.Play();

    }

    public void SetPitch(string name, float newPitch)
    {
        Sound s = Array.Find(singleSounds, sound => sound.name == name);
        if (s == null)
        {
            Debug.LogWarning("Sound: " + name + " is missing");
            return;
        }
        s.source.pitch = newPitch;
        //Debug.Log(newPitch);
    }

    public void Stop(string name)
    {
        Sound s = Array.Find(singleSounds, sound => sound.name == name);
        if (s == null)
        {
            Debug.LogWarning("Sound: " + name + " is missing");
            return;
        }
        s.source.Stop();
    }
}
