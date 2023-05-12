import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            TextButton(
                onPressed: () async {
                  await SpotifySdk.connectToSpotifyRemote(
                      clientId: "a6095f30db144fcaabb6dbca14794ef2",
                      redirectUrl:
                          "http://192.168.0.111:4444/api/v1/spotify/spotifyCallback");
                },
                child: const Text('data')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getAccessToken();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<String> getAccessToken() async {
  try {
    var authenticationToken = await SpotifySdk.getAccessToken(
        // clientId: "a6095f30db144fcaabb6dbca14794ef2",
        clientId: 'e613ef199dd84656bdaaaaf9a6285457',
        redirectUrl: "http://192.168.0.111:4444/api/v1/spotify/spotifyCallback",
        scope: 'app-remote-control, '
            'user-modify-playback-state, '
            'playlist-read-private, '
            'user-follow-read, '
            'playlist-modify-public,user-read-currently-playing');
    log('Got a token: $authenticationToken');
    return authenticationToken;
  } on PlatformException catch (e) {
    log(e.code + e.message.toString());
    return Future.error('$e.code: $e.message');
  } on MissingPluginException {
    log('not implemented');
    return Future.error('not implemented');
  }
}
