import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_image_search/presentation/home/components/photo_widget.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<HomeViewModel>();

      _subscription = viewModel.eventStream.listen((event) {
        event.when(showSnackBar: (message) {
          final snackBar = SnackBar(content: Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('이미지 검색 앱',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  context.read<HomeViewModel>().fetch(_controller.text);
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        state.isLoading
            ? const CircularProgressIndicator()
            : Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final photo = state.photos[index];
                      return PhotoWidget(
                        photo: photo,
                      );
                    }),
              )
      ]),
    );
  }
}
