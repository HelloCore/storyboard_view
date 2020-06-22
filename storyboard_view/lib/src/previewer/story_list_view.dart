import 'package:flutter/material.dart';
import '../story_view.dart';

class StoryListView extends StatefulWidget {
  final Iterable<StoryView> stories;
  final Function(StoryView, String) onSelectStory;
  final StoryView selectedStoryView;
  final String selectedStoryName;

  StoryListView(
      {@required this.stories,
      this.onSelectStory,
      this.selectedStoryView,
      this.selectedStoryName});

  @override
  _StoryListViewState createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  final _textEditingController = TextEditingController();
  Iterable<StoryView> filteredStory;
  
  List<StoryView> _rawStory;

  @override
  void initState() {
    _rawStory = widget.stories.toList();
    _rawStory.sort((a,b) => a.name.compareTo(b.name));

    filteredStory = _rawStory;
    _textEditingController.addListener(() {
      final text = _textEditingController.value.text;
      setState(() {
        if (text.isEmpty) {
          filteredStory = _rawStory;
        } else {
          final regex = RegExp(_textEditingController.value.text,
              caseSensitive: false);

          filteredStory =
              _rawStory.where((element) => regex.hasMatch(element.name));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(hintText: 'Filter Story (Regexp)'),
              ),
              height: 60),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) {
              final storyView = filteredStory.elementAt(index);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 30),
                      child: Container(
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              Text(storyView.name),
                            ],
                          ))),
                  ...storyView.stories
                      .map((story) => InkWell(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text('- ${story.name}'),
                              height: 30,
                              color: widget.selectedStoryName == story.name &&
                                      storyView == widget.selectedStoryView
                                  ? Colors.black12
                                  : Colors.white,
                            ),
                            onTap: () {
                              widget.onSelectStory(storyView, story.name);
                            },
                          ))
                      .toList(),
                ],
              );
            },
            itemCount: filteredStory.length,
          ))
        ],
      ),
    );
  }
}
