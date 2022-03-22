// ignore_for_file: one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:movie_flutter/core/domain/failures/failure.dart';
import 'package:movie_flutter/features/movie/domain/entities/movie.dart';

abstract class MovieSessionContract {
  Future<Either<Failure, Movie>> getRecentlyWatched();
}
