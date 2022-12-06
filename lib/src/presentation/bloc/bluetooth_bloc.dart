import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothBlocState> {
  BluetoothBloc({
    required this.instanceBlue,
  }) : super(const BluetoothInitial()) {
    on<OnStartBlue>(_onStartBlue);
    on<StateChanged>(_onStateChanged);

    on<RequestEnable>((event, emit) {
      instanceBlue.requestEnable();
    });
    on<RequestDisable>((event, emit) {
      instanceBlue.requestDisable();
    });

    // add(OnStartBlue());

    instanceBlue.state.then((stateB) => add(StateChanged(stateB)));

    addressB = '--';
    nameB = '--';

    instanceBlue
        .onStateChanged()
        .listen((BluetoothState stateB) => add(StateChanged(stateB)));
  }

  final FlutterBluetoothSerial instanceBlue;

  late String addressB;
  late String nameB;

  FutureOr<void> _onStartBlue(
      OnStartBlue event, Emitter<BluetoothBlocState> emit) async {
    if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
      // var addressB = '';
      // var nameB = '';

      instanceBlue.address.then((address) {
        addressB = address!;
      });

      instanceBlue.name.then((name) {
        nameB = name!;
      });
      emit(BluetoothOn(address: addressB, name: nameB));
    }
  }

  FutureOr<void> _onStateChanged(
      StateChanged event, Emitter<BluetoothBlocState> emit) {
    if (event.stateB == BluetoothState.STATE_OFF) {
      emit(const BluetoothOff());
    } else if (event.stateB == BluetoothState.STATE_ON) {
      emit(BluetoothOn(
        address: addressB,
        name: nameB,
      ));
    }
  }
}
