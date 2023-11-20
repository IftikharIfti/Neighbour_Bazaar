class addressSingleton {
  static final addressSingleton _instance = addressSingleton._internal();

  factory addressSingleton() {
    return _instance;
  }

  addressSingleton._internal();

  String _address='';

  String get address => _address;

  set address(String value) {
    _address = value;
  }
}
