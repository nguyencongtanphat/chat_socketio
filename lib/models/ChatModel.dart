class ChatModel {
  int? id;
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool isSelect = false;
  ChatModel({
    this.currentMessage,
    this.icon,
    this.isGroup,
    this.name,
    this.time,
    this.status,
    isSelect,
    this.id,
  });
}
