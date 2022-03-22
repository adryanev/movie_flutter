import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/features/movie/domain/entities/search_query.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';

void main() {
  group('SearchQuery entity', () {
    test(
      'should be created',
      () {
        final title = Title('Hello World');

        final query = SearchQuery(title: title);

        expect(query.title, title);
        expect(query.title.getOrCrash(), title.getOrCrash());
      },
    );
  });
}
