import 'package:breeds_recognition/ui/screens/widgets/browse_gallery.dart';
import 'package:breeds_recognition/ui/screens/widgets/make_photo.dart';
import 'package:flutter/material.dart';

class PhotoOptions extends StatelessWidget {
  const PhotoOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          MakePhoto(),
          SizedBox(
            height: 16,
          ),
          BrowseGallery(),
          SizedBox(
            height: 8,
          ),
        ],
      );
}
