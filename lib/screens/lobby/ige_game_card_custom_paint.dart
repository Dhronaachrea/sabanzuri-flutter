import 'package:flutter/material.dart';

class StickerTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pathOrange = Path();
    final paintOrange = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xfffb3933);

    pathOrange.moveTo(-5, -5);
    pathOrange.lineTo(-5, size.height / 3 + 15);
    pathOrange.lineTo(size.width / 3 + 5, -5);
    pathOrange.close();

    final pathOrangeShadow = Path();
    final paintOrangeShadow = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xfffb3933);

    pathOrangeShadow.moveTo(-24, -24);
    pathOrangeShadow.lineTo(-24, size.height / 3);
    pathOrangeShadow.lineTo(size.width / 2, -24);
    pathOrangeShadow.close();

    // Close your line to where you started (0,0)
    pathOrange.close();

    // Draw your path
    //canvas.drawShadow(pathOrangeShadow, Colors.black, 5.0, true);
    canvas.drawPath(pathOrange, paintOrange);
  }

  /*@override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      Rect rect = Offset.zero & size;
      final double width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return <CustomPainterSemantics>[
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }*/

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(StickerTriangle oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(StickerTriangle oldDelegate) => false;
}

class CustomTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    TextSpan span = const TextSpan(style: TextStyle(
        shadows: <Shadow>[Shadow(offset: Offset(2.0, 3.0),
            blurRadius: 3.0,
            color: Color.fromARGB(255, 0, 0, 0))],
        color: Colors.white,
        fontWeight: FontWeight.bold, fontSize: 15), text: "NEW");
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    canvas.rotate(-0.80);
    canvas.translate(-25, 15);
    tp.layout();
    tp.paint(canvas, const Offset(2.0, 2.0)
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xffdf2c39)
      ..style = PaintingStyle.fill;

    var paint1Shadow = Paint()
      ..color = Color(0xFFEEEEEE)
      ..style = PaintingStyle.fill;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(40, 40), width: 90, height: 90),
      const Radius.circular(8),
    );
    //a rectangle
    //canvas.drawRect(Offset(10, 10) & Size(100, 100), paint1);

    RRect fullRectShadow = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(50, 50), width: 150, height: 150),
      const Radius.circular(8),
    );

    // Draw your path
    //canvas.drawRRect(fullRectShadow, paint1Shadow);
    canvas.drawRRect(fullRect, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

  /*@override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      Rect rect = Offset.zero & size;
      final double width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return <CustomPainterSemantics>[
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }*/

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
}

Widget customTextView(String textMessage) {
  return Padding(padding: const EdgeInsets.only(left: 18, bottom: 8),
      child: Container(color: Colors.pinkAccent,
          child: Center(child: Text(textMessage, style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
              backgroundColor: Colors.purple,
              letterSpacing: 5)))));
}