import 'package:flutter/cupertino.dart';

class detailsscreen extends StatefulWidget {
  final Map<String, dynamic> data;

  detailsscreen({super.key, required this.data});

  @override
  State<detailsscreen> createState() => _detailsscreenState();
}

class _detailsscreenState extends State<detailsscreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Name: ${widget.data['name']}'),
          Text('Email: ${widget.data['email']}'),
          Text('Password: ${widget.data['password']}'),
          Text('Number: ${widget.data['number']}'),
        ],
      ),
    );
  }
}
