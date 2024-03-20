import 'package:antarmitra/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:image/image.dart' as img;

enum DetectionStatus { noFace, fail, success }

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  late WebSocketChannel channel;
  DetectionStatus? status;

  void showSessionCompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Session Completed"),
          content: const Text("Your meditation session has been completed."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  var count = 0;
  String get currentStatus {
    if (status == null) {
      return "Initializing...";
    }
    switch (status!) {
      case DetectionStatus.noFace:
        count++;
        return "No Face in screen!!";
      case DetectionStatus.fail:
        return "Unrecognized Face in screen";
      case DetectionStatus.success:
        return "Familiar face in screen!";
    }
  }

  Color get currentStatusColor {
    if (status == null) {
      return Colors.grey;
    }
    switch (status!) {
      case DetectionStatus.noFace:
        return Colors.grey;
      case DetectionStatus.fail:
        return Colors.red;
      case DetectionStatus.success:
        return Colors.greenAccent;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
    initializeWebSocket();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras[1]; // back 0th index & front 1st index

    controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller!.initialize();
    setState(() {});

    Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final image = await controller!.takePicture();
        final compressedImageBytes = compressImage(image.path);
        channel.sink.add(compressedImageBytes);
      } catch (_) {}
    });
  }

  void initializeWebSocket() {
    // 0.0.0.0 -> 10.0.2.2 (emulator)
    channel = IOWebSocketChannel.connect('ws://192.168.95.106:8765');
    channel.stream.listen((dynamic data) {
      debugPrint(data);
      data = jsonDecode(data);
      if (data['data'] == null) {
        debugPrint('Server error occurred in recognizing face');
        return;
      }
      switch (data['data']) {
        case 0:
          status = DetectionStatus.noFace;
          break;
        case 1:
          status = DetectionStatus.fail;
          break;
        case 2:
          status = DetectionStatus.success;
          break;
        default:
          status = DetectionStatus.noFace;
          break;
      }
      setState(() {});
    }, onError: (dynamic error) {
      debugPrint('Error: $error');
    }, onDone: () {
      debugPrint('WebSocket connection closed');
    });
  }

  Uint8List compressImage(String imagePath, {int quality = 85}) {
    final image =
        img.decodeImage(Uint8List.fromList(File(imagePath).readAsBytesSync()))!;
    final compressedImage =
        img.encodeJpg(image, quality: quality); // lossless compression
    return compressedImage;
  }

  @override
  void dispose() {
    controller?.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!(controller?.value.isInitialized ?? false)) {
      return const SizedBox();
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),
          Row(
            children: [
              Align(
                alignment: const Alignment(0, .85),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      surfaceTintColor: currentStatusColor),
                  child: Text(
                    currentStatus,
                    style: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 50),
              Align(
                alignment: const Alignment(0, .85),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      surfaceTintColor: currentStatusColor),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                ),
              ),
              TimerWidget(
                duration: const Duration(minutes: 2),
                onFinish: showSessionCompleteDialog,
              ),
            ],
          )
        ],
      ),
    );
  }
}
