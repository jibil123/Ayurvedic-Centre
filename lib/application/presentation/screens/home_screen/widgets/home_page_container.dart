import 'package:ayurvedic_centre/domain/model/patient_list/patient_list.dart';
import 'package:flutter/material.dart';

class HomePageContainer extends StatelessWidget {
  const HomePageContainer({
    super.key,
    required this.index,
    required this.patient,
    required this.details,
  });
  final int index;
  final Patient patient;
  final PatientDetail? details;

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    } catch (e) {
      return dateStr; // fallback in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 225, 231, 223),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 20, top: 20),
            child: Text(
              "${index + 1}.  ${(patient.name == null || patient.name!.trim().isEmpty) ? 'Unknown' : patient.name}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 20),
            child: Text(
              details?.treatmentName ?? "No treatment",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF006B3E), fontSize: 17),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 17,
                  color: Color.fromARGB(255, 212, 49, 49),
                ),
                const SizedBox(width: 4),
                Text(
                  patient.dateNdTime != null
                      ? _formatDate(patient.dateNdTime!)
                      : "N/A",
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),

                const SizedBox(width: 16),
                Image.asset(
                  'asset/icons/f7_person-2.png',
                  width: 22,
                  height: 22,
                  color: Colors.red, // optional, applies color tint if needed
                ),
                const SizedBox(width: 4),
                Text(
                  patient.branch?.name ?? "Unknown branch",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 3),
          Divider(),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  'View Booking details',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF006B3E),
                  size: 26,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
