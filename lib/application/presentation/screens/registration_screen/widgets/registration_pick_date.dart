import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final void Function(DateTime) onDateSelected;
  final String hintText;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.hintText = 'dd/mm/yyyy',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : hintText,
              style: TextStyle(
                color: selectedDate != null ? Colors.black : Colors.grey,
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
    );
  }
}
