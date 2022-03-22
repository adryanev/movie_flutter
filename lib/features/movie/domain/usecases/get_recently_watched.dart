import 'package:dartz/dartz.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/repositories/movie_session_contract.dart';

class GetRecentlyWatched extends UseCase<Movie, NoParam> {
  GetRecentlyWatched(this._contract);
  final MovieSessionContract _contract;
  @override
  Future<Either<Failure, Movie>> call(NoParam params) async {
    return _contract.getRecentlyWatched();
  }
}
