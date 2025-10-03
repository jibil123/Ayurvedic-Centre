import 'package:ayurvedic_centre/application/controller/auth_controller.dart';
import 'package:ayurvedic_centre/utils/constants/constants.dart';
import 'package:ayurvedic_centre/utils/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height:  20),
                Text('Email'),
                SizedBox(height: 5),
                CustomTextFormField(hintText: 'Enter your email'),
                SizedBox(height: 30),
                Text('Password'),
                SizedBox(height: 5),
                CustomTextFormField(hintText: 'Enter your email'),
                SizedBox(height: 70.h),
                GestureDetector(
                  onTap: () {
                    context.read<AuthController>().login(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 9, 111, 13),
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
                SizedBox(height: 50.h),
                
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 20,right: 20),
              child: Text(
                      'By creating or logging into an account you are agreeing\nwith our Terms and Conditions and Privacy Policy.',
                      style: TextStyle(fontSize: 13),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
