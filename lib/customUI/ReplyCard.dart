import 'package:chat_socket/service.dart/AppColors.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key? key, required this.message, required this.time})
      : super(key: key);
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 15,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 60,
                  top: 10,
                  bottom: 20,
                ),
                child: Text(message),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  "20:58",
                  style: CustomTextStyle.t8(Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
