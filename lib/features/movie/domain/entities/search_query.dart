import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_flutter/features/movie/domain/entities/value_objects.dart';
part 'search_query.freezed.dart';

@freezed
class SearchQuery with _$SearchQuery {
  const factory SearchQuery({
    required Title title,
  }) = _SearchQuery;
}
