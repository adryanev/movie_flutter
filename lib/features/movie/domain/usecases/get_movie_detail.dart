import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie_detail.dart';
import 'package:movie_flutter/features/movie/domain/repositories/movie_contract.dart';

class GetMovieDetail extends UseCase<MovieDetail, GetMovieDetailParams> {
  GetMovieDetail(this._contract);
  final MovieContract _contract;
  @override
  Future<Either<Failure, MovieDetail>> call(GetMovieDetailParams params) async {
    return _contract.getMovieDetail(params.movie);
  }
}

class GetMovieDetailParams extends Equatable {
  const GetMovieDetailParams(this.movie);
  final Movie movie;

  @override
  List<Object?> get props => [movie];
}
