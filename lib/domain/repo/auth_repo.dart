import 'package:ayurvedic_centre/domain/model/failure/failure.dart';
import 'package:ayurvedic_centre/domain/model/login_respone/login_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo{
  Future<Either<Failure,LoginResponse>>login({required Map<String,dynamic>loginModel});
}