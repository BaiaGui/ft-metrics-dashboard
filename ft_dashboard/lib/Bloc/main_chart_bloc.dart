import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/data/repository/main_chart_repository.dart';

class MainChartEvent {}

class MainChartStarted extends MainChartEvent {}

class MainChartState {
  final MainChartRepository mainRep = MainChartRepository();

  List<List<double>> linePoints;

  MainChartState(this.linePoints);
}

class MainChartBloc extends Bloc<MainChartEvent, MainChartState> {
  final MainChartRepository mainRep = MainChartRepository();

  MainChartBloc() : super(MainChartState([])) {
    on<MainChartStarted>(((event, emit) async {
      final data = await mainRep.getLineAllData();
      print(data);
      emit(MainChartState(data));
    }));
  }
}
