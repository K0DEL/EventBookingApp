import 'package:flutter/material.dart';
import 'package:app/event_picker.dart';
import 'package:app/seats.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 20.0,
          ),
          EventPicker(),
          SizedBox(
            height: 20.0,
          ),
          Seats(),
        ],
      ),
    );
  }
}
