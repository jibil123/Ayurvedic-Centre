import 'dart:developer';
import 'package:ayurvedic_centre/core/api_end_points.dart';
import 'package:ayurvedic_centre/domain/model/failure/failure.dart';
import 'package:ayurvedic_centre/domain/model/patient_list/patient_list.dart';
import 'package:ayurvedic_centre/domain/repo/home_page_repo.dart';
import 'package:ayurvedic_centre/service/local_storage/shared_preference.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomePageService implements HomePageRepo {
  late Dio apiService;
  ApiEndPoints apiEndPoints = ApiEndPoints();

  HomePageService() {
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
  Future<Either<Failure, List<Patient>>> getPatientList() async {
    try {
      final response = await apiService.get(apiEndPoints.patientList);
      if (response.data != null && response.data['status'] == true) {
        final List<dynamic> patientJsonList = response.data['patient'] ?? [];

        // Map JSON to List<Patient>
        final List<Patient> patients = patientJsonList
            .map((patientJson) => Patient.fromJson(patientJson))
            .toList();

        return Right(patients);
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
