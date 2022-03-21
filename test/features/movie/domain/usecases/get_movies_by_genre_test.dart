import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
import 'package:movie_flutter/features/movie/domain/usecases/get_movies_by_genre.dart';

import '../repositories/movie_contract_mock.dart';

void main() {
  late GetMoviesByGenre systemUnderTest;
  late MovieContractMock contract;
  late List<Movie> movies;
  late Genre genre;

  setUp(() {
    contract = MovieContractMock();
    systemUnderTest = GetMoviesByGenre(contract);
    movies = <Movie>[
      Movie(
        id: UniqueId(1),
        title: Title('Hello'),
        poster: Poster(null),
        releaseDate: DateTime.now().subtract(
          const Duration(days: 360),
        ),
        rating: Rating(8),
        trailer: Trailer(null),
      ),
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
    ];
    genre = Genre(id: UniqueId(1), name: StringSingleLine('Action'));
  });

  group('Get Movie by Genre Use Case', () {
    test(
      'should return list of movie when success',
      () async {
        // arrange
        when(
          () => contract.getMoviesByGenre(genre),
        ).thenAnswer(
          (_) async => right<Failure, List<Movie>>(movies),
        );
        // act
        final result = await systemUnderTest(
          GetMoviesByGenreParams(genre),
        );
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.getMoviesByGenre(genre)).called(1);
        expect(data != null, true);
        expect(result.isRight(), true);
        expect(data!.length, 2);
        expect(data.first, movies.first);
      },
    );

    test(
      'should return failure when failed',
      () async {
        // arrange
        when(
          () => contract.getMoviesByGenre(genre),
        ).thenAnswer(
          (_) async => left<Failure, List<Movie>>(
            const Failure.serverFailure(message: 'Not Found'),
          ),
        );
        // act
        final result = await systemUnderTest(
          GetMoviesByGenreParams(genre),
        );
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.getMoviesByGenre(genre)).called(1);
        expect(data, null);
        expect(result.isLeft(), true);
      },
    );
  });
}
