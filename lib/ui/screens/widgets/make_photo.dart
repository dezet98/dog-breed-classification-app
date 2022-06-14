import 'package:breeds_recognition/application/cubit/breeds_recognition_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MakePhoto extends StatelessWidget {
  const MakePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () => _pickImage(context),
        child: const Icon(Icons.camera),
      );

  void _pickImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    context.read<BreedsRecognitionCubit>().classify(image?.path);
  }
}
