import 'package:easy_video/easy_video.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Easy video'),
    );
  }
}

const url =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              VideoPostWidget(
                video: ImageInfoData(
                  url,
                  null,
                  null,
                  'video',
                ),
                onlyPlayFullscreen: false,
                controlBarAvailable: false,
                autoPlay: false,
                aspecRatio: 2,
                playCenter: true,
              ),
              const SizedBox(height: 10),
              VideoPostWidget(
                video: ImageInfoData(
                  url,
                  null,
                  null,
                  'video',
                ),
                onlyPlayFullscreen: false,
                playCenter: false,
                controlBarAvailable: false,
                autoPlay: false,
                aspecRatio: 2,
              ),
              const SizedBox(height: 10),
              const SizedBox(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: VideoSocialWidget(url: url),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.startVideoDetail(url: url);
        },
        tooltip: 'Video',
        child: const Icon(Icons.play_circle_fill_outlined),
      ),
    );
  }
}
