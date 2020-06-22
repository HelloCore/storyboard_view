import 'package:flutter/material.dart';
import '../story_view.dart';

class StoryPreviewer extends StatelessWidget {
  
  final String storyName;
  final StoryView storyView;

  StoryPreviewer(this.storyView, this.storyName);

  @override
  Widget build(BuildContext context) {
    final widget = storyView.stories
        .singleWhere((element) => element.name == storyName)
        .storyBuilder(context);
    return Container(
      child: storyView.decorator != null
          ? storyView.decorator.decorate(widget)
          : widget,
    );
  }
}