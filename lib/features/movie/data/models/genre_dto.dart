import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
part 'genre_dto.freezed.dart';
part 'genre_dto.g.dart';

@freezed
class ResultGenreDto with _$ResultGenreDto {
  const factory ResultGenreDto({required List<GenreDto>? genres}) =
      _ResultGenreDto;

  factory ResultGenreDto.fromJson(Map<String, dynamic> json) =>
      _$ResultGenreDtoFromJson(json);
}

extension ResultGenreDtoX on ResultGenreDto {
  List<Genre> toDomain() => genres!.map((e) => e.toDomain()).toList();
}

@freezed
class GenreDto with _$GenreDto {
  const factory GenreDto({
    required int? id,
    required String? name,
  }) = _GenreDto;
  factory GenreDto.fromJson(Map<String, dynamic> json) =>
      _$GenreDtoFromJson(json);
}

extension GenreDtoX on GenreDto {
  Genre toDomain() => Genre(
        id: UniqueId(id),
        name: StringSingleLine(name),
      );
}
