import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerProvider with ChangeNotifier {
  final TextEditingController dateController = TextEditingController();

  DateTime? _selectedDateTime = DateTime.now();

  DateTime? get selectedDateTime => _selectedDateTime;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedDateTime = picked;
      // dateController.text = _formatDate(picked);
      dateController.text = DateFormat(' MMMM d').format(picked);

      notifyListeners();
    }
  }

  // String _formatDate(DateTime date) {
  //   return '${date.day}/${date.month}/${date.year}';
  // }

  void dispose() {
    dateController.dispose();
    super.dispose();
  }
}
