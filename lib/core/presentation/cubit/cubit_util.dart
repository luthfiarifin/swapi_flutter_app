import 'package:dartz/dartz.dart';

import '../../data/error/error.dart';

class CubitUtil {
  static Future<void> fetchData<T>({
    required Function() onLoading,
    required Function(Failure) onError,
    required Function(T) onSuccess,
    required Future<Either<Failure, T>> Function() useCaseFunction,
  }) async {
    onLoading();

    final result = await useCaseFunction();

    result.fold(
      (failure) => onError(failure),
      (data) => onSuccess(data),
    );
  }
}
