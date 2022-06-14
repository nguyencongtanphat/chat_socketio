import 'package:chat_socket/customUI/ButtonCard.dart';
import 'package:chat_socket/customUI/ContactCard.dart';
import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/screens/CreateGroup.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:flutter/material.dart';

class SelectContact extends StatelessWidget {
  SelectContact({Key? key, contacts}) : super(key: key);
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
                "Select Contact",
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
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateGroup()),
                  );
                },
                child: const ButtonCard(
                  name: "New Group",
                  icon: Icons.group,
                ),
              );
            } else if (index == 1) {
              return const ButtonCard(
                name: "New contact",
                icon: Icons.person,
              );
            }
            return ContactCard(
              contact: contacts[index - 2],
            );
          },
          itemCount: contacts.length + 2,
        ));
  }
}
