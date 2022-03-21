import 'package:dartz/dartz.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/features/movie/domain/entities/genre.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie_detail.dart';
import 'package:movie_flutter/features/movie/domain/entities/search_query.dart';

abstract class MovieContract {
  Future<Either<Failure, List<Movie>>> getTrendingMovies();
  Future<Either<Failure, List<Movie>>> getMoviesByGenre(Genre genre);
  Future<Either<Failure, List<Movie>>> searchMovies(SearchQuery searchQuery);
  Future<Either<Failure, MovieDetail>> getMovieDetail(Movie movie);
}
