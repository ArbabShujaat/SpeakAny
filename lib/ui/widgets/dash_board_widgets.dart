import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:speakAny/constants/constants.dart';
import 'package:speakAny/ui/widgets/youtube_playes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String teacherimage = "";

Widget teachersAvatar(BuildContext context, String image) {
  return GestureDetector(
    onTap: () {
      teacherimage = image;
      Navigator.pushNamed(context, TEACHERS_SCREEN);
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: CircleAvatar(
          minRadius: 30,
          backgroundImage: AssetImage(image),
        ),
      ),
    ),
  );
}

Widget languageScroll(String image, String language) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
              Radius.circular(12.0),
            )),
        child: Stack(
          children: <Widget>[
            Container(
                decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(
                Radius.circular(12.0),
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            )),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.black45.withOpacity(0.1),
                  borderRadius: new BorderRadius.all(
                    Radius.circular(12.0),
                  )),
            ),
            Center(
              child: Container(
                color: Colors.black45.withOpacity(0.7),
                child: Text(
                  language,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        height: 50,
        width: 150),
  );
}

Widget videosScroll(BuildContext context, String text, String url1) {
  return Column(
    children: <Widget>[
      GestureDetector(
        onTap: () {
          url = url1;
          Navigator.pushNamed(context, YOUTUBE_PLAYER);
        },
        onLongPress: () {
          url = url1;
          Navigator.pushNamed(context, YOUTUBE_PLAYER);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      YoutubePlayer.getThumbnail(
                        quality: ThumbnailQuality.standard,
                        videoId: YoutubePlayer.convertUrlToId(url1),
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(
                    Radius.circular(20.0),
                  )),
              child: Stack(
                children: <Widget>[
                  // Image.network(
                  //   YoutubePlayer.getThumbnail(
                  //     quality: ThumbnailQuality.standard,
                  //     videoId: YoutubePlayer.convertUrlToId(
                  //         "https://www.youtube.com/watch?v=5W29ZASPo3I"),
                  //   ),
                  //   fit: BoxFit.fitHeight,
                  // ),
                  Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 40,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              height: 130,
              width: 150),
        ),
      ),
      Text(
        text,
        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
