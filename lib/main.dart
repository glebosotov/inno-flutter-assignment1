import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '/about.dart';
import '/bloc/joke_bloc.dart';
import '/model/model.dart';
import 'api/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chuck Norris jokes',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
          textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 14))),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocProvider(
            create: (context) => JokeBloc(NetworkApi(
                Dio(BaseOptions(baseUrl: 'https://api.chucknorris.io')))),
            child: BlocConsumer<JokeBloc, JokeState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Expanded(
                        child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: (state is JokeReady)
                                ? jokeCard(state.joke, context)
                                : state is SearchResults
                                    ? ListView.builder(
                                        itemBuilder: (context, index) => Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: jokeCard(
                                                  state.result.result[index],
                                                  context),
                                            ),
                                        itemCount: state.result.total)
                                    : const CircularProgressIndicator
                                        .adaptive()),
                      ),
                      const SizedBox(height: 32),
                      CupertinoTextField(
                        placeholder: 'Look for a joke',
                        maxLength: 120,
                        textInputAction: TextInputAction.search,
                        autocorrect: false,
                        controller: _controller,
                        focusNode: _focusNode,
                        clearButtonMode: OverlayVisibilityMode.editing,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            BlocProvider.of<JokeBloc>(context).add(GetJoke());
                          }
                        },
                        onEditingComplete: () {
                          if (_controller.text.length < 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Search query must have at least 3 letters')));
                          } else {
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<JokeBloc>(context)
                                .add(Search(_controller.text));
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            child: const Icon(Icons.info, size: 24),
                            onPressed: () {
                              showAboutDialog(context: context, children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          const link =
                                              'https://t.me/glebosotov';
                                          if (await canLaunch(link)) {
                                            launch(link);
                                          }
                                        },
                                        child: Chip(
                                            label: Text('Telegram'),
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                                const Text(
                                    'Hi! My name is Gleb Osotov and I develop mobile apps. It\'s been about 6 years total and about 1.5 years of commercial develepment. I consider myself advanced in Flutter, pretty adequate in SwiftUI and very good in UIKit. The journey started with Java Android, but let\'s not remember the dark days. \nUnsplash API is a free one and only supports 50 requests per hour'),
                              ]);
                            },
                            // icon: const ,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            child: const Icon(Icons.image, size: 24),
                            onPressed: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => const ImagesPage());
                            },
                            // icon: const ,
                          ),
                          PopupMenuButton<String>(
                            itemBuilder: (context) =>
                                BlocProvider.of<JokeBloc>(context)
                                    .categories
                                    .map((e) =>
                                        PopupMenuItem(value: e, child: Text(e)))
                                    .toList(),
                            onSelected: (option) =>
                                BlocProvider.of<JokeBloc>(context)
                                    .add(NewCategory(option)),
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Theme.of(context).colorScheme.primary),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(CupertinoIcons.gear_alt_fill,
                                      size: 24, color: Colors.white),
                                  Text(state.category,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24))),
                            child: Row(
                              children: const [
                                Icon(CupertinoIcons.arrow_2_circlepath,
                                    size: 24),
                                SizedBox(width: 4),
                                Text('Refresh'),
                              ],
                            ),
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                _controller.text = '';
                              }
                              BlocProvider.of<JokeBloc>(context)
                                  .add(GetJoke(category: state.category));
                            },
                            // icon: const ,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
                listener: (context, state) {})),
      ),
    ));
  }

  Widget jokeCard(Joke joke, BuildContext context) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(joke.url)) {
          launch(joke.url);
        }
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Image.network(
                joke.iconUrl,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress?.cumulativeBytesLoaded !=
                      loadingProgress?.expectedTotalBytes) {
                    return CircularProgressIndicator.adaptive();
                  } else {
                    return Center(
                      child: child,
                    );
                  }
                },
              ),
              const SizedBox(width: 4),
              Flexible(
                  child: Text(joke.value,
                      style: Theme.of(context).textTheme.bodyText1)),
            ],
          )),
    );
  }
}
