import 'package:flutter/material.dart';

class RegistrationAppBar extends StatelessWidget {
  const RegistrationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 30),
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
        ),
      ],
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 15),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: const Text(
              'Register',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey[300], // divider color
          height: 1,
        ),
      ),
    );
  }
}
