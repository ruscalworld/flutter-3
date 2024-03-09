import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class Joke {
  Joke({required this.text});

  final String text;
}

class Jokes {
  final List<Joke> _jokes = [
    Joke(
      text: "Лучше быть последним — первым, чем первым — последним.",
    ),
    Joke(
      text: "На случай, если буду нужен, то я там же, где и был, когда был не нужен.",
    ),
    Joke(
      text: "Если волк молчит то лучше его не перебивай.",
    ),
    Joke(
      text: "Каждый в цирке думает, что знает в цирке, но не каждый, что в цирке знает, что в цирке не каждый знает думает.",
    ),
    Joke(
      text: "Легко вставать, когда ты не ложился.",
    ),
    Joke(
      text: "За двумя зайцами погонишься — рыбку из пруда не выловишь, делу время, а отмеришь семь раз…",
    ),
    Joke(
      text: "Кем бы ты ни был, кем бы ты не стал, помни, где ты был и кем ты стал.",
    ),
    Joke(
      text: "Бесплатный сыр бывает только бесплатным.",
    ),
  ];

  final Random _random = Random();
  int _lastIndex = -1;

  Joke pick() {
    int i;

    do {
      i = _random.nextInt(_jokes.length);
    } while (i == _lastIndex);

    _lastIndex = i;
    return _jokes[i];
  }

  void add(Joke joke) {
    _jokes.add(joke);
  }
}

class NextJokeButton extends StatelessWidget {
  const NextJokeButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text("Другая шутка"),
    );
  }
}

class JokeContainer extends StatefulWidget {
  const JokeContainer({super.key, required this.jokes});

  final Jokes jokes;

  @override
  State<JokeContainer> createState() => _JokeContainerState();
}

class _JokeContainerState extends State<JokeContainer> {
  Joke? currentJoke;

  @override
  void initState() {
    super.initState();
    if (currentJoke == null) pickJoke();
  }

  void updateJoke() {
    setState(() {
      pickJoke();
    });
  }

  void pickJoke() {
    currentJoke = widget.jokes.pick();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 512,
          child: Text(currentJoke?.text ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        const SizedBox(height: 50),
        NextJokeButton(onPressed: updateJoke)
      ],
    );
  }
}

class NewJokeContainer extends StatelessWidget {
  final editController = TextEditingController();
  final Jokes jokes;

  NewJokeContainer({super.key, required this.jokes});

  void _addJoke() {
    jokes.add(Joke(text: editController.value.text));
    editController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Добавление новой шутки"),
        const SizedBox(height: 20),
        SizedBox(
          width: 512,
          child: TextField(
            controller: editController,
            decoration: const InputDecoration(
              label: Text("Введите шутку"),
            ),
            onSubmitted: (a) => _addJoke(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _addJoke,
          child: const Text("Добавить"),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Анекдот",
      style: TextStyle(
        fontSize: 40,
        color: Colors.orange,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Jokes _jokes = Jokes();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              const Title(),
              const SizedBox(height: 50),
              JokeContainer(jokes: _jokes),
              const SizedBox(height: 50),
              NewJokeContainer(jokes: _jokes),
            ],
          ),
        ),
      ),
    );
  }
}
