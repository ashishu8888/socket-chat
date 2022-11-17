import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sockets_chat/models/message_model.dart';
import 'package:sockets_chat/riverpod/chat_controller.dart';
import 'package:sockets_chat/riverpod/chat_repository.dart';
import 'package:sockets_chat/widgets/message_item.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final uri = "http://10.20.15.96:3000";

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final msgController = TextEditingController();
  late IO.Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socket = IO.io(
      uri,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build(),
    );
    socket.connect();
    setUpSocketListener();
  }

  void sendMessage(String text) {
    //Message mssg = Message(message: text, sentByMe: socket.id);
    final mssg = {
      "message": text,
      "sentByMe": socket.id,
      "time": DateFormat('yyyy-MM-dd – kk:mm').format(
        DateTime.now(),
      ),
    };
    socket.emit('message', mssg);
    ref.watch(chatControllerProvider).addNewMessage(
          text,
          socket.id!,
          DateFormat('yyyy-MM-dd – kk:mm').format(
            DateTime.now(),
          ),
        );
  }

  void setUpSocketListener() {
    socket.on(
      'message',
      (data) {
        ref.watch(chatControllerProvider).addNewMessage(
              data["message"],
              data["sentByMe"],
              data["time"],
            );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Message>? mssgList = ref.watch(messageListRepositoryProvider);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                child: mssgList == null
                    ? const Center(
                        child: Text(
                          "Start conversation...",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: mssgList.length,
                        itemBuilder: (context, index) {
                          return MessageItem(
                            mssg: mssgList[index].message!,
                            sentByMe: mssgList[index].sentByMe == socket.id,
                            time: mssgList[index].time!,
                          );
                        },
                      ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.purple.withOpacity(0.2),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: msgController,
                  decoration: InputDecoration(
                      hintText: 'Start typing...',
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 140, 49, 225),
                        ),
                        child: IconButton(
                          onPressed: () {
                            sendMessage(msgController.text.trim());
                            msgController.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.send,
                          ),
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
