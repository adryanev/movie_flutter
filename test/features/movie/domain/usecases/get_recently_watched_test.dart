import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/core/domain/value_object.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
import 'package:movie_flutter/features/movie/domain/usecases/get_recently_watched.dart';
import '../repositories/movie_session_contract_mock.dart';

void main() {
  late GetRecentlyWatched systemUnderTest;
  late MovieSessionContractMock contract;
  late Movie movie;
  setUp(() {
    contract = MovieSessionContractMock();
    systemUnderTest = GetRecentlyWatched(contract);
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
  });

  group('Get Recently Watched Use Case', () {
    test(
      'should return Movie if success',
      () async {
        // arrange
        when(() => contract.getRecentlyWatched()).thenAnswer(
          (_) async => right<Failure, Movie>(
            movie,
          ),
        );
        // act
        final result = await systemUnderTest(NoParam());
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.getRecentlyWatched()).called(1);
        expect(result.isRight(), true);
        expect(data != null, true);
        expect(data, movie);
      },
    );

    test(
      'should return Failure if failed',
      () async {
        // arrange
        when(() => contract.getRecentlyWatched()).thenAnswer(
          (_) async => left<Failure, Movie>(
            const Failure.localFailure(message: 'Not Found'),
          ),
        );
        // act
        final result = await systemUnderTest(NoParam());
        final data = result.toOption().toNullable();
        // assert
        verify(() => contract.getRecentlyWatched()).called(1);
        expect(result.isLeft(), true);
        expect(data, null);
      },
    );
  });
}
