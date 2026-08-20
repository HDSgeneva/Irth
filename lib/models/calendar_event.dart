class CalendarEvent {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.dayLabel,
    required this.timeLabel,
    required this.ownerName,
    required this.ownerAvatarIndex,
    required this.isShared,
    this.location,
  });

  final String id;
  final String title;
  final String dayLabel;
  final String timeLabel;
  final String ownerName;
  final int ownerAvatarIndex;
  final bool isShared;
  final String? location;
}
