import 'package:chat_socket/customUI/ButtonCard.dart';
import 'package:chat_socket/customUI/ContactCard.dart';
import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:flutter/material.dart';

class CreateGroup extends StatefulWidget {
  CreateGroup({Key? key, contacts}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev Stack", status: "A full stack dev"),
    ChatModel(name: "Dev Phat", status: "fontend"),
    ChatModel(name: "Dev Stack", status: "A full stack dev"),
    ChatModel(name: "Dev Phat", status: "fontend"),
    ChatModel(name: "Dev Stack", status: "A full stack dev"),
    ChatModel(name: "Dev Phat", status: "fontend")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Group",
                style: CustomTextStyle.h3(Colors.white),
              ),
              Text(
                "256 contacts",
                style: CustomTextStyle.t3(Colors.white),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (context) {
                return const [
                  PopupMenuItem(
                    child: Text("New group"),
                    value: "New group",
                  ),
                  PopupMenuItem(
                    child: Text("New broadcast"),
                    value: "New broadcast",
                  ),
                  PopupMenuItem(
                    child: Text("Whatapps Web"),
                    value: "Whatapps Web",
                  ),
                  PopupMenuItem(
                    child: Text("Starred messages"),
                    value: "Starred messages",
                  ),
                  PopupMenuItem(
                    child: Text("Setting"),
                    value: "Setting",
                  ),
                ];
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ContactCard(
              onTap: () {
                setState(() {
                  contacts[index].isSelect = !contacts[index].isSelect;
                });
              },
              contact: contacts[index],
            );
          },
          itemCount: contacts.length,
        ));
  }
}
