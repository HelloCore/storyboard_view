import 'package:flutter/material.dart';

class Story {
  final String name;
  final Widget Function(BuildContext) storyBuilder;

  Story({@required this.name, @required this.storyBuilder});
}