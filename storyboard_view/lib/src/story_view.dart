import './story.dart';
import './storyboard_view_decorator.dart';

abstract class StoryView {
  String get name;
  StoryboardViewDecorator get decorator;
  List<Story> get stories;
}