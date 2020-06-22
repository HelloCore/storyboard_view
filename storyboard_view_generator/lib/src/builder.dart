import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:storyboard_view_generator/src/storyboard_combine_generator.dart';
import './storyboard_generator.dart';

Builder storyboardBuilder(BuilderOptions options) {
  return LibraryBuilder(
    StoryboardGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.storyboard.g.json',
  );
}

Builder storyboardCombineBuilder(BuilderOptions options) {
  return LibraryBuilder(
    StoryboardCombineGenerator(),
    generatedExtension: '.storyboard_g.dart',
  );
}