import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
import 'package:movie_flutter/features/movie/domain/usecases/get_trending_movies.dart';

import '../repositories/movie_contract_mock.dart';

void main() {
  late GetTrendingMovies usecase;
  late MovieContractMock contract;
  late List<Movie> movies;
  setUp(
    () {
      contract = MovieContractMock();
      usecase = GetTrendingMovies(contract);
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
    },
  );

  group(
    'GetTrendingMovie use case',
    () {
      test(
        'should return list of movies if success',
        () async {
          // arrange
          when(() => contract.getTrendingMovies())
              .thenAnswer((_) async => right<Failure, List<Movie>>(movies));
          // act
          final response = await usecase(NoParam());
          final data = response.toOption().toNullable();
          // assert
          verify(
            () => contract.getTrendingMovies(),
          ).called(1);
          assert(data != null, 'Response cannot be null here.');
          expect(response.isRight(), true);
          expect(data!.length, 2);
          expect(data.first, movies.first);
        },
      );

      test(
        'should return failure if failed',
        () async {
          // arrange
          when(() => contract.getTrendingMovies()).thenAnswer(
            (_) async => left<Failure, List<Movie>>(
              const Failure.serverFailure(message: 'Not Found'),
            ),
          );
          // act
          final response = await usecase(NoParam());
          final data = response.toOption().toNullable();
          // assert
          verify(() => contract.getTrendingMovies()).called(1);
          expect(response.isLeft(), true);
          expect(data, null);
        },
      );
    },
  );
}
