class AddressReturner {
  late String address;

  AddressReturner._privateConstructor({String? initialAddress}) {
    address = initialAddress ?? 'No Location set'; // Initialize with the provided address or an empty string
  }

  static final AddressReturner _instance = AddressReturner._privateConstructor();

  factory AddressReturner({String? initialAddress}) {
    if (initialAddress != null) {
      _instance.setAddress(initialAddress);
    }
    return _instance;
  }

  void setAddress(String newAddress) {
    address = newAddress;
  }

  String getAddress() {
    return address;
  }
}
