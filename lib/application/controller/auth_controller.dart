import 'dart:developer';

import 'package:ayurvedic_centre/application/controller/home_page_controller.dart';
import 'package:ayurvedic_centre/application/presentation/screens/home_screen/home_screen.dart';
import 'package:ayurvedic_centre/data/service/auth_service.dart';
import 'package:ayurvedic_centre/domain/repo/auth_repo.dart';
import 'package:ayurvedic_centre/service/local_storage/shared_preference.dart';
import 'package:ayurvedic_centre/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  AuthRepo authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> login(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      print('login called');
      final result = await authService.login(
        loginModel: {
          'username': emailController.text,
          'password': passwordController.text,
        },
      );
      result.fold(
        (failure) {
          isLoading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('invalid user name or password'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(10),
              duration: const Duration(seconds: 3),
            ),
          );
        },
        (success) async {
          isLoading = false;
          notifyListeners();
          log('login success');
          print("tokennn ${success.token}");
          await SharedPreference.saveToken(tokenData: success.token ?? 'hey');
          log('added to shared preference');
          print('authantication successful');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Authantification successfully done'),
              backgroundColor: primaryColor,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(10),
              duration: const Duration(seconds: 3),
            ),
          );
          context.read<HomePageController>().getPatientList();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false,
          );
        },
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
        ),
      );
      print('e main failure');
    }
  }
}
