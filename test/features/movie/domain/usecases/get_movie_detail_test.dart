import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie_detail.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
import 'package:movie_flutter/features/movie/domain/usecases/get_movie_detail.dart';

import '../repositories/movie_contract_mock.dart';

void main() {
  late GetMovieDetail systemUnderTest;
  late MovieContractMock contract;
  late Movie movie;
  late MovieDetail movieDetail;

  setUp(() {
    contract = MovieContractMock();
    systemUnderTest = GetMovieDetail(contract);
    movie = Movie(
      id: UniqueId(1),
      title: Title('Hello'),
      poster: Poster(null),
      releaseDate: DateTime.now().subtract(
        const Duration(days: 360),
      ),
      rating: Rating(8),
      trailer: Trailer(null),
    );
    movieDetail = MovieDetail(
      id: UniqueId(1),
      title: Title('Hello'),
      poster: Poster(null),
      releaseDate: DateTime.now().subtract(
        const Duration(days: 360),
      ),
      rating: Rating(8),
      trailer: Trailer(null),
      synopsis: 'Synopsis',
      duration: const Duration(minutes: 145),
      genres: <Genre>[
        Genre(
          id: UniqueId(1),
          name: StringSingleLine('Action'),
        ),
      ],
      relatedMovies: <Movie>[
        Movie(
          id: UniqueId(2),
          title: Title('World'),
          poster: Poster(null),
          releaseDate: DateTime.now().subtract(
            const Duration(days: 360),
          ),
          rating: Rating(7),
          trailer: Trailer(null),
        ),
      ],
    );
  });

  group('Get Movie Detail Use case', () {
    test(
      'should return movie detail if success',
      () async {
        // arrange
        when(() => contract.getMovieDetail(movie)).thenAnswer(
          (_) async => right<Failure, MovieDetail>(movieDetail),
        );
        // act
        final result = await systemUnderTest(
          GetMovieDetailParams(movie),
        );
        final data = result.toOption().toNullable();
        // assert
        verify(
          () => contract.getMovieDetail(movie),
        ).called(1);
        expect(result.isRight(), true);
        expect(data != null, true);
        expect(data, movieDetail);
      },
    );

    test(
      'should return failure if failed',
      () async {
        // arrange
        when(() => contract.getMovieDetail(movie)).thenAnswer(
          (_) async => left<Failure, MovieDetail>(
            const Failure.serverFailure(message: 'Not Found'),
          ),
        );
        // act
        final result = await systemUnderTest(GetMovieDetailParams(movie));
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.getMovieDetail(movie)).called(1);
        expect(result.isLeft(), true);
        expect(data, null);
      },
    );
  });
}
