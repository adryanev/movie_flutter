import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required UniqueId id,
    required Title title,
    required Poster poster,
    required Duration duration,
    required Rating rating,
    required DateTime releaseDate,
    required List<Genre> genres,
    required String synopsis,
    required Trailer trailer,
    required List<Movie> relatedMovies,
  }) = _MovieDetail;
}
