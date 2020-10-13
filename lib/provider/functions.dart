import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/Student.dart';

class Functions with ChangeNotifier {
  int seconds = 3;
  int defaultSecond = 3;
  Map<int, String> stringToArrayShuffled = {};
  Map<int, String> deletedLettersList = {};
  Image _image;
  int _index;
  Timer timer;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void newQuestion() {
    stringToArrayShuffled.clear();
    deletedLettersList.clear();

    _image = new Image.network(
      students[_index].imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }

  void startTimer() {
    _image.image.resolve(new ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, call) {
          timer = new Timer.periodic(new Duration(seconds: 1), (time) {
            if (seconds == 0) {
              time.cancel();
              seconds = defaultSecond;
              if (_index != students.length) _index++;
              newQuestion();
              return;
            }
            seconds--;
          });
        },
      ),
    );
  }
}
