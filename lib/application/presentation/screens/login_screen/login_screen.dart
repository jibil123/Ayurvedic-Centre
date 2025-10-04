import 'package:ayurvedic_centre/application/controller/auth_controller.dart';
import 'package:ayurvedic_centre/utils/colors/colors.dart';
import 'package:ayurvedic_centre/utils/constants/constants.dart';
import 'package:ayurvedic_centre/utils/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image(
                        image: AssetImage(loginScreenImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(child: Image(image: AssetImage(logo))),
                  ],
                ),
              ),
              // SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login Or Register To Book\nYour Appointments',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('  Email',style: TextStyle(fontSize: 17),),
                    SizedBox(height: 5),
                    CustomTextFormField(
                      removeErrorOnType: true,
                      hintText: 'Enter your email',
                      controller: context
                          .read<AuthController>()
                          .emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    Text('  Password',style: TextStyle(fontSize: 17),),
                    SizedBox(height: 5),
                    CustomTextFormField(
                      removeErrorOnType: true,
                      hintText: 'Enter password',
                      controller: context
                          .read<AuthController>()
                          .passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Password is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 70.h),
                    GestureDetector(
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          context.read<AuthController>().login(context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 45.h),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 20, right: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black, // default text color
                    ),
                    children: [
                      const TextSpan(
                        text:
                            'By creating or logging into an account you are agreeing\nwith our ',
                      ),
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: const TextStyle(
                          color: Colors.blueAccent, // make it blue
                          fontWeight: FontWeight.bold,
                        ),
                        // You can add gesture recognizer to make it clickable
                        // recognizer: TapGestureRecognizer()..onTap = () { /* navigate */ },
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: Colors.blueAccent, // make it blue
                          fontWeight: FontWeight.bold,
                        ),
                        // recognizer: TapGestureRecognizer()..onTap = () { /* navigate */ },
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
