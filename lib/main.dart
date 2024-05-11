import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ShapeDrawer(),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Color.fromARGB(255, 174, 255, 0);
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Color.fromARGB(255, 3, 255, 57);
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ShapeDrawer extends StatefulWidget {
  const ShapeDrawer({super.key});

  @override
  _ShapeDrawerState createState() => _ShapeDrawerState();
}

class _ShapeDrawerState extends State<ShapeDrawer> {
  final controller = TextEditingController();
  CustomPainter? currentPainter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dibujar Figuras'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Escriba "triangulo" o "cuadrado"',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 29, 202, 208),
                ),
              ),
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  setState(() {
                    switch (controller.text.toLowerCase()) {
                      case 'triangulo':
                        currentPainter = TrianglePainter();
                        break;
                      case 'cuadrado':
                        currentPainter = SquarePainter();
                        break;
                      default:
                        currentPainter = null;
                    }
                  });
                },
              ),
              if (currentPainter != null)
                CustomPaint(
                  painter: currentPainter,
                  size: const Size(100, 100),
                )
              else
                const Text('Figura no encontrada'),
            ],
          ),
        ),
      ),
    );
  }
}
