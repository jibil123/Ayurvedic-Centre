import 'dart:developer';

import 'package:ayurvedic_centre/data/service/home_page_service.dart';
import 'package:ayurvedic_centre/domain/model/patient_list/patient_list.dart';
import 'package:ayurvedic_centre/domain/repo/home_page_repo.dart';
import 'package:flutter/material.dart';

class HomePageController extends ChangeNotifier {
  HomePageRepo apiService = HomePageService();
  List<Patient>? patients;
  bool isLoading = false;

  Future<void> getPatientList() async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await apiService.getPatientList();
      result.fold(
        (failure) {
          log('failure');
          patients = [];
        },
        (success) {
          log('successfull getPatientList');
          patients = success;
        },
      );
    } catch (e) {
      log('failure $e');
      patients = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
