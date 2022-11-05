part of 'geojson_cubit.dart';

abstract class GeoJsonState extends Equatable {
  const GeoJsonState();
}

class GeoJsonInitial extends GeoJsonState {
  @override
  List<Object> get props => [];
}
