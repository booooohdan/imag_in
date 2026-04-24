import 'package:flutter/material.dart';
import 'package:imag_in/core/utils/enums/app_state.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/core/widgets/consumer_state_widget.dart';

class AppStateScreen extends StatelessWidget {
  const AppStateScreen(
    this.appState, {
    this.navigationErrorMessage,
    this.navigationPath,
    super.key,
  });

  final AppState appState;
  final String? navigationErrorMessage;
  final String? navigationPath;

  @override
  Widget build(BuildContext context) {
    switch (appState) {
      case AppState.loading:
        return const Scaffold(
          backgroundColor: Colors.teal,
          body: ConsumerStateWidget(ConsumerState.loading),
        );
      case AppState.navigationError:
        return Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(title: const Text('Navigation error')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error: "$navigationErrorMessage"',
                textAlign: TextAlign.center,
              ),
              Text('Full path: $navigationPath'),
              SizedBox(height: 24, width: MediaQuery.of(context).size.width),
              const Text(
                'Uh-oh, the error 🙄\nSend this screenshot via feedback',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      case AppState.noInternet:
        return const Scaffold(
          backgroundColor: Colors.teal,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.wifi_off, size: 42),
                ),
                Text('No internet connection'),
                Text('Please connect to a network'),
              ],
            ),
          ),
        );
    }
  }
}
