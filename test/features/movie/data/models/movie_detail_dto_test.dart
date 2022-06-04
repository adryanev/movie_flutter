// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_flutter/core/data/models/base_response.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/data/models/genre_dto.dart';
import 'package:movie_flutter/features/movie/data/models/movie_detail_dto.dart';
import 'package:movie_flutter/features/movie/data/models/movie_list_dto.dart';
import 'package:movie_flutter/features/movie/data/models/video_dto.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie_detail.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';

import '../../../../helpers/fixture_reader.dart';

void main() {
  late MovieDetailDto movieDetailDtoMatcher;
  late List<GenreDto> genreDtoListMatcher;
  late VideoDto videoDtoMatcher;
  late List<VideoResultDto> videoResultDtoMatcher;
  late MovieListDto similarMatcher;
  late MovieDetail movieDetailMatcher;

  setUp(() {
    genreDtoListMatcher = const [
      GenreDto(id: 28, name: 'Action'),
      GenreDto(id: 12, name: 'Adventure'),
      GenreDto(id: 35, name: 'Comedy'),
      GenreDto(id: 878, name: 'Science Fiction')
    ];
    videoResultDtoMatcher = const [
      VideoResultDto(
        name: 'Official Trailer',
        key: 'IE8HIsIrq4o',
        site: 'YouTube',
        type: 'Trailer',
        isOfficial: true,
      )
    ];
    videoDtoMatcher = VideoDto(results: videoResultDtoMatcher);
    similarMatcher = const MovieListDto(
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
    movieDetailDtoMatcher = MovieDetailDto(
      genres: genreDtoListMatcher,
      id: 696806,
      title: 'The Adam Project',
      overview:
          'After accidentally crash-landing in 2022, time-traveling fighter pilot Adam Reed teams up with his 12-year-old self on a mission to save the future.',
      posterPath: '/wFjboE0aFZNbVOF05fzrka9Fqyx.jpg',
      releaseDate: '2022-03-11',
      runtime: 106,
      voteAverage: 7,
      videos: videoDtoMatcher,
      similar: BaseResponse<List<MovieListDto>>(
        page: 1,
        results: [similarMatcher],
        totalPages: 500,
        totalResults: 10000,
      ),
    );
    movieDetailMatcher = MovieDetail(
      id: UniqueId(696806),
      title: Title('The Adam Project'),
      poster: Poster('/wFjboE0aFZNbVOF05fzrka9Fqyx.jpg'),
      duration: const Duration(minutes: 106),
      rating: Rating(7),
      releaseDate: DateTime.parse('2022-03-11'),
      genres: [
        Genre(id: UniqueId(28), name: StringSingleLine('Action')),
        Genre(id: UniqueId(12), name: StringSingleLine('Adventure')),
        Genre(id: UniqueId(35), name: StringSingleLine('Comedy')),
        Genre(id: UniqueId(878), name: StringSingleLine('Science Fiction'))
      ],
      synopsis:
          'After accidentally crash-landing in 2022, time-traveling fighter pilot Adam Reed teams up with his 12-year-old self on a mission to save the future.',
      trailer: Trailer('https://www.youtube.com/watch?v=IE8HIsIrq4o'),
      relatedMovies: [
        Movie(
          id: UniqueId(similarMatcher.id),
          title: Title(similarMatcher.title),
          poster: Poster(similarMatcher.posterPath),
          releaseDate: DateTime.parse(similarMatcher.releaseDate!),
          rating: Rating(similarMatcher.voteAverage),
          trailer: Trailer(null),
        )
      ],
    );
  });

  group('MovieDetailDto model', () {
    test(
      'should return MovieDetailDto when called fromJson',
      () async {
        // arrange
        final rawDetail = fixture('movie', 'movie_detail.json');
        final jsonDecoded = jsonDecode(rawDetail) as Map<String, dynamic>;
        // act
        final result = MovieDetailDto.fromJson(jsonDecoded);
        // assert
        expect(result, movieDetailDtoMatcher);
      },
    );
  });

  test(
    'should return MovieDetail when toDomain',
    () async {
      // arrange
      final rawDetail = fixture('movie', 'movie_detail.json');
      final jsonDecoded = jsonDecode(rawDetail) as Map<String, dynamic>;

      final dtos = MovieDetailDto.fromJson(jsonDecoded);

      // act
      final result = dtos.toDomain();

      // assert
      expect(result, movieDetailMatcher);
    },
  );
}
