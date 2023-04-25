import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

//import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Tensor extends StatefulWidget {
  const Tensor({required this.file, super.key});
  final File file;
  @override
  State<Tensor> createState() => _TensorState();
}

class _TensorState extends State<Tensor> {
  //final _image = widget.file;
  double _imageHeight = 0;
  double _imageWidth = 0;
  List _recognitions = [];
  //bool _busy = false;
  List<dynamic> detect = [];

  @override
  void initState() {
    //loadModel();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await loadModel();

    super.didChangeDependencies();
  }

  Future loadModel() async {
    print('resloadModel........');
    Tflite.close();
    print('Tflite.close .......');
    String? res = await Tflite.loadModel(
      model: //'assets/exaples/yolov2_tiny.tflite',
          'assets/detect.tflite',
      // 'assets/ssd_mobilenet_v1_1_metadata_1.tflite',
      labels: 'assets/labelmap.txt',
      // labels: 'assets/exaples/yolov2_tiny.txt',
      //useGpuDelegate: false,
    );
    print('res========$res');
  }

  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == []) return [];
    if (_recognitions == [] || _imageWidth == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageWidth * screen.width;
    Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    return _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    File _image = widget.file;

    Size size = MediaQuery.of(context).size;
    print('MediaQuery()---------------$size-----');
    List<Widget> stackChildren = [];
    FileImage(_image)
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageHeight = info.image.height.toDouble();
        _imageWidth = info.image.width.toDouble();
        print('_imageHeight=====$_imageHeight');
      });
    }));
    // setState(() {
    //   //_image = image;
    //   // _busy = false;
    // });

    // detect = (await Tflite.detectObjectOnImage(
    //   path: image.path,
    //   //model: 'YOLO',
    //   threshold: 0.5,
    //   numResultsPerClass: 1,
    //   numBoxesPerBlock: 2,
    // ))!;

    //   setState(() {
    //     print(detect);
    //     //_recognitions = detect;
    //   });
    // }

    if (_image != null) {
      stackChildren.addAll(
        renderBoxes(size),
      );
    }

    // stackChildren.add(
    //   Center(
    //     child: Column(
    //       children: _recognitions.map((res) {
    //         print('res============$res');
    //         return Text(
    //           // 'Text bbbbbbbbbbbbbbbbbbbbbbbbbbb',
    //           "- ${res["detectedClass"]}: ${res["confidenceInClass"]}",
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 30.0,
    //             background: Paint()..color = Color.fromARGB(255, 252, 249, 249),
    //           ),
    //         );
    //       }).toList(),
    //     ),
    //   ),
    // );
    stackChildren.add(
      _image == null
          ? Text('No image selected.')
          : Container(
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         alignment: Alignment.topCenter,
              //         image: MemoryImage(Uint8List.fromList(
              //             _recognitions.map((e) => int.parse(e)).toList())),
              //         fit: BoxFit.fill)),
              child: Opacity(opacity: 0.6, child: Image.file(_image!))),
    );

    return Stack(children: stackChildren);

    // List<Widget> renderBoxes(Size screen) {
    //   if (_recognitions == []) return [];
    //   if (_recognitions == [] || _imageWidth == null) return [];

    //   double factorX = screen.width;
    //   double factorY = _imageHeight / _imageWidth * screen.width;
    //   Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    //   return _recognitions.map((re) {
    //     return Positioned(
    //       left: re["rect"]["x"] * factorX,
    //       top: re["rect"]["y"] * factorY,
    //       width: re["rect"]["w"] * factorX,
    //       height: re["rect"]["h"] * factorY,
    //       child: Container(
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //           border: Border.all(
    //             color: blue,
    //             width: 2,
    //           ),
    //         ),
    //         child: Text(
    //           "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
    //           style: TextStyle(
    //             background: Paint()..color = blue,
    //             color: Colors.white,
    //             fontSize: 12.0,
    //           ),
    //         ),
    //       ),
    //     );
    //   }).toList();
    // }
  }
}
