import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sputnikn_chatsample/constants/palette.dart';
import 'package:sputnikn_chatsample/model/chat_thread_ui_message_model.dart';
import 'chat_thread_my_message.dart';
import 'chat_thread_other_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatThreadMessageAction extends StatelessWidget {
  final ChatThreadUIEventMessage message;
  final bool isMyMessage;
  final Future<Uint8List> Function(String) onDownloadMedia;
  final Function() onForward;
  final Function() onReply;
  final Function() onCopy;
  final Function() onDelete;

  const ChatThreadMessageAction({
    required this.message,
    required this.isMyMessage,
    required this.onDownloadMedia,
    required this.onForward,
    required this.onReply,
    required this.onCopy,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            (isMyMessage) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: (isMyMessage)
                    ? ChatThreadMyMessage(
                        model: message,
                        onActionTap: null,
                        onDownloadMedia: onDownloadMedia,
                        onOpenImagePreviewTap: (_) {},
                      )
                    : ChatThreadOtherMessage(
                        model: message,
                        onActionTap: null,
                        onDownloadMedia: onDownloadMedia,
                        onOpenImagePreviewTap: (_) {},
                      ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _actionPanel(context),
        ],
      ),
    );
  }

  Widget _actionPanel(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: (isMyMessage) ? 0.0 : 56.0,
        right: (isMyMessage) ? 56.0 : 0.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Palette.color1,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _btnForward(context),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _btnReply(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _btnCopy(context),
          ),
          if (isMyMessage)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _btnDelete(context),
            ),
        ],
      ),
    );
  }

  Widget _btnForward(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onForward,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.reply_all_rounded,
            color: Palette.color5,
            size: 18.0,
          ),
          const SizedBox(width: 4.0),
          Text(AppLocalizations.of(context)!.chat_thread_action_forward),
        ],
      ),
    );
  }

  Widget _btnReply(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onReply,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.reply_rounded,
            color: Palette.color5,
            size: 18.0,
          ),
          const SizedBox(width: 4.0),
          Text(AppLocalizations.of(context)!.chat_thread_action_reply),
        ],
      ),
    );
  }

  Widget _btnCopy(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onCopy,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.copy_rounded,
            color: Palette.color5,
            size: 18.0,
          ),
          const SizedBox(width: 4.0),
          Text(AppLocalizations.of(context)!.chat_thread_action_copy),
        ],
      ),
    );
  }

  Widget _btnDelete(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onDelete,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.delete_outline,
            color: Palette.color5,
            size: 18.0,
          ),
          const SizedBox(width: 4.0),
          Text(AppLocalizations.of(context)!.chat_thread_action_delete),
        ],
      ),
    );
  }
}
