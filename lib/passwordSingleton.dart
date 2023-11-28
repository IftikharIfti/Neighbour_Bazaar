class passwordSingleton {
  static final passwordSingleton _instance = passwordSingleton._internal();

  factory passwordSingleton() {
    return _instance;
  }

  passwordSingleton._internal();

  String _password='';

  String get password => _password;

  set password(String value) {
    _password = value;
  }
}
