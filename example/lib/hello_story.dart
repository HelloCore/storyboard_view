import 'package:flutter/material.dart';
import 'package:storyboard_view/storyboard_view.dart';
import 'package:storyboard_view_annotation/storyboard_view_annotation.dart';

@StoryboardViewConfigurer()
void init() {
  
}

class HelloStory extends StoryView {
  @override
  StoryboardViewDecorator get decorator => null;

  @override
  String get name => 'Hello World';

  @override
  List<Story> get stories => [
        Story(
            name: 'default',
            storyBuilder: (ctx) {
              return Container(
                child: Center(
                  child: Text('1234'),
                ),
              );
            })
      ];
}
