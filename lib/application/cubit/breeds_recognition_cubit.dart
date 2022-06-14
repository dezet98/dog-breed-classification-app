import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tflite/tflite.dart';

part 'breeds_recognition_cubit.freezed.dart';
part 'breeds_recognition_state.dart';

class BreedsRecognitionCubit extends Cubit<BreedsRecognitionState> {
  BreedsRecognitionCubit() : super(const BreedsRecognitionState.initial()) {
    loadModel();
  }

  Future<void> loadModel() async {
    Tflite.loadModel(
      model: "assets/MobileNetV2.tflite",
      labels: "assets/labels.txt",
    );
  }

  void clear() {
    emit(const BreedsRecognitionState.initial());
  }

  Future<void> classify(String? imagePath) async {
    if (imagePath == null) {
      return emit(
          const BreedsRecognitionState.error("Error when load picture"));
    }

    try {
      emit(const BreedsRecognitionState.loadInProgress());
      final stopwatch = Stopwatch()..start();

      final output = await Tflite.runModelOnImage(
        path: imagePath,
        numResults: 120,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      final time = Duration(milliseconds: stopwatch.elapsedMilliseconds);
      final label = output![0]["label"];
      final confidence = output[0]["confidence"] * 100;

      emit(BreedsRecognitionState.success(
        imagePath: imagePath,
        time: time,
        label: label,
        confidence: confidence,
      ));
    } catch (_) {
      emit(const BreedsRecognitionState.error("Not recognized"));
    }
  }

  @override
  Future<void> close() async {
    await Tflite.close();
    return super.close();
  }
}
