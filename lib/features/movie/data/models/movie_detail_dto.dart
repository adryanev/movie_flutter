import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_flutter/core/data/models/base_response.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/data/models/genre_dto.dart';
import 'package:movie_flutter/features/movie/data/models/movie_list_dto.dart';
import 'package:movie_flutter/features/movie/data/models/video_dto.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie_detail.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';

part 'movie_detail_dto.freezed.dart';
part 'movie_detail_dto.g.dart';

@freezed
class MovieDetailDto with _$MovieDetailDto {
  const factory MovieDetailDto({
    required List<GenreDto>? genres,
    required int? id,
    required String? title,
    required String? overview,
    @JsonKey(name: 'poster_path') required String? posterPath,
    @JsonKey(name: 'release_date') required String? releaseDate,
    required int? runtime,
    @JsonKey(name: 'vote_average') required double? voteAverage,
    required VideoDto? videos,
    required BaseResponse<List<MovieListDto>>? similar,
  }) = _MovieDetailDto;

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailDtoFromJson(json);
}

extension MovieDetailDtoX on MovieDetailDto {
  MovieDetail toDomain() => MovieDetail(
        releaseDate: DateTime.parse(releaseDate!),
        rating: Rating(voteAverage),
        synopsis: overview!,
        title: Title(title),
        poster: Poster(posterPath),
        genres: genres!.map((e) => e.toDomain()).toList(),
        duration: Duration(minutes: runtime!),
        relatedMovies: similar!.results!.map((e) => e.toDomain()).toList(),
        id: UniqueId(id),
        trailer: Trailer(
          'https://www.youtube.com/watch?v=${videos?.results?.where(
                (element) =>
                    element.isOfficial! &&
                    element.type == 'Trailer' &&
                    (element.site == 'Youtube' ||
                        element.site == 'youtube' ||
                        element.site == 'YouTube'),
              ).first.key}',
        ),
      );
}
