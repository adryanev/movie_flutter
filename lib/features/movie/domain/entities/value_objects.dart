import 'package:dartz/dartz.dart';
import 'package:movie_flutter/core/domain/value_failure.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/core/domain/value_validator.dart';

class Title extends ValueObject<String> {
  factory Title(String? input) {
    // we just want the title cannot be null
    assert(input != null, 'title cannot be null');
    return Title._(right(input!));
  }
  const Title._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class Poster extends ValueObject<String> {
  factory Poster(String? path) {
    //if the poster is null, or empty, change to default poster.
    if (path == null || path.isEmpty) {
      return Poster._(right(defaultPoster));
    }

    return Poster._(
      right(
        Uri(
          scheme: 'https',
          host: baseUrl,
          path: basePath + path,
        ).toString(),
      ),
    );
  }

  const Poster._(this.value);

  static const size = 'w185';
  static const baseUrl = 'image.tmdb.org';
  static const basePath = '/t/p/$size';
  static const defaultPoster = 'https://via.placeholder.com/200';
  @override
  final Either<ValueFailure<String>, String> value;
}

class Trailer extends ValueObject<String> {
  factory Trailer(String? url) {
    if (url == null || url.isEmpty) {
      return Trailer._(right(defaultTrailer));
    }
    return Trailer._(right(url));
  }

  const Trailer._(this.value);
  static const defaultTrailer =
      'https://www.youtube.com/watch?v=PWbRleMGagU&list=RDjZhW9pupZfI';
  @override
  final Either<ValueFailure<String>, String> value;
}

class Rating extends ValueObject<double> {
  factory Rating(double? input) {
    assert(input != null, 'rating cannot be empty');
    return Rating._(
      validateNumberRange<double>(
        number: input!,
        minimum: minimum,
        maximum: maximum,
      ),
    );
  }
  const Rating._(this.value);
  static const minimum = 0.0;
  static const maximum = 10.0;
  @override
  final Either<ValueFailure<double>, double> value;
}
