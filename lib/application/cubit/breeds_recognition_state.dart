part of 'breeds_recognition_cubit.dart';

@freezed
class BreedsRecognitionState with _$BreedsRecognitionState {
  const factory BreedsRecognitionState.initial() = BreedsRecognitionInitial;

  const factory BreedsRecognitionState.loadInProgress() =
      BreedsRecognitionInProgress;

  const factory BreedsRecognitionState.success({
    required Duration time,
    required double confidence,
    required String label,
    required String imagePath,
  }) = BreedsRecognitionSuccess;

  const factory BreedsRecognitionState.error(String msg) =
      BreedsRecognitionError;
}
