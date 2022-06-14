import 'package:chat_socket/customUI/CustomCard.dart';
import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/screens/SelectContact.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, required this.chats, required this.sourseChat})
      : super(key: key);
  final List<ChatModel> chats;
  final ChatModel sourseChat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectContact()),
          );
        },
        child: const Icon(
          Icons.chat,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CustomCard(
          chatModel: chats[index],
          sourseChat: sourseChat,
        ),
        itemCount: chats.length,
      ),
    );
  }
}
