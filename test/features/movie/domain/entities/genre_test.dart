import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';

void main() {
  group('genre entity', () {
    test('create with full value', () {
      final genre = Genre(
        id: UniqueId(1),
        name: StringSingleLine('Action'),
      );

      expect(genre.id.getOrCrash(), 1);
      expect(genre.name.getOrCrash(), 'Action');
    });
  });
}
