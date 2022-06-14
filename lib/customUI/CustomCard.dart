import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/screens/IndividualPage.dart';
import 'package:chat_socket/service.dart/AppColors.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  CustomCard({Key? key, required this.chatModel, required this.sourseChat})
      : super(key: key);
  ChatModel chatModel;
  ChatModel sourseChat;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
              sourseChat: sourseChat,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.blueGreyColor,
              radius: 30,
              child: SvgPicture.asset(
                chatModel.isGroup == true
                    ? "assets/images/group.svg"
                    : "assets/images/person.svg",
                width: 30,
                color: Colors.white,
              ),
            ),
            trailing: Text(chatModel.time!),
            title: Text(
              chatModel.name!,
              style: CustomTextStyle.t2Bold(
                const Color.fromARGB(255, 50, 50, 50),
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all_outlined),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Hi Dev Stack",
                  style: CustomTextStyle.t5(Color.fromARGB(255, 166, 166, 166)),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
