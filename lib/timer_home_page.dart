import 'dart:async'; // Importiert das Paket für Timer und asynchrone Operationen
import 'package:flutter/material.dart'; // Importiert das Paket für Material Design Widgets

class StopWatchScreen extends StatefulWidget {
  // Definiert ein StatefulWidget namens StopWatchScreen
  const StopWatchScreen(
      {super.key}); // Konstruktor der Klasse mit einem Schlüssel für die Widget-Hierarchie

  @override
  StopWatchScreenState createState() =>
      StopWatchScreenState(); // Erstellt den Zustand für das StatefulWidget
}

class StopWatchScreenState extends State<StopWatchScreen> {
  // Definiert die State-Klasse für StopWatchScreen
  final Stopwatch _stopwatch =
      Stopwatch(); // Erstellt eine Instanz der Stopwatch-Klasse zur Zeitmessung
  Timer?
      _timer; // Deklariert einen optionalen Timer, der verwendet wird, um die Benutzeroberfläche periodisch zu aktualisieren

  // Methode zum Starten der Stoppuhr
  Future<void> _startWatch() async {
    // Asynchrone Funktion zum Starten der Stoppuhr
    setState(() {
      // Setzt den Zustand und benachrichtigt Flutter, die UI neu zu rendern
      _stopwatch.start(); // Startet die Stoppuhr
    });
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      // Erstellt einen Timer, der alle 30 Millisekunden läuft
      setState(() {}); // Aktualisiert die UI jedes Mal, wenn der Timer auslöst
    });
  }

  // Methode zum Stoppen der Stoppuhr
  Future<void> _stopWatch() async {
    // Asynchrone Funktion zum Stoppen der Stoppuhr
    setState(() {
      // Setzt den Zustand und benachrichtigt Flutter, die UI neu zu rendern
      _stopwatch.stop(); // Stoppt die Stoppuhr
    });
    _timer?.cancel(); // Beendet den Timer, falls er läuft
  }

  // Methode zum Zurücksetzen der Stoppuhr
  Future<void> _resetWatch() async {
    // Asynchrone Funktion zum Zurücksetzen der Stoppuhr
    setState(() {
      // Setzt den Zustand und benachrichtigt Flutter, die UI neu zu rendern
      _stopwatch.reset(); // Setzt die Stoppuhr zurück auf 0
    });
    _timer?.cancel(); // Beendet den Timer, falls er läuft
  }

  // Methode zum Formatieren der verstrichenen Zeit
  String _formattedTime() {
    // Funktion, die die verstrichene Zeit formatiert
    final duration =
        _stopwatch.elapsed; // Holt die verstrichene Zeit von der Stoppuhr
    String twoDigits(int n) => n
        .toString()
        .padLeft(2, '0'); // Hilfsfunktion, um Zahlen zweistellig zu formatieren
    String threeDigits(int n) => n
        .toString()
        .padLeft(3, '0'); // Hilfsfunktion, um Zahlen dreistellig zu formatieren
    String minutes = twoDigits(duration.inMinutes
        .remainder(60)); // Berechnet die Minuten, die vergangen sind
    String seconds = twoDigits(duration.inSeconds
        .remainder(60)); // Berechnet die Sekunden, die vergangen sind
    String milliseconds = threeDigits(
        duration.inMilliseconds.remainder(1000)); // Berechnet die Millisekunden
    return "$minutes:$seconds:$milliseconds"; // Gibt die formatierte Zeit als String zurück
  }

  @override
  Widget build(BuildContext context) {
    // Baut das UI des Widgets auf
    return Scaffold(
      // Das grundlegende Layout des Bildschirms
      appBar: AppBar(title: const Text("Stopwatch Timer")), // App-Bar mit Titel
      body: Center(
        // Zentriert den Inhalt des Bildschirms
        child: Column(
          // Arrangiert die Kinder-Widgets vertikal
          mainAxisAlignment: MainAxisAlignment
              .center, // Zentriert die Kinder-Widgets auf der vertikalen Achse
          children: <Widget>[
            // Liste der Kinder-Widgets
            // Anzeige der verstrichenen Zeit
            Text(
              _formattedTime(), // Zeigt die formatierte Zeit an
              style: Theme.of(context)
                      .textTheme
                      .headlineMedium ?? // Setzt den Stil des Textes
                  const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight
                          .bold), // Falls keine headlineMedium vorhanden ist, wird ein Standardstil verwendet
            ),
            const SizedBox(
                height:
                    50), // Abstand zwischen der Zeit-Anzeige und den Buttons
            // Zeile (Row), die drei Buttons enthält
            Row(
              // Ordnet die Kinder-Widgets horizontal an
              mainAxisAlignment: MainAxisAlignment
                  .center, // Zentriert die Buttons in der Zeile
              children: [
                // Liste der Buttons in der Zeile
                ElevatedButton(
                  // Erster Button für Start
                  onPressed: _stopwatch.isRunning
                      ? null
                      : _startWatch, // Wenn die Stoppuhr läuft, ist der Button deaktiviert, sonst wird _startWatch aufgerufen
                  child: const Text('Start'), // Text auf dem Button
                ),
                const SizedBox(width: 20), // Abstand zwischen den Buttons
                ElevatedButton(
                  // Zweiter Button für Stop
                  onPressed: _stopwatch.isRunning
                      ? _stopWatch
                      : null, // Wenn die Stoppuhr nicht läuft, ist der Button deaktiviert, sonst wird _stopWatch aufgerufen
                  child: const Text('Stop'), // Text auf dem Button
                ),
                const SizedBox(width: 20), // Abstand zwischen den Buttons
                ElevatedButton(
                  // Dritter Button für Reset
                  onPressed: _resetWatch, // Ruft die _resetWatch-Funktion auf
                  child: const Text('Reset'), // Text auf dem Button
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
