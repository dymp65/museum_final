part of 'connect_cubit.dart';

abstract class ConnectState extends Equatable {
  const ConnectState();
}

class ConnectInitial extends ConnectState {
  @override
  List<Object> get props => [];
}

class ConnectResult extends ConnectState {
  final bool connect;

  const ConnectResult({required this.connect});

  @override
  List<Object> get props => [connect];
}

class ConnectException extends ConnectState {
  final e;

  const ConnectException({
    this.e,
  });

  @override
  List<Object?> get props => [
        e,
      ];
}
