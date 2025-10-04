import 'package:ayurvedic_centre/application/controller/home_page_controller.dart';
import 'package:ayurvedic_centre/application/presentation/screens/home_screen/home_screen.dart';
import 'package:ayurvedic_centre/application/presentation/screens/login_screen/login_screen.dart';
import 'package:ayurvedic_centre/service/local_storage/shared_preference.dart';
import 'package:ayurvedic_centre/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  Future<void> checkLoginStatus() async {
    final isLogged = await SharedPreference.isLogedOrNot();
    // Wait a little for splash effect (optional)
    await Future.delayed(const Duration(seconds: 2));

    // if (isLogged) {
    //   context.read<HomePageController>().getPatientList();
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => const HomeScreen()),
    //   );
    // } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashScreenImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
