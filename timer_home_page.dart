import 'dart:async';
import 'package:flutter/material.dart';

class TimerHomePage extends StatefulWidget {
  const TimerHomePage({super.key});

  @override
  TimerHomePageState createState() => TimerHomePageState();
}

class TimerHomePageState extends State<TimerHomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {});
    });
  }

  Future<void> simulateDataFetch() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Simulacija dohvata podataka
  }

  void _toggleTimer() async {
    await simulateDataFetch(); // Čeka završetak simuliranog dohvata podataka
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
        setState(() {});
      });
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {});
  }

  String _formattedTime() {
    final duration = _stopwatch.elapsed;
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch Timer")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formattedTime(),
              style: Theme.of(context).textTheme.headlineMedium ??
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _toggleTimer,
              child: Text(_stopwatch.isRunning ? 'Stop' : 'Start'),
            ),
            ElevatedButton(
              onPressed: _resetTimer,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
