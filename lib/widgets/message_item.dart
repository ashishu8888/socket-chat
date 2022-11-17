import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatefulWidget {
  bool sentByMe = false;
  String mssg;
  String time;
  MessageItem({
    super.key,
    required this.sentByMe,
    required this.mssg,
    required this.time,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.sentByMe
              ? const Color(0xFF6c5e7).withOpacity(0.7)
              : const Color(0xFF191919).withOpacity(1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              widget.mssg,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
