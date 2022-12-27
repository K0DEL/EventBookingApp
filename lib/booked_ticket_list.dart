import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookedTicketList extends StatefulWidget {
  const BookedTicketList({super.key});

  @override
  State<BookedTicketList> createState() => _BookedTicketListState();
}

class _BookedTicketListState extends State<BookedTicketList> {
  Box<dynamic> seatBox = Hive.box("seatBox");
  Map<dynamic, dynamic> tickets = {};
  List<dynamic> ticketKeys = [];
  List<String> months = <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> row = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
  ];
  List<String> events = <String>["Comedy", "Play", "Movie"];

  void getTickets() {
    tickets = seatBox.get("tickets", defaultValue: {});
    if (tickets.isNotEmpty) {
      ticketKeys = tickets.keys.toList();
    }
  }

  @override
  void initState() {
    super.initState();
    getTickets();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: ticketKeys.length,
      itemBuilder: (context, index) {
        String key = ticketKeys[index];
        String eventMonth = months[int.parse(tickets[key]["selectedEvent"][0])];
        String eventDate =
            (int.parse(tickets[key]["selectedEvent"][4]) + 1).toString();
        String eventType =
            events[((int.parse(tickets[key]["selectedEvent"][8])) / 3).floor()];
        String event =
            ((int.parse(tickets[key]["selectedEvent"][8])) % 3 + 1).toString();
        String seatsBooked = '';
        for (int seat in tickets[key]["seatsBooked"]) {
          seatsBooked += row[(seat / 15).floor()];
          seatsBooked += ((seat % 15) + 1).toString();
          seatsBooked += ' ';
        }

        return Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: tickets[key]["Cancelled"] == true
                ? const Color(0xFF4E5E26)
                : const Color(0xFFB6E93B),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$eventMonth $eventDate",
                style: TextStyle(
                  color: tickets[key]["Cancelled"] == true
                      ? Colors.white
                      : Colors.black,
                  fontSize: 20.0,
                ),
              ),
              Text(
                "$eventType Show No: $event",
                style: TextStyle(
                  color: tickets[key]["Cancelled"] == true
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16.0,
                ),
              ),
              Expanded(
                child: Text(
                  "Seats Booked : $seatsBooked",
                  style: TextStyle(
                    color: tickets[key]["Cancelled"] == true
                        ? Colors.white
                        : Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  tickets[key]['Cancelled'] = true;
                  List<int> seatStatus =
                      seatBox.get(tickets[key]["selectedEvent"]);
                  // print(seatStatus);
                  for (int seat in tickets[key]["seatsBooked"]) {
                    seatStatus[seat] = 0;
                  }
                  seatBox.put("tickets", tickets);
                  seatBox.put(tickets[key]["selectedEvent"], seatStatus);
                  setState(() {});
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: tickets[key]["Cancelled"] == true
                            ? const Color(0xFF1D1D1D)
                            : const Color(0xFF4E5E26),
                        border: Border.all(
                          width: 2.5,
                          color: tickets[key]["Cancelled"] == true
                              ? const Color(0xFFB6E93B)
                              : const Color(0xFF1D1D1D),
                        )),
                    child: Text(
                      tickets[key]["Cancelled"] == true
                          ? "Cancelled"
                          : "Cancel Booking",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
