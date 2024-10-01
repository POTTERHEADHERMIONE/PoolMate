import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poolmate/presentation/constants/constants.dart';
import 'package:poolmate/presentation/detail/newRoom.dart';
import 'package:poolmate/presentation/detail/profile.dart';
import 'package:poolmate/presentation/screens/register_page.dart';
import 'package:poolmate/presentation/widgets/my_text_button.dart';
import 'package:poolmate/presentation/detail/chat.dart'; 

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ScrollController _scrollController = ScrollController();
  List<int> _roomNumbers = List.generate(6, (index) => index + 1);
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoadingMore) {
      _loadMoreRooms();
    }
  }

  Future<void> _loadMoreRooms() async {
    setState(() {
      _isLoadingMore = true;
    });

    // Simulate a network call or data fetching
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      int currentLength = _roomNumbers.length;
      _roomNumbers.addAll(List.generate(6, (index) => currentLength + index + 1));
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back press
          },
        ),
        title: Text(
          'Search Room',
          style: TextStyle(
            fontFamily: 'SearchRoomFont', // use a custom font if required
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          controller: _scrollController, // Attach the controller
          itemCount: _roomNumbers.length + (_isLoadingMore ? 1 : 0), // Add one for the loading indicator
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Adjust this value to change card aspect ratio
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            if (index < _roomNumbers.length) {
              return RoomCard(roomNumber: _roomNumbers[index]);
            } else {
              // Show loading indicator
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.directions_car),
                onPressed: () {
                  // Handle navigation action
                },
              ),
              IconButton(
                icon: Icon(Icons.bolt),
                onPressed: () {
                  // Handle lightning action
                },
              ),
              SizedBox(width: 50), // Spacer for the floating button
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  // Handle filter action
                },
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                   Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => UserProfilePage(), // Navigate to AddPage
      ),
    );
                  
                  // Handle profile action
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CreateRoomPage(), // Navigate to AddPage
      ),
    );
  },
  child: Icon(Icons.add),
),

    );
  }
}

class RoomCard extends StatelessWidget {
  final int roomNumber;

  const RoomCard({Key? key, required this.roomNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, // Set a fixed height for the card
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Color(0xFF2B2B2B),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust main axis alignment
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.black87,
                child: Text(
                  '$roomNumber',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8), // Adjusted height
              Text(
                'Source Address to Destination Address',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Added to handle overflow
                maxLines: 1, // Limits to one line
              ),
              SizedBox(height: 16), // Adjusted height
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: kBodyText.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8), // Adjusted height
              MyTextButton(
                buttonName: 'Join',
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ChatPage(title: 'Chat'),
                    ),
                  );
                },
                bgColor: Colors.white,
                textColor: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
