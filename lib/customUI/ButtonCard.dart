import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/service.dart/AppColors.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, required this.icon, required this.name})
      : super(key: key);
  final String name;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 25,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: CustomTextStyle.t2Bold(Color.fromARGB(255, 16, 16, 16)),
      ),
    );
  }
}
