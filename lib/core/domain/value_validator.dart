import 'package:dartz/dartz.dart';
import 'package:movie_flutter/core/domain/value_failure.dart';

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiLine(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<T>, T> validateNumberRange<T extends num>({
  required T minimum,
  required T maximum,
  required T number,
}) {
  if (number > maximum || number < minimum) {
    return left(
      ValueFailure.notInRange(
        failedValue: number,
        minimum: minimum,
        maximum: maximum,
      ),
    );
  } else {
    return right(number);
  }
}
