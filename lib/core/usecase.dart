import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import './failures.dart';

/// CLEAN ARCHITECTURE: USE CASES
///   (Robert C. Martin)
///
/// A use case is a description of the way that an automated system is used.
/// It specifies:
///   - the input to be provided by the user,
///   - the output to be returned to the user and
///   - the processing steps involved in producing that output.
/// A use case describes application-specific business rules as opposed to the
/// Critical Business Rules within the Entities.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
