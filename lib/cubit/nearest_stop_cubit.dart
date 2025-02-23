import 'package:flutter_bloc/flutter_bloc.dart';

import '../infra/bus_stop.dart';

class NearestStopCubit extends Cubit<StopBusModel?> {
  NearestStopCubit() : super(null);

  void updateNearestStop({required StopBusModel stop}) {
    emit(stop);
  }
}
