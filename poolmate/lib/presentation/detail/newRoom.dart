import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:poolmate/presentation/constants/constants.dart';
import 'package:poolmate/presentation/widgets/text_field.dart';

class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Room', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Implement settings action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Positioned(
                child: FadeInRightBig(
                  child: Image.asset(
                    'assets/images/cybertruck-mod-black2 1.png',
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildInputField(Icons.location_on, 'Source Address'),
                    const SizedBox(height: 16),
                    _buildInputField(Icons.location_on, 'Destination Address'),
                    const SizedBox(height: 16),
                    _buildInputField(Icons.access_time, 'Estimated Start Time'),
                    const SizedBox(height: 16),
                    _buildInputField(Icons.attach_money, 'Estimated Cost'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement create room logic
                        Navigator.pop(context, true); // Return true to indicate room creation
                      },
                      child: const Text('Create Room'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF2A2A2A),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.directions_car, color: Colors.blue),
              onPressed: () {
                // TODO: Implement navigation action
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                // TODO: Implement navigation action
              },
            ),
            const SizedBox(width: 48), // Space for FAB
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // TODO: Implement navigation action
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                // TODO: Implement navigation action
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement main action
        },
        child: const Icon(Icons.list),
        backgroundColor: const Color(0xFF2A2A2A),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildInputField(IconData icon, String placeholder, {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: kBodyText.copyWith(color: Colors.white),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(icon, color: Colors.blue),
          hintText: placeholder,
          hintStyle: kBodyText.copyWith(color: Colors.grey[600]),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          filled: true,
          fillColor: const Color(0xFF3A3A3A),
        ),
      ),
    );
  }
}