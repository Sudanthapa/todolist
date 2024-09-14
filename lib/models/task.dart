class Task {
  String title;
  String dueDate;
  bool isCompleted;
  bool isRecurring;
  String? recurrenceFrequency;

  Task({
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
    this.isRecurring = false,
    this.recurrenceFrequency,
    required String priority,
  });

  get priority => null;

  get description => null;
}
