class EmailSingleton {
  static final EmailSingleton _instance = EmailSingleton._internal();

  factory EmailSingleton() {
    return _instance;
  }

  EmailSingleton._internal();

  String _email='';

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
