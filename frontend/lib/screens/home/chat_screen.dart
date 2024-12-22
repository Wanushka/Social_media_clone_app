import 'package:flutter/material.dart';

// Message model to store chat messages
class ChatMessage {
  final String text;
  final bool isBot;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isBot,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  // Technology keywords and responses
  final Map<String, String> botResponses = {
    'flutter': 'Flutter is a UI toolkit from Google for building natively compiled applications for mobile, web, and desktop from a single codebase using Dart.',
    'react': 'React is a JavaScript library for building user interfaces, developed by Facebook. It allows developers to create reusable UI components.',
    'python': 'Python is a high-level, interpreted programming language known for its simplicity and readability. It\'s great for beginners and powerful enough for experts.',
    'javascript': 'JavaScript is a programming language that enables interactive web pages. It\'s an essential part of web applications and can be used for both front-end and back-end development.',
    'api': 'API (Application Programming Interface) is a set of rules that allows different software applications to communicate with each other.',
    'database': 'A database is an organized collection of structured information or data, typically stored electronically in a computer system.',
  };

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;

    _textController.clear();
    
    // Add user message
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isBot: false,
      ));
    });

    // Generate bot response
    _generateBotResponse(text);

    // Scroll to bottom
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _generateBotResponse(String userMessage) {
    String botResponse = "I'm not sure about that. Could you please ask something about specific technologies like Flutter, React, Python, JavaScript, APIs, or databases?";
    
    // Convert to lowercase for case-insensitive matching
    String lowerMessage = userMessage.toLowerCase();
    
    // Check for keywords in the user's message
    botResponses.forEach((keyword, response) {
      if (lowerMessage.contains(keyword.toLowerCase())) {
        botResponse = response;
      }
    });

    // Simulate typing delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatMessage(
          text: botResponse,
          isBot: true,
        ));
      });
      
      // Scroll to bottom after bot responds
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tech Chat Assistant',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isBot)
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.android, color: Colors.white),
            ),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isBot ? Colors.blue.shade100 : Colors.blue.shade500,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isBot ? Colors.black87 : Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          if (!message.isBot)
            CircleAvatar(
              backgroundColor: Colors.blue.shade700,
              child: Icon(Icons.person, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 6.0,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Ask about technology...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: () => _handleSubmitted(_textController.text),
            child: Icon(Icons.send),
            mini: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}