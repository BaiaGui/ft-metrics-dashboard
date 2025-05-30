import 'package:ft_dashboard/model/view_type.dart';

class GeneralStatusEvent {}

class GeneralStatusStarted extends GeneralStatusEvent {}

class GeneralStatusChangedTime extends GeneralStatusEvent {
  final String year;

  GeneralStatusChangedTime(this.year);
}

class ChartClicked extends GeneralStatusEvent {
  final String dataTime;
  final String dataSourceId;
  final String dataSourceName;

  ChartClicked(
      {required this.dataTime,
      required this.dataSourceId,
      required this.dataSourceName});
}

class BreadCrumbClicked extends GeneralStatusEvent {
  final ViewType pathView;
  final String dataSourceId;
  final String dataSourceName;
  final String dataTime;

  BreadCrumbClicked(
      {required this.pathView,
      required this.dataSourceId,
      required this.dataSourceName,
      required this.dataTime});
}

// class GroupSelectedEvent extends GeneralStatusEvent {
//   final String? dataTime;
//   final String? dataSourceId;

//   GroupSelectedEvent(this.dataTime, this.dataSourceId);
// }
