import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import 'package:storyboard_view_annotation/storyboard_view_annotation.dart';
import 'package:storyboard_view_generator/src/model/storyboard_view_source.dart';

class StoryboardCombineGenerator
    extends GeneratorForAnnotation<StoryboardViewConfigurer> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final injectableConfigFiles = Glob("**.storyboard.g.json");

    final deps = <StoryboardViewSource>[];
    
    await for (final id in buildStep.findAssets(injectableConfigFiles)) {
      final json = jsonDecode(await buildStep.readAsString(id));
      deps.add(StoryboardViewSource.fromJson(json));
    }

    final importStatements = StringBuffer();
    final setupStatements = StringBuffer();
    
    importStatements.write('import \'package:storyboard_view/storyboard_view.dart\';');
    importStatements.write('\n');
    
    deps.forEach((element) {
      importStatements.write('import \'${element.path}\';');
      importStatements.write('\n');
      setupStatements.write('  storyboard.addStoryView(${element.name}());');
      setupStatements.write('\n');
    });

    return importStatements.toString() +
        '\n void setupStoryboard(StoryboardView storyboard) {\n' +
        setupStatements.toString() +
        '}';
  }
}
