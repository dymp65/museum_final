import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'unity_state.dart';

class UnityCubit extends Cubit<UnityState> {
  UnityCubit() : super(UnityInitial());
}
