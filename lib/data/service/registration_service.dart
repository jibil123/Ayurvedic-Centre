import 'dart:developer';

import 'package:ayurvedic_centre/core/api_end_points.dart';
import 'package:ayurvedic_centre/domain/model/branch_model/branch_model.dart';
import 'package:ayurvedic_centre/domain/model/failure/failure.dart';
import 'package:ayurvedic_centre/domain/model/treatment_model/treatment_model.dart';
import 'package:ayurvedic_centre/domain/repo/registration_repo.dart';
import 'package:ayurvedic_centre/service/local_storage/shared_preference.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RegistrationService implements RegistrationRepo {
  late Dio apiService;
  ApiEndPoints apiEndPoints = ApiEndPoints();

  RegistrationService() {
    apiService = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));

    apiService.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await SharedPreference.getToken(); // 👈 fetch token here
          if (token.isNotEmpty) {
            log(token);
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );

    apiService.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  @override
  Future<Either<Failure, List<BranchModel>>> getAllBranches() async {
    try {
      final response = await apiService.get(apiEndPoints.branchList);
      if (response.data != null && response.data['status'] == true) {
        final List<dynamic> branchesJsonList = response.data['branches'] ?? [];

        // Map JSON to List<Patient>
        final List<BranchModel> branches = branchesJsonList
            .map((branchJston) => BranchModel.fromJson(branchJston))
            .toList();

        return Right(branches);
      } else {
        return Left(
          Failure(message: response.data['message'] ?? 'No data found'),
        );
      }
    } on DioException catch (e) {
      print('Error: $e');
      return Left(Failure(message: 'Something went wrong'));
    } catch (e) {
      print('Error: $e');
      return Left(Failure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<Treatment>>> getAllTreatments() async {
    try {
      final response = await apiService.get(apiEndPoints.treatmentList);
      if (response.data != null && response.data['status'] == true) {
        final List<dynamic> treatmentJsonList =
            response.data['treatments'] ?? [];

        // Map JSON to List<Patient>
        final List<Treatment> treatments = treatmentJsonList
            .map((treatmentJson) => Treatment.fromJson(treatmentJson))
            .toList();

        return Right(treatments);
      } else {
        return Left(
          Failure(message: response.data['message'] ?? 'No data found'),
        );
      }
    } on DioException catch (e) {
      print('Error: $e');
      return Left(Failure(message: 'Something went wrong'));
    } catch (e) {
      print('Error: $e');
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
