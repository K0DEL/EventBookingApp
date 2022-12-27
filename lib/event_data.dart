import 'package:flutter/foundation.dart';

class EventData extends ChangeNotifier {
  String selectedEvent = '0 + 0 + 0';
  List<int> seatStatus = List<int>.filled(150, 0);

  void updateEvent(String newEvent) {
    selectedEvent = newEvent;
    notifyListeners();
  }

  void updateStatus(List<int> newStatus) {
    seatStatus = newStatus;
    notifyListeners();
  }
}
