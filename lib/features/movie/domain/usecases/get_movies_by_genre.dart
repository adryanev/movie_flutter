import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/repositories/movie_contract.dart';

@injectable
class GetMoviesByGenre extends UseCase<List<Movie>, GetMoviesByGenreParams> {
  GetMoviesByGenre(this._contract);
  final MovieContract _contract;
  @override
  Future<Either<Failure, List<Movie>>> call(
    GetMoviesByGenreParams params,
  ) async {
    return _contract.getMoviesByGenre(params.genre);
  }
}

class GetMoviesByGenreParams extends Equatable {
  const GetMoviesByGenreParams(this.genre);
  final Genre genre;
  @override
  List<Object?> get props => [genre];
}
