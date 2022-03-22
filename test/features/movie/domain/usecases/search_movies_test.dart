import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/search_query.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
import 'package:movie_flutter/features/movie/domain/usecases/search_movies.dart';

import '../repositories/movie_contract_mock.dart';

void main() {
  late SearchMovies systemUnderTest;
  late MovieContractMock contract;
  late List<Movie> movies;
  late SearchQuery searchQuery;

  setUp(() {
    contract = MovieContractMock();
    systemUnderTest = SearchMovies(contract);
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
    searchQuery = SearchQuery(title: Title('Hello'));
  });

  group('Search Movie use case', () {
    test(
      'should return list of movie when success',
      () async {
        // arrange
        when(
          () => contract.searchMovies(searchQuery),
        ).thenAnswer(
          (_) async => right<Failure, List<Movie>>(movies),
        );
        // act
        final result = await systemUnderTest(
          SearchMoviesParams(searchQuery),
        );
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.searchMovies(searchQuery)).called(1);
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
          () => contract.searchMovies(searchQuery),
        ).thenAnswer(
          (_) async => left<Failure, List<Movie>>(
            const Failure.serverFailure(message: 'Not Found'),
          ),
        );
        // act
        final result = await systemUnderTest(
          SearchMoviesParams(searchQuery),
        );
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.searchMovies(searchQuery)).called(1);
        expect(data, null);
        expect(result.isLeft(), true);
      },
    );
  });
}
