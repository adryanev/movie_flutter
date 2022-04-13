import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/core/data/models/base_response.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/data/models/movie_list_dto.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';

import '../../../../helpers/fixture_reader.dart';

void main() {
  late MovieListDto movieListDtoMatcher;
  late Movie movieMatcher;
  setUp(() {
    movieListDtoMatcher = const MovieListDto(
      id: 634649,
      overview:
          'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
      releaseDate: '2021-12-15',
      genreIds: [28, 12, 878],
      voteAverage: 8.2,
      posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
      video: false,
      title: 'Spider-Man: No Way Home',
      mediaType: 'movie',
    );
    movieMatcher = Movie(
      id: UniqueId(movieListDtoMatcher.id),
      title: Title(movieListDtoMatcher.title),
      poster: Poster(movieListDtoMatcher.posterPath),
      releaseDate: DateTime.parse(movieListDtoMatcher.releaseDate!),
      rating: Rating(movieListDtoMatcher.voteAverage),
      trailer: Trailer(null),
    );
  });

  group('MovieListDto entity', () {
    test(
      'should return BaseResponse<List<MovieListDto>> when called fromJson',
      () async {
        // arrange
        final rawTrending = fixture('movie', 'trending.json');
        final jsonDecoded = jsonDecode(rawTrending) as Map<String, dynamic>;
        // act
        final result =
            BaseResponse<List<MovieListDto>>.fromJson(jsonDecoded, (x) {
          final result = x as List<dynamic>?;
          return result!
              .map(
                (dynamic each) => MovieListDto.fromJson(
                  each as Map<String, dynamic>,
                ),
              )
              .toList();
        });
        // assert

        expect(result.results?.first, movieListDtoMatcher);
      },
    );
  });

  test(
    'should return Movie when toDomain',
    () async {
      // arrange
      final rawTrending = fixture('movie', 'trending.json');
      final jsonDecoded = jsonDecode(rawTrending) as Map<String, dynamic>;

      final dtos = BaseResponse<List<MovieListDto>>.fromJson(jsonDecoded, (x) {
        final result = x as List<dynamic>?;
        return result!
            .map(
              (dynamic each) => MovieListDto.fromJson(
                each as Map<String, dynamic>,
              ),
            )
            .toList();
      });

      // act
      final result = dtos.results?.map((e) => e.toDomain());

      // assert
      expect(result?.first, movieMatcher);
    },
  );
}
