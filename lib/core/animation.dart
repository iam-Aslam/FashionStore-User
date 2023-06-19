import 'package:flutter/material.dart';

animateToMaxMin(double max, double min, double direction, int seconds,
    ScrollController scrollController) {
  scrollController
      .animateTo(direction,
          duration: Duration(seconds: seconds), curve: Curves.linear)
      .then((value) {
    direction = direction == max ? min : max;
    animateToMaxMin(max, min, direction, seconds, scrollController);
  });
}
