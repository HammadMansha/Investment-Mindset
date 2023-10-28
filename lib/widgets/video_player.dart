// ignore_for_file: depend_on_referenced_packages

import 'package:video_player/video_player.dart';

import '../utils/app_libraries.dart';

class VideoWidget extends StatefulWidget {
  final bool play;
  final String url;

  const VideoWidget({Key? key, required this.url, required this.play})
      : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture =
        videoPlayerController.initialize().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        return Chewie(
          key: PageStorageKey(widget.url),
          controller: ChewieController(
              allowFullScreen: true,
              allowMuting: true,
              showControls: true,
              
              videoPlayerController: videoPlayerController,
              aspectRatio: videoPlayerController.value.aspectRatio,
              autoPlay: false,
              looping: false,
              errorBuilder: (context, errorMessage) {
                return Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
        );
      },
    );
  }
}
