import 'package:app/event_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app/color_guide.dart';

class Seats extends StatefulWidget {
  const Seats({super.key});

  @override
  State<Seats> createState() => _SeatsState();
}

class _SeatsState extends State<Seats> {
  Box<dynamic> seatBox = Hive.box("seatBox");

  Color getSeatColor(int status) {
    if (status == 0) {
      return const Color(0xFF1D1D1D);
    }
    if (status == 1) {
      return const Color(0xFFB6E93B);
    }
    return const Color(0xFF4E5E26);
  }

  Color getBorderColor(int status) {
    if (status == 1) {
      return const Color(0xFFB6E93B);
    }
    return const Color(0xFF4E5E26);
  }

  void saveBooking() {
    Map<dynamic, dynamic> tickets = seatBox.get("tickets", defaultValue: {});
    String key = DateTime.now().toString();
    Map<String, dynamic> bookedTickets = {};
    List<int> seatsBooked = [];
    List<int> newStatus = List<int>.filled(150, 0);
    for (int index = 0; index < 150; ++index) {
      if (Provider.of<EventData>(context, listen: false).seatStatus[index] ==
          1) {
        seatsBooked.add(index);
        newStatus[index] = 2;
      } else {
        newStatus[index] =
            Provider.of<EventData>(context, listen: false).seatStatus[index];
      }
    }
    Provider.of<EventData>(context, listen: false).updateStatus(newStatus);
    seatBox.put(Provider.of<EventData>(context, listen: false).selectedEvent,
        Provider.of<EventData>(context, listen: false).seatStatus);

    bookedTickets["seatsBooked"] = seatsBooked;
    bookedTickets["selectedEvent"] =
        Provider.of<EventData>(context, listen: false).selectedEvent;
    bookedTickets["Cancelled"] = false;
    tickets[key] = bookedTickets;
    if (seatsBooked.isNotEmpty) {
      seatBox.put("tickets", tickets);
      Navigator.pushNamed(context, "/bookedTickets");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.49,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 15,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 150,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    if (Provider.of<EventData>(context, listen: false)
                            .seatStatus[index] !=
                        2) {
                      Provider.of<EventData>(context, listen: false)
                          .seatStatus[index] ^= 1;
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: getSeatColor(
                          Provider.of<EventData>(context, listen: true)
                              .seatStatus[index]),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: getBorderColor(
                          Provider.of<EventData>(context, listen: true)
                              .seatStatus[index],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const ColorGuide(),
          GestureDetector(
            onTap: () {
              saveBooking();
              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                color: const Color(0xFFB6E93B),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Center(
                child: Text(
                  "Book Tickets",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //   },
    // );
  }
}
