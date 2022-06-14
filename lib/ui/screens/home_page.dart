import 'dart:io';

import 'package:breeds_recognition/application/cubit/breeds_recognition_cubit.dart';
import 'package:breeds_recognition/ui/screens/utils/extensions.dart';
import 'package:breeds_recognition/ui/screens/widgets/breed_example.dart';
import 'package:breeds_recognition/ui/screens/widgets/photo_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Daniel Zaczek"),
          actions: [
            TextButton(
              onPressed: () => context.read<BreedsRecognitionCubit>().clear(),
              child: const Text(
                "Clear",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
            child: BlocBuilder<BreedsRecognitionCubit, BreedsRecognitionState>(
          builder: (context, state) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.map(
              initial: (_) => const _InitialView(),
              loadInProgress: (_) =>
                  const _CustomCenter(child: CircularProgressIndicator()),
              success: (state) => _SuccessView(state),
              error: (state) => _ErrorView(state),
            ),
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const PhotoOptions(),
      );
}

class _SuccessView extends StatelessWidget {
  final BreedsRecognitionSuccess state;
  const _SuccessView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.file(File(state.imagePath)),
          _DetailsRow(
            subtitle: "Breed",
            title: state.label.replaceAll('_', ' ').capitalize(),
          ),
          _DetailsRow(
            subtitle: "Confidence",
            title: state.confidence.toStringAsFixed(2) + " %",
          ),
          _DetailsRow(
            subtitle: "Time",
            title: state.time.inMilliseconds.toString() + " ms",
          ),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: BreedExample(
                            breedName: state.label.replaceAll('_', '-'),
                          ),
                        )
                      ],
                    );
                  });
            },
            child: const Text("About dog"),
          ),
          const SizedBox(
            height: 142,
          ),
        ],
      ),
    );
  }
}

class _DetailsRow extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DetailsRow({required this.title, required this.subtitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ),
      );
}

class _InitialView extends StatelessWidget {
  const _InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _CustomCenter(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              )),
          child: const Text("Choose or make photo"),
        ),
      );
}

class _ErrorView extends StatelessWidget {
  final BreedsRecognitionError state;
  const _ErrorView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _CustomCenter(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              )),
          child: Text(state.msg),
        ),
      );
}

class _CustomCenter extends StatelessWidget {
  final Widget child;
  const _CustomCenter({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [child],
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      );
}
