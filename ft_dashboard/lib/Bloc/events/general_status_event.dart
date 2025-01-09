class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusChangedTime extends GeneralStatusEvent {
  final String? year;

  GeneralStatusChangedTime(this.year);
}

class CourseSelectedEvent extends GeneralStatusEvent {
  final String? dateTime;
  final String? dataSourceId;

  CourseSelectedEvent(this.dateTime, this.dataSourceId);
}
