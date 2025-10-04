import 'package:ayurvedic_centre/application/controller/home_page_controller.dart';
import 'package:ayurvedic_centre/application/controller/registration_controller.dart';
import 'package:ayurvedic_centre/application/presentation/screens/home_screen/widgets/home_page_container.dart';
import 'package:ayurvedic_centre/application/presentation/screens/home_screen/widgets/shimmer_widget.dart';
import 'package:ayurvedic_centre/application/presentation/screens/registration_screen/registration_screen.dart';
import 'package:ayurvedic_centre/domain/model/patient_list/patient_list.dart';
import 'package:ayurvedic_centre/utils/colors/colors.dart';
import 'package:ayurvedic_centre/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sortBy = 'Date';
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomePageController>();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<HomePageController>().getPatientList();
        },
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_outlined,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search and Sort Section
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                child: Column(
                  children: [
                    // Search Bar
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 43,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                isDense: true, // makes the field more compact

                                hintText: 'Search for treatments',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  size: 25,
                                  Icons.search,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF006B3E),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        GestureDetector(
                          onTap: () {
                            // Handle search action
                          },
                          child: Container(
                            height: 40, // control height here
                            width: 80, // control width here
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Sort By
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sort by :',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 160, // increase width here
                          // height: 40, // reduce height here
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.all(8),
                            value: sortBy,
                            isDense: true, // reduces default vertical padding
                            isExpanded: true, // makes text take full width
                            underline: const SizedBox(),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 25,
                              color: primaryColor,
                            ),
                            items: ['Date', 'Name', 'Treatment'].map((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  sortBy = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              Divider(color: Colors.grey[400]),
              // Bookings List
              Expanded(
                child: homeController.isLoading
                    ? ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: const ShimmerWidget(
                              width: double.infinity,
                              height: 200,
                            ),
                          );
                        },
                      )
                    : (homeController.patients == null ||
                          homeController.patients!.isEmpty)
                    ? ListView.builder(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                          top: 5,
                        ),
                        itemCount: emptyImages.length,
                        itemBuilder: (context, index) {
                          final images = emptyImages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Text('There is no patient list'),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: homeController.patients!.length,
                        itemBuilder: (context, index) {
                          final patient = homeController.patients![index];
                          final details =
                              patient.patientDetailsSet?.isNotEmpty == true
                              ? patient.patientDetailsSet!.first
                              : null;

                          return HomePageContainer(
                            patient: patient,
                            details: details,
                            index: index,
                          );
                        },
                      ),
              ),

              // Register Now Button
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  top: false,
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<RegistrationController>().clear();
                      await context
                          .read<RegistrationController>()
                          .getAllBranches();
                      await context
                          .read<RegistrationController>()
                          .getAllTreatments();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Consumer<RegistrationController>(
                      builder: (context, controller, _) {
                        return controller.branchLoading ||
                                controller.treatmentLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
