import 'dart:async';

import 'package:chuck/api/unsplash_api.dart';
import 'package:chuck/bloc/photo_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  late final Dio dio;
  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image search'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.adaptive.arrow_back)),
        ),
        body: SafeArea(
          child: BlocProvider(
              create: (context) => PhotoBloc(UnsplashApi(Dio())),
              child: BlocBuilder<PhotoBloc, PhotoState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoTextField(
                              placeholder: 'Search for some photos on Unsplash',
                              onChanged: (value) {
                                search(value, context);
                              },
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: state.photos.length,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () async {
                                          if (await canLaunch(state
                                              .photos[index].links['html']!)) {
                                            launch(state
                                                .photos[index].links['html']!);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8, left: 8, right: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(state
                                                      .photos[index]
                                                      .urls['regular']!),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${state.photos[index].name ?? ''}${state.photos[index].description ?? ''}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                  textAlign: TextAlign.start,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )))
                        ],
                      ),
                    );
                  }
                },
              )),
        ));
  }

  void search(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        BlocProvider.of<PhotoBloc>(context).add(Search(value));
      }
    });
  }
}
