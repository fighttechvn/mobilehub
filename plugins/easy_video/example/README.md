# Easy video player

## Type 1: normal
```
  VideoPostWidget(
    video: ImageInfoData(
     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      null,
      null,
      'video',
    ),
    onlyPlayFullscreen: false,
    controlBarAvailable: false,
    autoPlay: false,
    aspecRatio: 2,
    playCenter: true,
    playColor: Colors.red,
  ),
```
## Type 2: center play button 

```
  VideoPostWidget(
    video: ImageInfoData(
       'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      null,
      null,
      'video',
    ),
    onlyPlayFullscreen: false,
    controlBarAvailable: false,
    aspecRatio: 2,
    playColor: Theme.of(context).colorScheme.secondary,
    playCenter: true,
  ),
```


## Type 3: simple play only
```
  const SizedBox(
    child: AspectRatio(
      aspectRatio: 1,
      child: VideoSocialWidget(
        url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      ),
    ),
  ),
```