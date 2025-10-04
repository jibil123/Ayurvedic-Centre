import 'package:ayurvedic_centre/domain/model/branch_model/branch_model.dart';
import 'package:ayurvedic_centre/domain/model/failure/failure.dart';
import 'package:ayurvedic_centre/domain/model/treatment_model/treatment_model.dart';
import 'package:dartz/dartz.dart';

abstract class RegistrationRepo {
  Future<Either<Failure, List<BranchModel>>> getAllBranches();
  Future<Either<Failure, List<Treatment>>> getAllTreatments();
}
