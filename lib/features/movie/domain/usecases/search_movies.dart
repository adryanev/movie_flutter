import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/core/domain/use_case.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/search_query.dart';
import 'package:movie_flutter/features/movie/domain/repositories/movie_contract.dart';

class SearchMovies extends UseCase<List<Movie>, SearchMoviesParams> {
  SearchMovies(this._contract);
  final MovieContract _contract;

  @override
  Future<Either<Failure, List<Movie>>> call(SearchMoviesParams params) async {
    return _contract.searchMovies(params.searchQuery);
  }
}

class SearchMoviesParams extends Equatable {
  const SearchMoviesParams(this.searchQuery);
  final SearchQuery searchQuery;
  @override
  List<Object?> get props => [searchQuery];
}
