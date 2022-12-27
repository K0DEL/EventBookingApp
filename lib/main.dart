import 'package:app/event_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app/booking_page.dart';
import 'package:app/booked_ticket.dart';
import 'dart:math' as math;

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("seatBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventData>(
      create: (context) => EventData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Monolisa",
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/homePage': (context) => const HomePage(),
          '/bookingPage': (context) => const BookingPage(),
          '/bookedTickets': (context) => const BookedTickets(),
        },
        // initialRoute: '/bookingPage',
        initialRoute: '/homePage',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Image(
            color: Colors.grey,
            colorBlendMode: BlendMode.modulate,
            image: AssetImage("images/cover2.jpg"),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/bookingPage');
            },
            icon: const Icon(
              Icons.event_seat_rounded,
              color: Color(0xFFB6E93B),
              size: 40.0,
            ),
          ),
          const Text(
            "Book You Seats!",
            style: TextStyle(
              color: Color(0xFF4E5E26),
              fontSize: 20.0,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/bookedTickets');
            },
            icon: const Icon(
              Icons.airplane_ticket_sharp,
              color: Color(0xFFB6E93B),
              size: 40.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Your Bookings!",
            style: TextStyle(
              color: Color(0xFF4E5E26),
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
