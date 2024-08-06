import 'package:easy_file_preview/easy_file_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'easy_file_preview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 200,
                child: ImageGalleryWidget(
                  images: [
                    'https://images.unsplash.com/photo-1682685797769-481b48222adf?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    'https://images.unsplash.com/photo-1674822858255-fcc093a1ef43?q=80&w=1335&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    'https://media.istockphoto.com/id/1020501838/vi/anh/c%E1%BA%A3nh-quan-%C4%91%C3%B4-th%E1%BB%8B-t%E1%BA%A1i-kyoto-nh%E1%BA%ADt-b%E1%BA%A3n.jpg?s=1024x1024&w=is&k=20&c=BCLKlM8jpzeL_PhWP8JawsTDdu6_i0ySx3716o6Tcq0=',
                  ],
                ),
              ),
              const MediaPreviewWidget(
                minHeightPdf: 200,
                type: '.mp4',
                url:
                    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                title: 'video MP',
                pdfFullScreen: true,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: const AspectRatio(
                  aspectRatio: 1,
                  child: VideoSocialWidget(
                    url:
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.startVideoDetail(
                        url:
                            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                      );
                    },
                    child: const Text('Video'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.viewFile(
                        url:
                            'https://github.com/LiWenHui96/flutter_file_view/raw/master/example/assets/files/FileTest.ppt?raw=true',
                        title: 'title',
                      );
                    },
                    child: const Text('View ppt'),
                  ),
                ],
              ),
              const SizedBox(
                height: 200,
                child: MediaPreviewWidget(
                  type: '.pdf',
                  url: 'https://pdfkit.org/docs/guide.pdf',
                  title: 'View PDF',
                  pdfFullScreen: true,
                ),
              ),
              const SizedBox(
                height: 200,
                child: MediaPreviewWidget(
                  minHeightPdf: 200,
                  type: '.docx',
                  url:
                      'https://github.com/LiWenHui96/flutter_file_view/raw/master/example/assets/files/FileTest.docx?raw=true',
                  title: 'View docx',
                  pdfFullScreen: true,
                ),
              ),
              const SizedBox(
                height: 300,
                child: MediaPreviewWidget(
                  minHeightPdf: 200,
                  type: '.xls',
                  url:
                      'https://github.com/LiWenHui96/flutter_file_view/raw/master/example/assets/files/FileTest.xls?raw=true',
                  title: 'View docx',
                  pdfFullScreen: true,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
