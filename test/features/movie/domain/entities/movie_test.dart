import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';

void main() {
  group('movie entity', () {
    test('create with full value', () {
      //prepare
      final now = DateTime.now();
      final movie = Movie(
        id: UniqueId(1),
        title: Title('Hero'),
        rating: Rating(4.5),
        poster: Poster('/2d'),
        releaseDate: now,
        trailer: Trailer('https://youtube.com/watch?v=29wadk2ll1302'),
      );
      //act

      //validate
      expect(movie.id.getOrCrash(), 1);
      expect(movie.title.getOrCrash(), 'Hero');
      expect(movie.rating.getOrCrash(), 4.5);
      expect(movie.poster.getOrCrash(), 'https://image.tmdb.org/t/p/w185/2d');
      expect(movie.releaseDate, now);
      expect(
        movie.trailer.getOrCrash(),
        'https://youtube.com/watch?v=29wadk2ll1302',
      );
    });
    test('create with some value missing', () {
      final now = DateTime.now();
      final movie = Movie(
        id: UniqueId(1),
        title: Title('Hero'),
        rating: Rating(4.5),
        poster: Poster(null),
        releaseDate: now,
        trailer: Trailer(null),
      );
      //act

      //validate
      expect(movie.id.getOrCrash(), 1);
      expect(movie.title.getOrCrash(), 'Hero');
      expect(movie.rating.getOrCrash(), 4.5);
      expect(movie.poster.getOrCrash(), 'https://via.placeholder.com/200');
      expect(movie.releaseDate, now);
      expect(
        movie.trailer.getOrCrash(),
        'https://www.youtube.com/watch?v=PWbRleMGagU&list=RDjZhW9pupZfI',
      );
    });
  });
}
