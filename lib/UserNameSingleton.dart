class usernameSingleton {
  static final usernameSingleton _instance = usernameSingleton._internal();

  factory usernameSingleton() {
    return _instance;
  }

  usernameSingleton._internal();

  String _username='';

  String get username => _username;

  set username(String value) {
    _username = value;
  }
}
