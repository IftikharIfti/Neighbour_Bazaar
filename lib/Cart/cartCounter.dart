class CartCounter {
  int _counter = 0;

  CartCounter._private();

  static final CartCounter _instance = CartCounter._private();
  factory CartCounter() {
    return _instance;
  }

  int get counter => _counter;
  void increment() {
    _counter++;
  }
  void clear()
  {
    _counter=0;
  }

}
