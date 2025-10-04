  import 'package:ayurvedic_centre/application/controller/registration_controller.dart';
import 'package:flutter/material.dart';

void showHourPicker(
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

  void showMinutePicker(
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