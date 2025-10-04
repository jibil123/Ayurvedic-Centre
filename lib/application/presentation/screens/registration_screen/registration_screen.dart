import 'dart:developer';
import 'package:ayurvedic_centre/application/controller/registration_controller.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/widgets/hour_and_minutes_widget.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/widgets/registration_app_bar.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/widgets/registration_pick_date.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/widgets/registration_save_button.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/widgets/treatment_card.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/widgets/treatment_popup.dart';
import 'package:ayurvedic_centre/domain/model/branch_model/branch_model.dart';
import 'package:ayurvedic_centre/utils/colors/colors.dart';
import 'package:ayurvedic_centre/utils/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110), // set your custom height
        child: RegistrationAppBar(),
      ),
      body: Consumer<RegistrationController>(
        builder: (context, controller, child) {
          log("length branch ${controller.branches.length.toString()}");
          log(
            "length treatment ${controller.selectedTreatments.length.toString()}",
          );
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),

                  // Name Field
                  textLabel(label: 'Name'),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    controller: controller.nameController,
                    hintText: 'Enter your full name',
                  ),
                  const SizedBox(height: 16),

                  // WhatsApp Number Field
                  textLabel(label: 'Whatsapp Number'),

                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    controller: controller.whatsappController,
                    hintText: 'Enter your WhatsApp number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Whatsapp number is required';
                      } else if (value.trim().length != 10) {
                        return 'Whatsapp number must be 10 digits';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                        return 'Only numeric digits are allowed';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Address Field
                  textLabel(label: 'Address'),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Address no requried'
                        : null,
                    controller: controller.addressController,
                    hintText: 'Enter your full address',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  // Location Dropdown
                  textLabel(label: 'Location'),

                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 30,
                          color: primaryColor,
                        ),
                        value: controller.selectedLocation,
                        isExpanded: true,
                        hint: const Text(
                          'Choose your location',
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: controller.locations.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: controller.setLocation,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Branch Dropdown
                  textLabel(label: 'Branch'),

                  const SizedBox(height: 8),
                  controller.branchLoading
                      ? const Center(child: CircularProgressIndicator())
                      : controller.branches.isEmpty
                      ? const Text('No branches found')
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<BranchModel>(
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 30,
                                color: primaryColor,
                              ),
                              value: controller.selectedBranch,
                              isExpanded: true,
                              hint: const Text(
                                'Select the branch',
                                style: TextStyle(color: Colors.grey),
                              ),
                              items: controller.branches.map((branch) {
                                return DropdownMenuItem<BranchModel>(
                                  value: branch,
                                  child: Text(branch.name),
                                );
                              }).toList(),
                              onChanged: controller.setBranch,
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),

                  // Treatments Section
                  textLabel(label: 'Treatments'),
                  const SizedBox(height: 5),
                  if (controller.addedTreatments.isNotEmpty)
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.addedTreatments.length,
                        itemBuilder: (context, index) {
                          final item = controller.addedTreatments[index];
                          return TreatmentCard(
                            index: index,
                            item: item,
                            onEdit: () {
                              showDialog(
                                context: context,
                                builder: (context) => TreatmentSelectionDialog(
                                  editIndex: index,
                                  editItem: item,
                                ),
                              );
                            },
                            onDelete: () {
                              controller.removeTreatmentItem(index);
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 12),

                  // Add Treatments Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return TreatmentSelectionDialog();
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          75,
                          120,
                          233,
                          139,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, color: Colors.black, size: 18),
                          const Text(
                            'Add Treatments',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Total Amount Field
                  textLabel(label: 'Total Amount'),

                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Total amount is requried'
                        : null,
                    controller: controller.totalAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.calculateBalance(),
                  ),
                  const SizedBox(height: 16),

                  // Discount Amount Field
                  textLabel(label: 'Discount Amount'),

                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Discoutn amountn is requried'
                        : null,
                    controller: controller.discountAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.calculateBalance(),
                  ),
                  const SizedBox(height: 16),

                  // Payment Option - Radio Buttons
                  textLabel(label: 'Payment Option'),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // distributes items across full width
                    children: controller.paymentOptions.map((option) {
                      return GestureDetector(
                        onTap: () => controller.setPaymentOption(option),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: option,
                              groupValue: controller.selectedPaymentOption,
                              onChanged: (value) {
                                if (value != null)
                                  controller.setPaymentOption(value);
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                horizontal: -4,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(option, style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Advance Amount Field
                  textLabel(label: 'Advance Amount'),

                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Advance amount is requried'
                        : null,
                    controller: controller.advanceAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.calculateBalance(),
                  ),
                  const SizedBox(height: 16),

                  // Balance Amount Field
                  textLabel(label: 'Balance Amount'),

                  const SizedBox(height: 8),
                  CustomTextFormField(
                    removeErrorOnType: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Balance amount is requried'
                        : null,
                    controller: controller.balanceAmountController,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),

                  // Treatment Date
                  textLabel(label: 'Treatment Date'),

                  const SizedBox(height: 8),
                  DatePickerField(
                    selectedDate: controller.selectedTreatmentDate,
                    onDateSelected: controller.setTreatmentDate,
                  ),

                  const SizedBox(height: 16),

                  // Treatment Time
                  textLabel(label: 'Treatment Time'),
                  const SizedBox(height: 8),
                  TreatmentTimePicker(controller: controller),
                  const SizedBox(height: 32),

                  // Save Button
                  SaveButton(formKey: formKey, controller: controller),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text textLabel({required String label}) {
    return Text(
      '  ${label}',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}
