import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerProvider with ChangeNotifier {
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endimeController = TextEditingController();

  TimeOfDay get startTime => _startTime;
  TimeOfDay get endTime => _endTime;

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _startTime = picked;
      startTimeController.text = formatDate(picked);

      notifyListeners();
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _endTime = picked;
      endimeController.text = formatDate(picked);

      notifyListeners();
    }
  }

  String formatDate(TimeOfDay date) {
    final hour = date.hour;
    final minute = date.minute;
    final period = hour < 12 ? 'AM' : 'PM';
    final twelveHour =
        hour > 12
            ? hour - 12
            : hour == 0
            ? 12
            : hour;
    // return '${date.hour}:${date.minute}';
    return ' $twelveHour:${minute.toString().padLeft(2, '0')} $period';
  }

  Duration? get duration {
    if (_startTime == null || _endTime == null) return null;

    final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
    final endMinutes = _endTime!.hour * 60 + _endTime!.minute;

    final totalMinutes =
        endMinutes >= startMinutes ? endMinutes - startMinutes : (1440 - startMinutes) + endMinutes;

    return Duration(minutes: totalMinutes);
  }

  String get formattedDuration {
    if (duration == null) return '--:--';

    final hours = duration!.inHours;
    final minutes = duration!.inMinutes.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    super.dispose();
    startTimeController.dispose();
    endimeController.dispose();
  }
}
