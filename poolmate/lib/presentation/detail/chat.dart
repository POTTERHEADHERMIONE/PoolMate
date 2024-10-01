import 'package:flutter/material.dart';

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
      _messages.insert(0, ChatMessage(
        text: text,
        isMe: true,
      ));
    });
    // Here you would typically send the message to a server
    // For demo purposes, we'll add a mock reply after a short delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.insert(0, ChatMessage(
          text: "This is a mock reply to: $text",
          isMe: false,
        ));
      });
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
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
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({Key? key, required this.text, required this.isMe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isMe) 
            CircleAvatar(child: Text('B')),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(text),
          ),
          if (isMe) 
            CircleAvatar(child: Text('A')),
        ],
      ),
    );
  }
}