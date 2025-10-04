import 'dart:developer';

import 'package:ayurvedic_centre/application/controller/home_page_controller.dart';
import 'package:ayurvedic_centre/application/presentation/screens/home_screen/home_screen.dart';
import 'package:ayurvedic_centre/data/service/auth_service.dart';
import 'package:ayurvedic_centre/domain/repo/auth_repo.dart';
import 'package:ayurvedic_centre/service/local_storage/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController extends ChangeNotifier {
  AuthRepo authService = AuthService();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final formKey= GlobalKey<FormState>();
  Future<void> login(BuildContext context) async {
    try {
      print('login called');
      final result = await authService.login(
        loginModel: {'username': emailController.text, 'password': passwordController.text},
      );
      result.fold(
        (failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('invalid user name or password')));
        },
        (success) async {
          log('login success');
          print("tokennn ${success.token}");
          await SharedPreference.saveToken(tokenData: success.token ?? 'hey');
          log('added to shared preference');
          print('authantication successful');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('authantication successfull')));
          context.read<HomePageController>().getPatientList();
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Somethig went wrong')));
      print('e main failure');
    }
  }
}
