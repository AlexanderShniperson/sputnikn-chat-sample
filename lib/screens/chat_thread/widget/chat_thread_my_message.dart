import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:sputnikn_chatsample/constants/palette.dart';
import 'package:sputnikn_chatsample/model/chat_thread_ui_message_model.dart';
import 'package:flutter/material.dart';
import 'package:sputnikn_chatsample/screens/widgets/user_avatar.dart';
import 'chat_thread_message_attachment.dart';

class ChatThreadMyMessage extends StatefulWidget {
  final ChatThreadUIEventMessage model;
  final Function(ChatThreadUIEventMessage)? onActionTap;
  final Future<Uint8List> Function(String) onDownloadMedia;
  final Function(Uint8List) onOpenImagePreviewTap;

  const ChatThreadMyMessage({
    required this.model,
    required this.onActionTap,
    required this.onDownloadMedia,
    required this.onOpenImagePreviewTap,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatThreadMyMessage> createState() => _ChatThreadMyMessageState();
}

class _ChatThreadMyMessageState extends State<ChatThreadMyMessage> {
  final _avatarSize = 40.0;

  final _dateFormat = DateFormat.Hm();

  @override
  Widget build(BuildContext context) {
    debugPrint(">>> [$runtimeType] build");
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onLongPress: () {
        widget.onActionTap?.call(widget.model);
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: _avatarSize + 16.0,
          top: 16.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: _avatarSize + 16.0,
              ),
              child: Text(
                widget.model.senderName,
                textAlign: TextAlign.end,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(child: _messageContent()),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: UserAvatar(
                    userName: widget.model.senderName,
                    avatarPath: widget.model.senderAvatar,
                    avatarSize: _avatarSize,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _messageContent() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: Palette.color4,
      ),
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
        bottom: 4.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _contentAttachment(),
          Text(
            widget.model.messageContent.content,
            softWrap: true,
          ),
          Text(
            _dateFormat.format(widget.model.timestamp),
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentAttachment() {
    return Visibility(
      visible: widget.model.attachment.isNotEmpty,
      child: RepaintBoundary(
        child: SizedBox(
          height: 200,
          child: ChatThreadMessageAttachment(
            attachments: widget.model.attachment,
            onDownloadAttachment: widget.onDownloadMedia,
            onOpenImagePreviewTap: widget.onOpenImagePreviewTap,
          ),
        ),
      ),
    );
  }
}
