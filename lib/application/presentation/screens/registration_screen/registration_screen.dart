import 'package:ayurvedic_centre/application/controller/registration_controller.dart';
import 'package:ayurvedic_centre/utils/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  void _showHourPicker(
    BuildContext context,
    RegistrationController controller,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Hour',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        index.toString().padLeft(2, '0'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: controller.selectedHour == index
                              ? const Color(0xFF006B3E)
                              : Colors.black,
                          fontWeight: controller.selectedHour == index
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        controller.setHour(index);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMinutePicker(
    BuildContext context,
    RegistrationController controller,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Minutes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 60,
                  itemBuilder: (context, index) {
                    int minute = index + 1;
                    return ListTile(
                      title: Text(
                        minute.toString().padLeft(2, '0'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: controller.selectedMinute == minute
                              ? const Color(0xFF006B3E)
                              : Colors.black,
                          fontWeight: controller.selectedMinute == minute
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                      onTap: () {
                        controller.setMinute(minute);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegistrationController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Consumer<RegistrationController>(
          builder: (context, controller, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Name Field
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.nameController,
                    hintText: 'Enter your full name',
                  ),
                  const SizedBox(height: 16),

                  // WhatsApp Number Field
                  const Text(
                    'Whatsapp Number',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.whatsappController,
                    hintText: 'Enter your WhatsApp number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Address Field
                  const Text(
                    'Address',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.addressController,
                    hintText: 'Enter your full address',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  // Location Dropdown
                  const Text(
                    'Location',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
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
                  const Text(
                    'Branch',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
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
                        value: controller.selectedBranch,
                        isExpanded: true,
                        hint: const Text(
                          'Select the branch',
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: controller.branches.map((String branch) {
                          return DropdownMenuItem<String>(
                            value: branch,
                            child: Text(branch),
                          );
                        }).toList(),
                        onChanged: controller.setBranch,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Treatments Section
                  const Text(
                    'Treatments',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),

                  // Treatment Item
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF006B3E),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Couple Combo package i...',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF006B3E),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF006B3E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                          onPressed: () {},
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Add Treatments Button
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xFF006B3E),
                      size: 18,
                    ),
                    label: const Text(
                      'Add Treatments',
                      style: TextStyle(
                        color: Color(0xFF006B3E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  ),
                  const SizedBox(height: 16),

                  // Total Amount Field
                  const Text(
                    'Total Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.totalAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.calculateBalance(),
                  ),
                  const SizedBox(height: 16),

                  // Discount Amount Field
                  const Text(
                    'Discount Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.discountAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.calculateBalance(),
                  ),
                  const SizedBox(height: 16),

                  // Payment Option - Radio Buttons
                  const Text(
                    'Payment Option',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: controller.paymentOptions.map((option) {
                      return Expanded(
                        child: RadioListTile<String>(
                          title: Text(
                            option,
                            style: const TextStyle(fontSize: 14),
                          ),
                          value: option,
                          groupValue: controller.selectedPaymentOption,
                          activeColor: const Color(0xFF006B3E),
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          onChanged: (value) {
                            if (value != null) {
                              controller.setPaymentOption(value);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Advance Amount Field
                  const Text(
                    'Advance Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.advanceAmountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => controller.calculateBalance(),
                  ),
                  const SizedBox(height: 16),

                  // Balance Amount Field
                  const Text(
                    'Balance Amount',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: controller.balanceAmountController,
                    keyboardType: TextInputType.number,
                    // readOnly: true,
                  ),
                  const SizedBox(height: 16),

                  // Treatment Date
                  const Text(
                    'Treatment Date',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        controller.setTreatmentDate(date);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedTreatmentDate != null
                                ? '${controller.selectedTreatmentDate!.day}/${controller.selectedTreatmentDate!.month}/${controller.selectedTreatmentDate!.year}'
                                : 'dd/mm/yyyy',
                            style: TextStyle(
                              color: controller.selectedTreatmentDate != null
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Treatment Time
                  const Text(
                    'Treatment Time',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showHourPicker(context, controller),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedHour != null
                                      ? controller.selectedHour!
                                            .toString()
                                            .padLeft(2, '0')
                                      : '00',
                                  style: TextStyle(
                                    color: controller.selectedHour != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _showMinutePicker(context, controller),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedMinute != null
                                      ? controller.selectedMinute!
                                            .toString()
                                            .padLeft(2, '0')
                                      : 'Minutes',
                                  style: TextStyle(
                                    color: controller.selectedMinute != null
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006B3E),
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
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
