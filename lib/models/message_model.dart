import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  String? message;
  String? sentByMe;
  String? time;
  Message({
    required this.message,
    required this.sentByMe,
    required this.time,
  });

  Message copyWith({
    String? message,
    String? sentByMe,
    String? time,
  }) {
    return Message(
      message: message ?? this.message,
      sentByMe: sentByMe ?? this.sentByMe,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sentByMe': sentByMe,
      'time': time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] != null ? map['message'] as String : null,
      sentByMe: map['sentByMe'] != null ? map['sentByMe'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
