import 'package:chat_client_repository/chat_client_repository.dart';
import 'package:sputnikn_chat_client/sputnikn_chat_client.dart';

class RoomLastMessageModel {
  final EventMessageContentModelV1 message;
  final DateTime createTimestamp;

  RoomLastMessageModel({
    required this.message,
    required this.createTimestamp,
  });

  factory RoomLastMessageModel.fromEvent(RoomEventMessageDetail detail) {
    return RoomLastMessageModel(
      message: EventMessageContentModelV1.deserialize(detail.content),
      createTimestamp: detail.createTimestamp,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomLastMessageModel &&
          runtimeType == other.runtimeType &&
          hashCode == other.hashCode;

  @override
  int get hashCode => message.hashCode ^ createTimestamp.hashCode;
}
