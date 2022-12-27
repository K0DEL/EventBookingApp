import 'package:app/event_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';

int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];
  return daysInMonth[month - 1];
}

int getEventsInEventType(int eventType) {
  if (eventType == 2) {
    return 2;
  }
  return 3;
}

class EventPicker extends StatefulWidget {
  const EventPicker({super.key});

  @override
  State<EventPicker> createState() => _EventPickerState();
}

class _EventPickerState extends State<EventPicker> {
  // int daysLeft = getDaysInMonth(DateTime.now().year, DateTime.now().month) -
  //     DateTime.now().day +
  //     1;
  // int today = DateTime.now().day;
  // DateTime selectedDate = DateTime.now();\
  int selectedMonth = 0;
  int selectedDate = 0;
  int totalDate = getDaysInMonth(DateTime.now().year, 1);
  int selectedEventType = 0;
  int totalEvents = getEventsInEventType(0);
  int selectedEvent = 0;
  Box<dynamic> seatBox = Hive.box("seatBox");
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
  List<String> events = <String>["Comedy", "Play", "Movie"];

  void updateSeats() async {
    await Future.delayed(const Duration(microseconds: 100));
    if (!mounted) {
      return;
    }
    Provider.of<EventData>(context, listen: false).updateEvent(
        "$selectedMonth + $selectedDate + ${selectedEventType * 3 + selectedEvent}");
    var newStatus = seatBox
        .get(Provider.of<EventData>(context, listen: false).selectedEvent);
    if (newStatus == null) {
      Provider.of<EventData>(context, listen: false)
          .updateStatus(List.filled(150, 0));
    } else {
      Provider.of<EventData>(context, listen: false).updateStatus(newStatus);
    }
  }

  @override
  void initState() {
    super.initState();
    updateSeats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1D1D),
        borderRadius: BorderRadius.circular(20.0),
      ),
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Select Month
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.white,
                iconSize: 40.0,
                onPressed: () {
                  selectedMonth = max(selectedMonth - 1, 0);
                  totalDate =
                      getDaysInMonth(DateTime.now().year, selectedMonth + 1);
                  selectedDate = 0;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_left_rounded,
                ),
              ),
              Text(
                months[selectedMonth],
                style: const TextStyle(
                  color: Color(0xFFB6E93B),
                ),
              ),
              IconButton(
                color: Colors.white,
                iconSize: 40.0,
                onPressed: () {
                  selectedMonth = min(selectedMonth + 1, 11);
                  totalDate =
                      getDaysInMonth(DateTime.now().year, selectedMonth + 1);
                  selectedDate = 0;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_right_rounded,
                ),
              ),
            ],
          ),

          //Select Date
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const Text(
              "Select Date",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 60.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: totalDate,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedDate = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 60.0,
                    decoration: BoxDecoration(
                      color: index == selectedDate
                          ? const Color(0xFFB6E93B)
                          : const Color(0xFF282828),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: index == selectedDate
                              ? Colors.black
                              : const Color(0xFF7E7E7E),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // GestureDetector(
          //   onTap: selectDate,
          //   child: const Text("Select date!"),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.white,
                iconSize: 40.0,
                onPressed: () {
                  selectedEventType = max(selectedEventType - 1, 0);
                  totalEvents = getEventsInEventType(selectedEventType);
                  selectedEvent = 0;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_left_rounded,
                ),
              ),
              Text(
                events[selectedEventType],
                style: const TextStyle(
                  color: Color(0xFFB6E93B),
                ),
              ),
              IconButton(
                color: Colors.white,
                iconSize: 40.0,
                onPressed: () {
                  selectedEventType = min(selectedEventType + 1, 2);
                  totalEvents = getEventsInEventType(selectedEventType);
                  selectedEvent = 0;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.arrow_right_rounded,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: const Text(
              "Select Event",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: totalEvents,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedEvent = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 80.0,
                    decoration: BoxDecoration(
                      color: index == selectedEvent
                          ? const Color(0xFFB6E93B)
                          : const Color(0xFF282828),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: index == selectedEvent
                              ? Colors.black
                              : const Color(0xFF7E7E7E),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          GestureDetector(
            onTap: () {
              updateSeats();
              // print(Provider.of<EventData>(context, listen: false).seatStatus);
              // print(seatStatus);
              setState(() {});
            },
            child: Center(
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
                    "Confirm Event Date and Time!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
