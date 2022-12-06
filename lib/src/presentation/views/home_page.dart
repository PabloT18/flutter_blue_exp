import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_bluetooth_serial_example/src/presentation/bloc/bluetooth_bloc.dart';

import 'devices_page.dart';
import 'discovery_page.dart';
import 'message_device_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Ejemplo'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<BluetoothBloc, BluetoothBlocState>(
          builder: (context, state) {
            return Column(
              children: [
                SwitchListTile(
                  title: const Text('Activar Bluetooth'),
                  value: state is BluetoothOn,
                  onChanged: (bool value) {
                    if (value) {
                      context.read<BluetoothBloc>().add(RequestEnable());
                    } else {
                      context.read<BluetoothBloc>().add(RequestDisable());
                    }
                  },
                ),
                ListTile(
                  title: const Text('Bluetooth estado'),
                  subtitle:
                      Text(state is BluetoothOn ? 'State_On' : 'State_Off'),
                  trailing: ElevatedButton(
                    child: const Text('Settings'),
                    onPressed: () {
                      context.read<BluetoothBloc>().instanceBlue.openSettings();
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Adaptador direccion'),
                  subtitle: Text(state.address),
                ),
                ListTile(
                  title: const Text('Adaptador nombre'),
                  subtitle: Text(state.name),
                  onLongPress: null,
                ),
                ListTile(
                  title: ElevatedButton(
                      child: const Text('Buscar Dispositivos'),
                      onPressed: state is BluetoothOn
                          ? () async {
                              final BluetoothDevice? selectedDevice =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return DiscoveryPage();
                                  },
                                ),
                              );

                              if (selectedDevice != null) {
                                print('Discovery -> selected ' +
                                    selectedDevice.address);
                              } else {
                                print('Discovery -> no device selected');
                              }
                            }
                          : null),
                ),
                ListTile(
                  title: ElevatedButton(
                    child: Text('Conectar a un dispositivo vinculado'),
                    onPressed: () async {
                      final BluetoothDevice? selectedDevice =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SelectBondedDevicePage(
                                checkAvailability: false);
                          },
                        ),
                      );

                      if (selectedDevice != null) {
                        print('Connect -> selected ' + selectedDevice.address);
                        _startChat(context, selectedDevice);
                      } else {
                        print('Connect -> no device selected');
                      }
                    },
                  ),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MessageDevice(server: server);
        },
      ),
    );
  }
}
