import 'package:flutter/material.dart';
import 'package:app/booked_ticket_list.dart';

class BookedTickets extends StatefulWidget {
  const BookedTickets({super.key});

  @override
  State<BookedTickets> createState() => _BookedTicketsState();
}

class _BookedTicketsState extends State<BookedTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: const [
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: Text(
              "Your Tickets",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
          BookedTicketList(),
        ],
      ),
    );
  }
}
