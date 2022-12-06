part of 'bluetooth_bloc.dart';

abstract class BluetoothBlocState extends Equatable {
  const BluetoothBlocState({
    required this.address,
    required this.name,
  });

  final String address;
  final String name;

  @override
  List<Object> get props => [
        address,
        name,
      ];
}

class BluetoothInitial extends BluetoothBlocState {
  const BluetoothInitial()
      : super(
          address: '---',
          name: '---',
        );
}

class BluetoothOn extends BluetoothBlocState {
  const BluetoothOn({
    required String address,
    required String name,
  }) : super(
          address: address,
          name: name,
        );
}

class BluetoothOff extends BluetoothBlocState {
  const BluetoothOff()
      : super(
          address: '---',
          name: '---',
        );
}
