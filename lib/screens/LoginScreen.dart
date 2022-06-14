import 'package:chat_socket/customUI/ButtonCard.dart';
import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourseChat;
  final List<ChatModel> chatModels = [
    ChatModel(
      currentMessage: "hello",
      icon: "person.svg",
      isGroup: false,
      name: "Tùng",
      time: "10:20",
      id: 1,
    ),
    ChatModel(
      currentMessage: "hello",
      icon: "person.svg",
      isGroup: false,
      name: "Phat",
      time: "10:10",
      id: 2,
    ),
    ChatModel(
      currentMessage: "hellofufhjfhjf",
      icon: "person.svg",
      isGroup: false,
      name: "Minh",
      time: "10:21",
      id: 3,
    ),
    ChatModel(
      currentMessage: "hellofufhjfhjf",
      icon: "person.svg",
      isGroup: false,
      name: "Bảo",
      time: "10:21",
      id: 4,
    ),
    ChatModel(
      currentMessage: "hellofufhjfhjf",
      icon: "person.svg",
      isGroup: false,
      name: "Mẹ",
      time: "10:21",
      id: 5,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourseChat = chatModels.removeAt(index);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (builder) => HomeScreen(
                  chatModels: chatModels,
                  sourseChat: sourseChat,
                ),
              ),
            );
          },
          child: ButtonCard(
            icon: Icons.person,
            name: chatModels[index].name!,
          ),
        ),
      ),
    );
  }
}
