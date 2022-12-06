part of 'bluetooth_bloc.dart';

abstract class BluetoothEvent extends Equatable {
  const BluetoothEvent();

  @override
  List<Object> get props => [];
}

class OnStartBlue extends BluetoothEvent {}

class RequestEnable extends BluetoothEvent {}

class RequestDisable extends BluetoothEvent {}

class StateChanged extends BluetoothEvent {
  const StateChanged(this.stateB);
  final BluetoothState stateB;
}
