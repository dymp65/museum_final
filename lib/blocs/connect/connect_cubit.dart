import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

part 'connect_state.dart';

class ConnectCubit extends Cubit<ConnectState> {
  ConnectCubit() : super(ConnectInitial());

  void fetchConnect() async {
    try {
      var connect = await ConnectivityWrapper.instance.isConnected;
      emit(ConnectResult(connect: connect));
    } catch (e) {
      emit(ConnectException(e: e));
    }
  }
}
