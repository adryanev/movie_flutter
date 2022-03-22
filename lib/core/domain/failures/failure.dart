import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.localFailure({
    required String message,
  }) = MovieLocalFailure;
  const factory Failure.serverFailure({
    required String message,
  }) = MovieServerFailure;
}
