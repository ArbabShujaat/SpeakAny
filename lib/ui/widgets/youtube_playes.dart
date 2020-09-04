import 'package:flutter/material.dart';
import 'package:speakAny/constants/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Youtube extends StatefulWidget {
  final url;
  Youtube({@required this.url});

  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url),
        flags: YoutubePlayerFlags(
          isLive: false,
          autoPlay: true,
          mute: false,
        ));

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
              playedColor: Colors.red, handleColor: Colors.amber),
          onReady: () {
            _controller.addListener(() {});
          },
        ),
      ),
    );
  }
}
