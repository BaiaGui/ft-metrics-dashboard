class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusChangedTime extends GeneralStatusEvent {
  final String? year;

  GeneralStatusChangedTime(this.year);
}

class ChartClicked extends GeneralStatusEvent {
  final String? dataTime;
  final String? dataSourceId;

  ChartClicked(this.dataTime, this.dataSourceId);
}

// class GroupSelectedEvent extends GeneralStatusEvent {
//   final String? dataTime;
//   final String? dataSourceId;

//   GroupSelectedEvent(this.dataTime, this.dataSourceId);
// }
