import 'package:flutter/material.dart';

class RegistrationController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController = TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();
  
  String? selectedLocation;
  String? selectedBranch;
  List<Map<String, dynamic>> selectedTreatments = [];
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

  final List<String> branches = [
    'Branch 1',
    'Branch 2',
    'Branch 3',
  ];

  final List<String> paymentOptions = ['Cash', 'Card', 'UPI'];

  void addTreatment(Map<String, dynamic> treatment) {
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

  void setBranch(String? value) {
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

  void register() {
    // Implement registration logic here
    print('Registration submitted');
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