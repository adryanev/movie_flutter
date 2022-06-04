import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie_detail.dart';
import 'package:movie_flutter/features/movie/domain/entities/search_query.dart';
import 'package:movie_flutter/features/movie/domain/repositories/movie_contract.dart';

@LazySingleton(as: MovieContract)
class MovieRepository implements MovieContract {
  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(Movie movie) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(Genre genre) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(SearchQuery searchQuery) {
    throw UnimplementedError();
  }
}
