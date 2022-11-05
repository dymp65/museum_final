import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'geojson_state.dart';

class GeojsonCubit extends Cubit<GeoJsonState> {
  GeojsonCubit() : super(GeoJsonInitial());
}
