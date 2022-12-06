// import 'package:flutter/material.dart';

// import './MainPage.dart';

// void main() => runApp(new ExampleApplication());

// class ExampleApplication extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: MainPage());
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'src/presentation/bloc/bluetooth_bloc.dart';
import 'src/presentation/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await sl.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BluetoothBloc(
        instanceBlue: FlutterBluetoothSerial.instance,
      ),
      child: const MaterialApp(
        title: 'Flutter Bluetooth',
        home: HomePage(),
      ),
    );
  }
}
