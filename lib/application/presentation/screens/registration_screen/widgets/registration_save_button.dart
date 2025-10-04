import 'package:flutter/material.dart';
import 'package:ayurvedic_centre/utils/colors/colors.dart';
import 'package:ayurvedic_centre/application/controller/registration_controller.dart';

class SaveButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RegistrationController controller;

  const SaveButton({
    super.key,
    required this.formKey,
    required this.controller,
  });

  void _handleSave(BuildContext context) {
    if (formKey.currentState!.validate() &&
        controller.addedTreatments.isNotEmpty &&
        controller.selectedTreatmentDate != null &&
        controller.selectedHour != null &&
        controller.selectedMinute != null &&
        controller.selectedLocation != null &&
        controller.selectedBranch != null) {
      controller.register();
    } else {
      List<String> missingFields = [];

      if (controller.addedTreatments.isEmpty) missingFields.add("Treatment");
      if (controller.selectedTreatmentDate == null) missingFields.add("Treatment Date");
      if (controller.selectedHour == null) missingFields.add("Hour");
      if (controller.selectedMinute == null) missingFields.add("Minute");
      if (controller.selectedLocation == null) missingFields.add("Location");
      if (controller.selectedBranch == null) missingFields.add("Branch");

      String message = "Please fill: ${missingFields.join(', ')}";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleSave(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
