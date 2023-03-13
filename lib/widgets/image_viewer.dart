import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.url});
  final String url;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  void _saveWallpaper() async {
    try {
      await GallerySaver.saveImage(widget.url,
          toDcim: true, albumName: 'Downloaded Wallpapers');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallpaper saved to gallery'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save :'' $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(widget.url),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _saveWallpaper();
        }),
        child: SvgPicture.asset(
          'assets/icons/download.svg',
          height: 24,
        ),
      ),
    );
  }
}
