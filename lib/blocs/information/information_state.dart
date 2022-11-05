part of 'information_cubit.dart';

abstract class InformationState extends Equatable {
  const InformationState();
}

class InformationInitial extends InformationState {
  @override
  List<Object> get props => [];
}

class InformationLoading extends InformationState {
  @override
  List<Object> get props => [];
}

class InformationFetch extends InformationState {
  final List<InformationModel> information;

  InformationFetch({required this.information});

  @override
  List<Object> get props => [information];
}

class InformationFetchDetail extends InformationState {
  final InformationModel information;

  InformationFetchDetail({required this.information});

  @override
  List<Object> get props => [information];
}

class InformationException extends InformationState {
  final e;

  const InformationException({
    this.e,
  });

  @override
  List<Object?> get props => [
        e,
      ];
}
