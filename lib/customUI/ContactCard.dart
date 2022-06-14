import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/service.dart/AppColors.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  ContactCard({Key? key, required this.contact, this.onTap}) : super(key: key);
  final ChatModel contact;
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: ListTile(
        leading: Container(
          height: 53,
          width: 50,
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.blueGreyColor,
                radius: 25,
                child: SvgPicture.asset(
                  "assets/images/group.svg",
                  width: 30,
                  color: Colors.white,
                ),
              ),
              contact.isSelect
                  ? const Positioned(
                      bottom: 4,
                      right: 0,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: AppColors.subPrimary,
                        child: Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        title: Text(
          contact.name!,
          style: CustomTextStyle.t2Bold(Color.fromARGB(255, 16, 16, 16)),
        ),
        subtitle: Text(contact.status!),
      ),
    );
  }
}
