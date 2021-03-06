import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "A/B Testing",
    home: FutureBuilder<RemoteConfig>(
      future: setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        if (snapshot.hasData) {
          return Home(remoteConfig: snapshot.requireData);
        } else {
          return Container(
          child: Text("No data available"),
        );
        }
      },
    ),
  )
  );
}

Future<RemoteConfig> setupRemoteConfig() async {

  final RemoteConfig remoteConfig = RemoteConfig.instance;

  await remoteConfig.fetch();
  await remoteConfig.activate();
  return remoteConfig;
}