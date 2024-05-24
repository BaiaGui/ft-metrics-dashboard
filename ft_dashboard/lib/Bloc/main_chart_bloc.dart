import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/main_chart_repository.dart';

class Event {}

class MainChartState {
  final MainChartRepository mainRep = MainChartRepository();

  List<List<int>> linePoints;

  MainChartState(this.linePoints);
}

class MainChartBloc extends Bloc<Event, MainChartState> {
  final MainChartRepository mainRep = MainChartRepository();

  MainChartBloc() : super(MainChartState([])) {
    on<Event>(((event, emit) async {
      final data = await mainRep.getLineAllData();
      emit(MainChartState(data));
    }));
  }
}
