import 'package:ayurvedic_centre/domain/model/failure/failure.dart';
import 'package:ayurvedic_centre/domain/model/patient_list/patient_list.dart';
import 'package:dartz/dartz.dart';

abstract class HomePageRepo {
  Future<Either<Failure,List<Patient>>>getPatientList();
}