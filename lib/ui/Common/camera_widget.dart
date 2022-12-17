import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatefulWidget {
  final Function(File) onFile;
  const CameraWidget({
    Key? key,
    required this.onFile,
  }) : super(key: key);

  @override
  State<CameraWidget> createState() => CameraWidgetState();
}

class CameraWidgetState extends State<CameraWidget> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    var cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller!.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return const SizedBox.shrink();
    }

    var camera = controller!.value;
    return LayoutBuilder(builder: ((context, constraints) {
      var scale = (min(constraints.maxWidth, constraints.maxHeight) /
              max(constraints.maxWidth, constraints.maxHeight)) *
          camera.aspectRatio;

      if (scale < 1) {
        scale = 1 / scale;
      }

      return Stack(
        children: [
          Transform.scale(
            scale: scale,
            child: Center(
              child: CameraPreview(controller!),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  width: 60,
                  height: 60,
                  child: IconButton(
                    icon: const Icon(Icons.camera),
                    iconSize: 50,
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      var file = await controller!.takePicture();
                      widget.onFile(File(file.path));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      );
    }));
  }
}
