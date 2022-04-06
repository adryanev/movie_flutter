import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
part 'movie_list_dto.freezed.dart';
part 'movie_list_dto.g.dart';

@freezed
class MovieListDto with _$MovieListDto {
  const factory MovieListDto({
    required int? id,
    required String? overview,
    @JsonKey(name: 'release_date') required String? releaseDate,
    @JsonKey(name: 'genre_ids') required List<int>? genreIds,
    @JsonKey(name: 'vote_average') required double? voteAverage,
    @JsonKey(name: 'poster_path') required String? posterPath,
    required bool? video,
    required String? title,
    @JsonKey(name: 'media_type') required String? mediaType,
  }) = _MovieListDto;

  factory MovieListDto.fromJson(Map<String, dynamic> json) =>
      _$MovieListDtoFromJson(json);
}

extension MovieListDtoX on MovieListDto {
  Movie toDomain() => Movie(
        title: Title(title),
        releaseDate: DateTime.parse(releaseDate!),
        trailer: Trailer(null),
        id: UniqueId(id),
        rating: Rating(voteAverage),
        poster: Poster(posterPath),
      );
}
