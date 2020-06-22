import 'dart:async';
import 'dart:convert';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:storyboard_view_generator/src/model/storyboard_view_source.dart';

class StoryboardGenerator implements Generator {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    for (var clazz in library.classes) {
      if (clazz.allSupertypes.singleWhere(
              (element) => element.toString() == 'StoryView',
              orElse: () => null) !=
          null) {
        return json.encode(StoryboardViewSource(
                name: clazz.name,
                path: clazz.source.uri.toString())
            .toJson());
      }
    }

    return null;
  }

  Resolver getResolver(BuildStep buildStep) {
    return buildStep.resolver;
  }
}
