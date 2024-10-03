import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poolmate/presentation/constants/constants.dart';
import 'package:poolmate/presentation/detail/dashboard.dart';
import 'package:poolmate/presentation/detail/newRoom.dart';
import 'package:poolmate/presentation/detail/profile.dart';
import 'package:poolmate/presentation/screens/register_page.dart';
import "package:poolmate/presentation/widgets/my_text_button.dart";
import 'package:poolmate/presentation/detail/chat.dart';
import 'package:poolmate/presentation/widgets/testfiled_room.dart';
import 'package:poolmate/presentation/widgets/text_field.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _currentIndex = 0; // For bottom navigation
  List<AddressCard> cards = [];

  // Methods to add, edit, delete cards remain the same
  void _addNewCard() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String sourceAddress = '';
        String destinationAddress = '';

        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Text('Add New Card', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildInputField('Source Address', (value) {
                  sourceAddress = value;
                }),
                const SizedBox(height: 20),
                _buildInputField('Destination Address', (value) {
                  destinationAddress = value;
                }),
              ],
            ),
          ),
          actions: <Widget>[
            MyTextButton(
                buttonName: 'Cancel',
                onTap: () {
                  Navigator.of(context).pop();
                },
                bgColor: Colors.black,
                textColor: Colors.white),
            const SizedBox(height: 20),
            MyTextButton(
                buttonName: 'Add',
                onTap: () {
                  setState(() {
                    cards.add(AddressCard(
                      sourceAddress: sourceAddress,
                      destinationAddress: destinationAddress,
                    ));
                  });
                  Navigator.of(context).pop();
                },
                bgColor: Colors.black,
                textColor: Colors.white),
          ],
        );
      },
    );
  }

  void _editCard(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String sourceAddress = cards[index].sourceAddress;
        String destinationAddress = cards[index].destinationAddress;

        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Text('Edit Card', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildInputField(sourceAddress, (value) {
                  sourceAddress = value;
                }),
                const SizedBox(height: 20),
                _buildInputField(destinationAddress, (value) {
                  destinationAddress = value;
                }),
              ],
            ),
          ),
          actions: <Widget>[
            MyTextButton(
                buttonName: 'Cancel',
                onTap: () {
                  Navigator.of(context).pop();
                },
                bgColor: Colors.black,
                textColor: Colors.white),
            const SizedBox(height: 20),
            MyTextButton(
                buttonName: 'Save',
                onTap: () {
                  setState(() {
                    cards[index] = AddressCard(
                      sourceAddress: sourceAddress,
                      destinationAddress: destinationAddress,
                    );
                  });
                  Navigator.of(context).pop();
                },
                bgColor: Colors.black,
                textColor: Colors.white),
          ],
        );
      },
    );
  }

  Widget _buildInputField(String hintText, Function(String) onChanged) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      style: const TextStyle(fontSize: 14, color: Colors.white),
      cursorWidth: 2.0,
      cursorColor: Colors.blue,
      onChanged: onChanged,
    );
  }

  void _deleteCard(int index) {
    setState(() {
      cards.removeAt(index);
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate based on the index or add a new card for New Room
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ChatPage(title: 'Chat Room',)));
        break;
      case 1:
        _addNewCard(); // Open the dialog to add a new card
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Cards'),
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(cards[index].sourceAddress),
              subtitle: Text(cards[index].destinationAddress),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editCard(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteCard(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF2A2A2A),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onTabTapped,
          currentIndex: _currentIndex, // This will be set when a new tab is tapped
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'New Room',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class AddressCard {
  String sourceAddress;
  String destinationAddress;

  AddressCard({required this.sourceAddress, required this.destinationAddress});
}
