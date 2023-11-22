class ChatMessage {
  final String user;
  final String friend;
  final String message;
  final DateTime datetime;
  final String state;

  ChatMessage({
    required this.user,
    required this.friend,
    required this.message,
    required this.datetime,
    required this.state,
  });
}