import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/data/models/genre_dto.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';

import '../../../../helpers/fixture_reader.dart';

void main() {
  late GenreDto genreDto;
  late Genre genre;
  late List<Genre> listOfGenre;
  setUp(() {
    genreDto = const GenreDto(id: 28, name: 'Action');
    genre = Genre(id: UniqueId(28), name: StringSingleLine('Action'));
    listOfGenre = [genre];
  });

  group('genre_dto entity', () {
    test(
      'should return GenreDto after calling fromJson method',
      () async {
        // arrange
        final rawString = fixture('movie', 'genre.json');

        // act
        final result = ResultGenreDto.fromJson(
          jsonDecode(rawString) as Map<String, dynamic>,
        );

        // assert
        expect(result.genres?.first, genreDto);
        expect(result.genres?.first.id, genreDto.id);
        expect(result.genres?.first.name, genreDto.name);
      },
    );

    test(
      'should return Genre when calling toDomain method',
      () async {
        // arrange
        final rawString = fixture('movie', 'genre.json');
        // act
        final result = ResultGenreDto.fromJson(
          jsonDecode(rawString) as Map<String, dynamic>,
        );
        final domain = result.toDomain();

        // assert
        expect(domain.first, listOfGenre.first);
        expect(domain.first.name, listOfGenre.first.name);
        expect(domain.first.id, listOfGenre.first.id);
      },
    );
  });
}
