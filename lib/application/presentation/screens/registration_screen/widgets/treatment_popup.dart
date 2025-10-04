import 'package:ayurvedic_centre/application/controller/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Dialog Widget
class TreatmentSelectionDialog extends StatefulWidget {
  final int? editIndex;
  final SelectedTreatmentItem? editItem;

  const TreatmentSelectionDialog({super.key, this.editIndex, this.editItem});

  @override
  State<TreatmentSelectionDialog> createState() =>
      _TreatmentSelectionDialogState();
}

class _TreatmentSelectionDialogState extends State<TreatmentSelectionDialog> {
  String? selectedTreatmentId;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.editItem != null) {
      selectedTreatmentId = widget.editItem!.treatmentId;
      maleCount = widget.editItem!.maleCount;
      femaleCount = widget.editItem!.femaleCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationController>(
      builder: (context, controller, child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 340,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Treatment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedTreatmentId,
                    decoration: const InputDecoration(
                      hintText: 'Choose preferred treatment',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF006837),
                      ),
                    ),
                    dropdownColor: Colors.white,

                    isExpanded: true,
                    items: controller.selectedTreatments.map((treatment) {
                      return DropdownMenuItem<String>(
                        value: treatment.id.toString(),
                        child: Text(
                          treatment.name,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTreatmentId = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Add Patients',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPatientCounter(
                  label: 'Male',
                  count: maleCount,
                  onDecrement: () {
                    if (maleCount > 0) {
                      setState(() {
                        maleCount--;
                      });
                    }
                  },
                  onIncrement: () {
                    setState(() {
                      maleCount++;
                    });
                  },
                ),
                const SizedBox(height: 12),
                _buildPatientCounter(
                  label: 'Female',
                  count: femaleCount,
                  onDecrement: () {
                    if (femaleCount > 0) {
                      setState(() {
                        femaleCount--;
                      });
                    }
                  },
                  onIncrement: () {
                    setState(() {
                      femaleCount++;
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedTreatmentId != null) {
                        final treatmentName = controller.getTreatmentNameById(
                          selectedTreatmentId!,
                        );
                        if (treatmentName != null) {
                          final item = SelectedTreatmentItem(
                            treatmentId: selectedTreatmentId!,
                            treatmentName: treatmentName,
                            maleCount: maleCount,
                            femaleCount: femaleCount,
                          );
                          controller.addOrUpdateTreatment(
                            item,
                            editIndex: widget.editIndex,
                          );
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006837),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientCounter({
    required String label,
    required int count,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
        SizedBox(width: 20,),
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFF006837),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onDecrement,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, color: Colors.white, size: 20),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 50,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFF006837),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onIncrement,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }
}
