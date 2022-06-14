import 'dart:developer';

import 'package:chat_socket/customUI/OwnMessageCard.dart';
import 'package:chat_socket/customUI/ReplyCard.dart';
import 'package:chat_socket/models/ChatModel.dart';
import 'package:chat_socket/models/MessageModel.dart';
import 'package:chat_socket/service.dart/AppColors.dart';
import 'package:chat_socket/service.dart/AppFont.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourseChat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourseChat;
  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  bool isSend = false;
  TextEditingController? controller = TextEditingController();
  ScrollController? scrollController = ScrollController();
  List<MessageModel> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    String time = DateTime.now().toString().substring(10, 16);
    socket.emit('message', {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "time": time,
    });
    setMessage("source", message, time);
  }

  void connect() {
    socket = IO.io("https://secure-sierra-57212.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit('signin', widget.sourseChat.id);
    print(widget.sourseChat.id);
    socket.onConnect((_) {
      print('connect');
      socket.on("message", (msg) {
        print("message1 ${msg["message"]}");
        setMessage("destination", msg["message"], msg["time"]);
      });
    });
  }

  void setMessage(String type, String message, String time) {
    setState(() {
      messages.add(MessageModel(type: type, message: message, time: time));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.png",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  const SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(
                    widget.chatModel.isGroup == true
                        ? "assets/images/group.svg"
                        : "assets/images/person.svg",
                    width: 30,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatModel.name!,
                  style: CustomTextStyle.t2Bold(Colors.white),
                ),
                Text(
                  "last seen today at 12:05",
                  style: CustomTextStyle.t3(Colors.white),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              PopupMenuButton(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      child: Text("View Contact"),
                      value: "View Contact",
                    ),
                    PopupMenuItem(
                      child: Text("Media, links, and docs"),
                      value: "Media, links, and docs",
                    ),
                    PopupMenuItem(
                      child: Text("Whatapps Web"),
                      value: "Whatapps Web",
                    ),
                    PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    PopupMenuItem(
                      child: Text("Mute Notification"),
                      value: "Mute Notification",
                    ),
                    PopupMenuItem(
                      child: Text("Wallpaper"),
                      value: "Wallpaper",
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  //chat view
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length + 1,
                        itemBuilder: ((context, index) {
                          if (index == messages.length) {
                            return const SizedBox(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else if (messages[index].type == "destination") {
                            return ReplyCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                          return Container();
                        }),
                      ),
                    ),
                  ),
                  //input text
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //margin: const EdgeInsets.symmetric(horizontal: 8),
                      margin:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: TextFormField(
                                    controller: controller,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          isSend = false;
                                        });
                                      } else {
                                        setState(() {
                                          isSend = true;
                                        });
                                      }
                                    },
                                    focusNode: focusNode,
                                    maxLines: 5,
                                    minLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      prefixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              show = !show;
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.emoji_emotions)),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) =>
                                                      bottomSheet());
                                            },
                                            icon: const Icon(Icons.attach_file),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.camera_alt),
                                          ),
                                        ],
                                      ),
                                      border: InputBorder.none,
                                      hintText: "Type here",
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (isSend) {
                                    sendMessage(
                                        controller!.text,
                                        widget.sourseChat.id!,
                                        widget.chatModel.id!);

                                    controller!.clear();
                                    setState(() {
                                      isSend = false;
                                    });
                                    scrollController!.animateTo(
                                      scrollController!
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.subPrimary,
                                  child: Icon(
                                    isSend ? Icons.send : Icons.mic,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          show ? emojiSelect() : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconCreation(String title, Color color, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        Text(title)
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(18),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCreation("Document", Color.fromARGB(255, 78, 15, 71),
                      Icons.description),
                  iconCreation("Camera", Colors.red, Icons.photo_camera),
                  iconCreation("Gallery", Colors.purple, Icons.image),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCreation("Audio", Colors.orange, Icons.headphones),
                  iconCreation("Location", Colors.pink, Icons.location_on),
                  iconCreation("Contact", Colors.blue, Icons.person),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return Container(
      height: 300,
      child: EmojiPicker(
        config: const Config(
          initCategory: Category.SMILEYS,
          columns: 7,
        ),
        onEmojiSelected: ((category, emoji) {
          print(emoji);
        }),
      ),
    );
  }
}
