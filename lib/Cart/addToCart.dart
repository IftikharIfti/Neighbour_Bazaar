import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/Cart/cartCounter.dart';
import 'package:neighbour_bazaar/Cart/cartclass.dart';
import 'package:neighbour_bazaar/dashboard.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartItems = List.of(CartClass.allCarts.reversed);
  String selectedPaymentMethod = '';
  List<String> values=['Bkash/Nagad','Credit Card'];

  double calculateTotalAmount() {
    return cartItems.map((item) => item.price).fold(0, (a, b) => a + b);
  }
  selectedRadio(String? val)
  {
     setState(() {
       selectedPaymentMethod=val!;
     });
  }
 List<Widget>createRadioList()
 {
   List<Widget> widgets=[];
   for(String bullets in values)
     {
       widgets.add(
         RadioListTile(
           title: Text(bullets),
           value: bullets,
           groupValue: selectedPaymentMethod,
           onChanged: (currentbullets) {
            selectedRadio(currentbullets);
           },
           selected: selectedPaymentMethod==bullets,
         ),

       );
     }
   return widgets;
 }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart Items',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cartItems
                  .map((item) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.type,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${item.price} BDT'),
                ],
              ))
                  .toList(),
            ),
            Divider(height: 20.0),
            Text(
              'Total Amount     ${calculateTotalAmount()} BDT',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            children:  createRadioList(),
              // RadioListTile(
              //   title: Text('Bkash/Nagad'),
              //   value: val,
              //   groupValue: selectedPaymentMethod,
              //   onChanged: (value) {
              //     setState(() {
              //       selectedPaymentMethod = value as String;
              //     });
              //   },
              //   selected: true,
              // ),
              // RadioListTile(
              //   title: Text('Credit Card'),
              //   value: 'Credit Card',
              //   groupValue: selectedPaymentMethod,
              //   onChanged: (value) {
              //     setState(() {
              //       selectedPaymentMethod = value as String;
              //     });
              //   },
              // ),

            //],
          ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(()=>Dashboard());
                    // Handle cancel action
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    CartClass.allCarts.clear();
                    CartCounter().clear();
                    showPaymentCompletionDialog(context);
                    // Handle confirm action
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void showPaymentCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Payment Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TickAnimation(),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(Dashboard());
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
class TickAnimation extends StatefulWidget {
  @override
  _TickAnimationState createState() => _TickAnimationState();
}

class _TickAnimationState extends State<TickAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 50.0,
      ),
    );
  }
}
