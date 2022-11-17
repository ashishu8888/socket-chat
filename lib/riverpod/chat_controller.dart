// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod/riverpod.dart';
import 'package:sockets_chat/models/message_model.dart';
import 'package:sockets_chat/riverpod/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository);
});

class ChatController {
  ChatRepository chatRepository;
  ChatController({
    required this.chatRepository,
  });
  void addNewMessage(String msg, String sentByMe, String time) {
    chatRepository.addNewMessage(msg, sentByMe, time);
  }

  List<Message>? getAllMessage() {
    return chatRepository.getAllMessage();
  }
}
