// Importa el paquete de Flutter Material Design.
import 'package:flutter/material.dart';

// Punto de entrada principal de la aplicación.
void main() {
  runApp(const MyApp());
}

// La clase MyApp es el widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este método construye el widget.
  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget de nivel superior que proporciona Material Design.
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // ShapeDrawer es el widget de inicio de la aplicación.
      home: const ShapeDrawer(),
    );
  }
}

// TrianglePainter es un CustomPainter que dibuja un triángulo.
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

// SquarePainter es un CustomPainter que dibuja un cuadrado.
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

// ShapeDrawer es un StatefulWidget que permite al usuario dibujar formas.
class ShapeDrawer extends StatefulWidget {
  const ShapeDrawer({super.key});

  @override
  _ShapeDrawerState createState() => _ShapeDrawerState();
}

// _ShapeDrawerState es el estado de ShapeDrawer.
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
              // Campo de texto para que el usuario ingrese la forma que desea dibujar.
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 29, 202, 208),
                ),
              ),
              // Botón que, cuando se presiona, dibuja la forma que el usuario ingresó.
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
              // Dibuja la forma que el usuario ingresó, o muestra un mensaje de error si la forma no es reconocida.
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
