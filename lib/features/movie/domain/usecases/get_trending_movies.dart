import 'package:dartz/dartz.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/repositories/movie_contract.dart';

class GetTrendingMovies extends UseCase<List<Movie>, NoParam> {
  GetTrendingMovies(this._contract);
  final MovieContract _contract;

  @override
  Future<Either<Failure, List<Movie>>> call(NoParam params) {
    return _contract.getTrendingMovies();
  }
}
