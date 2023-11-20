import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Square Buttons'),
        ),
        body: ButtonGrid(),
      ),
    );
  }
}

class ButtonGrid extends StatelessWidget {
  final List<String> items = [
    'Mobile',
    'Electronics',
    'Vehicles',
    'Furniture',
    'Men\'s clothes',
    'Women\'s clothes',
    'Children\'s clothes and toys',
    'Essential',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: items.length,
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return CustomButton(
          imagePath: getImagePathForItem(items[index]),
          label: items[index],
          onTap: () {
            // Your method implementation here
            print('Button ${items[index]} tapped!');
          },
        );
      },
    );
  }

  String getImagePathForItem(String item) {
    // Provide the file path for your custom icons based on the item
    switch (item) {
      case 'Mobile':
        return 'img/mobile.png';
      case 'Electronics':
        return 'img/electronics.png';
      case 'Vehicles':
        return 'img/vehicles.png';
      case 'Furniture':
        return 'img/furniture.png';
      case 'Men\'s clothes':
        return 'img/men.png';
        case 'Women\'s clothes':
        return 'img/women.png';
        case 'Children\'s clothes and toys':
          return 'img/children.png';
      case 'Essential':
         return 'img/essential.png';
    // Add cases for other items
      default:
        return 'img/default_icon.png'; // Default icon if no match
    }
  }
}

class CustomButton extends StatefulWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: () => _handleTapCancel(),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blue.shade300 : Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              height: 48.0,
              width: 48.0,
            ),
            SizedBox(height: 8.0),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTapDown() {
    setState(() {
      _isPressed = true;
    });
  }

  void _handleTapUp() {
    setState(() {
      _isPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }
}
