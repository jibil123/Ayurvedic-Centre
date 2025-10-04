import 'package:ayurvedic_centre/core/api_end_points.dart';
import 'package:ayurvedic_centre/domain/model/failure/failure.dart';
import 'package:ayurvedic_centre/domain/model/login_respone/login_response.dart';
import 'package:ayurvedic_centre/domain/repo/auth_repo.dart';
import 'package:ayurvedic_centre/service/local_storage/shared_preference.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthService implements AuthRepo {
  Dio apiService = Dio(
    BaseOptions(
      baseUrl: ApiEndPoints.baseUrl,
      connectTimeout: const Duration(
        seconds: 10,
      ), // wait 10s before connection timeout
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  ApiEndPoints apiEndPoints = ApiEndPoints();
  @override
  Future<Either<Failure, LoginResponse>> login({
    required Map<String, dynamic> loginModel,
  }) async {
    try {
      print('service called');

      final formData = FormData.fromMap(loginModel);

      // Print full URL
      final fullUrl = '${apiService.options.baseUrl}${apiEndPoints.login}';
      print('POST URL: $fullUrl');

      // Print data being sent
      print('Request Data: ${loginModel.toString()}');

      final response = await apiService.post(
        apiEndPoints.login,
        data: formData,
      );
      if (response.data != null && response.data['status'] == true) {
        print('Response Data: ${response.data}');

        return Right(LoginResponse.fromJson(response.data));
      } else {
        return Left(
          Failure(message: response.data['message'] ?? 'something went wrong'),
        );
      }
    } catch (e) {
      print('Error: $e');
      return Left(Failure(message: 'Something went wrong'));
    }
  }
}
