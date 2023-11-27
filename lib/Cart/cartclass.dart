class CartClass{
  final int price;
  final String type;
  CartClass(
  {
    required this.price,
    required this.type
}
      );

  static List<CartClass> allCarts = []; // A static list to store all posts
  // A method to add a new post to the list
  static void addNewCart(CartClass carts) {
    allCarts.add(carts);
  }
}