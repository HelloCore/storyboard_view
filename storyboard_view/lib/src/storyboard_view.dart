import 'package:flutter/material.dart';
import './story_view.dart';
import './previewer/story_list_view.dart';
import './previewer/story_previewer.dart';

class StoryboardView extends StatefulWidget {
  final Map<String, StoryView> _stories = {};

  void addStoryView(StoryView storyView) {
    assert(!_stories.containsKey(storyView.name),
        'Category\'s name must be unique');
    _stories[storyView.name] = storyView;
  }

  @override
  _StoryboardViewState createState() => _StoryboardViewState();
}

class _StoryboardViewState extends State<StoryboardView> {
  StoryView selectedStoryView;
  String selectedStoryName;

  void _onSelectStory(StoryView storyView, String storyName) {
    setState(() {
      selectedStoryView = storyView;
      selectedStoryName = storyName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          StoryListView(
            stories: widget._stories.values,
            onSelectStory: _onSelectStory,
            selectedStoryName: selectedStoryName,
            selectedStoryView: selectedStoryView,
          ),
          Expanded(
              child: selectedStoryName != null
                  ? StoryPreviewer(selectedStoryView, selectedStoryName)
                  : Center(
                      child: Text('Please select story from left panel'),
                    ))
        ],
      ),
    );
  }
}
