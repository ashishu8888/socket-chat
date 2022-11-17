import 'package:riverpod/riverpod.dart';
import 'package:sockets_chat/models/message_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());
final messageListRepositoryProvider = Provider<List<Message>>((ref) {
  List<Message> messagesList =
      ref.watch(chatRepositoryProvider).getAllMessage();
  return messagesList;
});

class ChatRepository {
  List<Message> messagesList = [];

  void addNewMessage(String msg, String sentByMe, String time) {
    Message mssg = Message(message: msg, sentByMe: sentByMe, time: time);
    messagesList.add(mssg);
  }

  List<Message> getAllMessage() {
    return messagesList;
  }
}
