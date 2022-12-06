import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial_example/src/presentation/bloc/bluetooth_bloc.dart';

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
                const Divider(),
                const ListTile(title: Text('General')),
                SwitchListTile(
                  title: const Text('Enable Bluetooth'),
                  // value: _bluetoothState.isEnabled,
                  value: state is BluetoothOn,
                  onChanged: (bool value) {
                    if (value) {
                      context.read<BluetoothBloc>().add(RequestEnable());
                    } else {
                      context.read<BluetoothBloc>().add(RequestDisable());
                    }
                    // // Do the request and update with the true value then
                    // future() async {
                    //   // async lambda seems to not working
                    //   if (value) {
                    //     // await FlutterBluetoothSerial.instance.requestEnable();
                    //   } else {
                    //     // await FlutterBluetoothSerial.instance.requestDisable();
                    //   }
                    // }

                    // future().then((_) {
                    //   setState(() {});
                    // });
                  },
                ),
                // ListTile(
                //   title: const Text('Bluetooth status'),
                //   subtitle: Text(state.address ),
                //   trailing: ElevatedButton(
                //     child: const Text('Settings'),
                //     onPressed: () {
                //       FlutterBluetoothSerial.instance.openSettings();
                //     },
                //   ),
                // ),
                ListTile(
                  title: const Text('Adaptador direccion'),
                  subtitle: Text(state.address),
                ),
                ListTile(
                  title: const Text('Adaptador nombre'),
                  subtitle: Text(state.name),
                  onLongPress: null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
