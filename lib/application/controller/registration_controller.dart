import 'dart:developer';

import 'package:ayurvedic_centre/application/presentation/screens/invoice_pdf/invoice_pdf.dart';
import 'package:ayurvedic_centre/data/service/registration_service.dart';
import 'package:ayurvedic_centre/domain/model/branch_model/branch_model.dart';
import 'package:ayurvedic_centre/domain/model/treatment_model/treatment_model.dart';
import 'package:ayurvedic_centre/domain/repo/registration_repo.dart';
import 'package:ayurvedic_centre/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle, Uint8List;

class RegistrationController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController =
      TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();

  RegistrationRepo apiService = RegistrationService();

  String? selectedLocation;
  BranchModel? selectedBranch;
  List<Treatment> selectedTreatments = [];
  bool treatmentLoading = false;
  String selectedPaymentOption = 'Cash';
  DateTime? selectedTreatmentDate;
  int? selectedHour;
  int? selectedMinute;

  final List<String> locations = [
    'Kozhikode',
    'Kochi',
    'Thiruvananthapuram',
    'Malappuram',
  ];

  List<BranchModel> branches = [];
  bool branchLoading = false;

  final List<String> paymentOptions = ['Cash', 'Card', 'UPI'];

  List<SelectedTreatmentItem> addedTreatments = [];

  void addOrUpdateTreatment(SelectedTreatmentItem item, {int? editIndex}) {
    if (editIndex != null) {
      addedTreatments[editIndex] = item;
    } else {
      addedTreatments.add(item);
    }
    notifyListeners();
  }

  void removeTreatmentItem(int index) {
    addedTreatments.removeAt(index);
    notifyListeners();
  }

  String? getTreatmentNameById(String id) {
    try {
      return selectedTreatments.firstWhere((t) => t.id.toString() == id).name;
    } catch (e) {
      return null;
    }
  }

  Future<void> getAllBranches() async {
    try {
      branchLoading = true;
      notifyListeners();

      final result = await apiService.getAllBranches();
      result.fold(
        (failure) {
          log('failure');
        },
        (success) {
          log(
            'successfully got branches: ${success.map((b) => b.name).toList()}',
          );
          log('successfull getAllBranches');
          branches = success;
          notifyListeners();
        },
      );
    } catch (e) {
      log('failure $e');
    } finally {
      branchLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllTreatments() async {
    try {
      treatmentLoading = true;
      notifyListeners();

      final result = await apiService.getAllTreatments();
      result.fold(
        (failure) {
          log('failure');
        },
        (success) {
          log('successfull getAllTreatments');
          selectedTreatments = success;
        },
      );
    } catch (e) {
      log('failure $e');
    } finally {
      treatmentLoading = false;
      notifyListeners();
    }
  }

  void addTreatment(Treatment treatment) {
    selectedTreatments.add(treatment);
    notifyListeners();
  }

  void removeTreatment(int index) {
    selectedTreatments.removeAt(index);
    notifyListeners();
  }

  void setLocation(String? value) {
    selectedLocation = value;
    notifyListeners();
  }

  void setBranch(BranchModel? value) {
    selectedBranch = value;

    notifyListeners();
  }

  void setPaymentOption(String value) {
    selectedPaymentOption = value;
    notifyListeners();
  }

  void setTreatmentDate(DateTime date) {
    selectedTreatmentDate = date;
    notifyListeners();
  }

  void setHour(int hour) {
    selectedHour = hour;
    notifyListeners();
  }

  void setMinute(int minute) {
    selectedMinute = minute;
    notifyListeners();
  }

  void calculateBalance() {
    double total = double.tryParse(totalAmountController.text) ?? 0;
    double discount = double.tryParse(discountAmountController.text) ?? 0;
    double advance = double.tryParse(advanceAmountController.text) ?? 0;
    double balance = total - discount - advance;
    balanceAmountController.text = balance.toStringAsFixed(2);
    notifyListeners();
  }

  void clear() {
    // Clear all text controllers
    nameController.clear();
    whatsappController.clear();
    addressController.clear();
    totalAmountController.clear();
    discountAmountController.clear();
    advanceAmountController.clear();
    balanceAmountController.clear();

    // Reset all selected values
    selectedLocation = null;
    selectedBranch = null;
    selectedTreatments.clear();
    addedTreatments.clear();
    selectedPaymentOption = 'Cash';
    selectedTreatmentDate = null;
    selectedHour = null;
    selectedMinute = null;
    notifyListeners();
  }

  // Add to RegistrationController
  Future<void> register() async {
    final Uint8List logoBytes = await rootBundle
        .load(logo)
        .then((data) => data.buffer.asUint8List());
    final Uint8List signImgeBytes = await rootBundle
        .load(signImage)
        .then((data) => data.buffer.asUint8List());

    List<Map<String, dynamic>> treatmentList = addedTreatments.map((treatment) {

      final treatmentModel = selectedTreatments.firstWhere(
        (t) => t.id.toString() == treatment.treatmentId,
      );

      int totalCount = treatment.maleCount + treatment.femaleCount;
      double itemTotal =
          (double.tryParse(treatmentModel.price.toString()) ?? 0) * totalCount;

      return {
        'name': treatment.treatmentName,
        'price': treatmentModel.price,
        'male': treatment.maleCount,
        'female': treatment.femaleCount,
        'total': itemTotal,
      };
    }).toList();

    // Format dates
    String bookedOn =
        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} | ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';
    String treatmentDate = selectedTreatmentDate != null
        ? '${selectedTreatmentDate!.day}/${selectedTreatmentDate!.month}/${selectedTreatmentDate!.year}'
        : '';
    String treatmentTime = selectedHour != null && selectedMinute != null
        ? '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}'
        : '';

    // Get amounts
    double total = double.tryParse(totalAmountController.text) ?? 0;
    double discount = double.tryParse(discountAmountController.text) ?? 0;
    double advance = double.tryParse(advanceAmountController.text) ?? 0;
    double balance = double.tryParse(balanceAmountController.text) ?? 0;

    // Generate PDF
    await PdfService.generateBookingPdf(
      logoImage: logoBytes,
      signImage: signImgeBytes,
      branchModel: selectedBranch!,
      patientName: nameController.text,
      address: addressController.text,
      whatsappNumber: whatsappController.text,
      bookedOn: bookedOn,
      treatmentDate: treatmentDate,
      treatmentTime: treatmentTime,
      treatments: treatmentList,
      totalAmount: total,
      discount: discount,
      advance: advance,
      balance: balance,
    );

    print('Registration submitted and PDF generated');
  }

  @override
  void dispose() {
    nameController.dispose();
    whatsappController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();
    super.dispose();
  }
}

class SelectedTreatmentItem {
  final String treatmentId;
  final String treatmentName;
  int maleCount;
  int femaleCount;

  SelectedTreatmentItem({
    required this.treatmentId,
    required this.treatmentName,
    required this.maleCount,
    required this.femaleCount,
  });
}
