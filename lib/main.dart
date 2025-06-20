import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kwiat_flutter/ble_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BLE SCANNER 2.0"),),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (BleController controller)
          {
            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       StreamBuilder<List<ScanResult>>(
            //           stream: controller.scanResults,
            //           builder: (context,snapshot){
            //             if (snapshot.hasData){
            //               return ListView.builder(
            //                 itemBuilder: (context,index){
            //                   final data = snapshot.data![index];
            //                   return Card(
            //                     elevation: 2,
            //                     child: ListTile(
            //                       title: Text(data.device.platformName),
            //                       subtitle: Text(data.device.remoteId.str),
            //                       trailing: Text(data.rssi.toString()),
            //                     ),
            //                   );
            //                 },
            //               );
            //             }else{
            //               return Center(child: Text("No Device Found"),);
            //             }
            //           }),
            //       SizedBox(height: 10,),
            //       ElevatedButton(onPressed: ()=>controller.scanDevices(), child: Text("SCAN")),
            //     ],
            //   ),
            // );
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<ScanResult>>(
                    stream: controller.scanResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(data.device.platformName),
                                subtitle: Text(data.device.remoteId.str),
                                trailing: Text(data.rssi.toString()),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No Device Found"));
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.scanDevices(),
                  child: const Text("SCAN"),
                ),
                const SizedBox(height: 20),
              ],
            );

          }
      )
    );
  }
}
