import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:intl/intl.dart'; // Make sure to add intl as a dependency in pubspec.yaml

class ChatPage extends StatefulWidget {
  final String title;

  const ChatPage({Key? key, required this.title}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(
          0,
          ChatMessage(
            text: text,
            isMe: true,
            timestamp: DateTime.now(),
          ));
    });

    // Mock reply
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.insert(
            0,
            ChatMessage(
              text: "This is a mock reply to: $text",
              isMe: false,
              timestamp: DateTime.now(),
            ));
      });
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                depth: -4, // Negative depth for a raised effect
                intensity: 0.9, // Light intensity for a soft look
                color: Colors.grey[300]!, // Background color
              ),
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration(
                  hintText: "Send a message",
                  filled: true,
                  fillColor:
                      Color.fromARGB(243, 0, 0, 0), // Background color
                  border: InputBorder.none, // Remove borders
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0), // Adjust padding
                ),
                style: const TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 14.0, // Set a smaller font size
                ),
                cursorColor: Colors.white, // Set cursor color to white
                cursorWidth: 1.0, // Adjust cursor width for a smaller cursor
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  const ChatMessage({
    Key? key,
    required this.text,
    required this.isMe,
    required this.timestamp,
  }) : super(key: key);

  String getFormattedTime() {
    return DateFormat.jm().format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isMe) const CircleAvatar(child: Text('B')), // Bot avatar
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isMe ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 14, 32, 30),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  getFormattedTime(),
                  style: const TextStyle(fontSize: 12, color: Color.fromARGB(137, 255, 255, 255)),
                ),
              ],
            ),
          ),
          if (isMe) const CircleAvatar(child: Text('A')), // User avatar
        ],
      ),
    );
  }
}
