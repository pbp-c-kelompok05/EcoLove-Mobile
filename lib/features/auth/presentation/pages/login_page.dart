
import 'package:flutter/material.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  static const green = Color(0xFF287D35);
  static const cream = Color(0xFFFAF7F0);
  static const ink = Color(0xFF1F3024);
  static const muted = Color(0xFF68766B);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Form login siap. Integrasi Django API belum dipasang.',
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _goHome() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      _showMessage('Kamu sedang berada di halaman Login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),

              _buildWelcomeSection(),

              _buildLoginForm(),

              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Container(
      height: 168,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1D3428),
            Color(0xFF76A97A),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EcoLove',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
              Image.asset(
                'assets/images/ecolove_logo.png',
                width: 31,
                height: 31,
                fit: BoxFit.contain,
              ),
            ],
          ),

          const SizedBox(height: 19),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem('Home', _goHome),
              _navItem('Marketplace', _goHome),
              _navItem('Events', _goHome),
              _navItem('Education', _goHome),
            ],
          ),

          const SizedBox(height: 9),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // WELCOME SECTION
  Widget _buildWelcomeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 510,
      decoration: const BoxDecoration(
        color: Color(0xFFE9F0E5),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(22),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 35),

          SizedBox(
            height: 265,
            width: 220,
            child: CustomPaint(
              painter: PlantPainter(),
            ),
          ),

          const SizedBox(height: 20),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome back.',
                style: TextStyle(
                  color: ink,
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'One account to discover items and sell preloved goods.',
              style: TextStyle(
                color: muted,
                fontSize: 17,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LOGIN FORM
  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 42, 20, 38),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Log in to EcoLove',
              style: TextStyle(
                color: ink,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 9),

            const Text(
              'Continue your eco-friendly journey.',
              style: TextStyle(
                color: muted,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 36),

            _fieldLabel('Username'),

            const SizedBox(height: 9),

            TextFormField(
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(
                'Enter your username',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 34),

            _fieldLabel('Password'),

            const SizedBox(height: 9),

            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submitLogin(),
              decoration: _inputDecoration(
                'Enter your password',
              ).copyWith(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  icon: Icon(
                    _hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: muted,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 49,
              child: FilledButton(
                onPressed: _submitLogin,
                style: FilledButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: muted,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: green,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              'You will return to your destination page after logging in.',
              style: TextStyle(
                color: muted,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: ink,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: muted,
        fontSize: 14,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 19,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDDE5DC),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFDDE5DC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: green,
          width: 1.5,
        ),
      ),
    );
  }

  // FOOTER
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: green,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      child: const Text(
        '© 2026 EcoLove. Faculty of Computer Science, University of Indonesia.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.6,
        ),
      ),
    );
  }
}

// PLANT ILLUSTRATION
class PlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = (size.width / 180).clamp(
      0.1,
      size.height / 260,
    );

    canvas.save();

    canvas.translate(
      (size.width - 180 * scale) / 2,
      (size.height - 260 * scale) / 2,
    );

    canvas.scale(scale);

    final fillPaint = Paint()
      ..color = const Color(0xFF94A88F)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFF2F803A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.round;

    final stem = Path()
      ..moveTo(90, 245)
      ..lineTo(90, 75);

    canvas.drawPath(
      stem,
      Paint()
        ..color = const Color(0xFF2F803A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.square,
    );

    final leftLeaf = Path()
      ..moveTo(90, 155)
      ..cubicTo(45, 151, 7, 129, 14, 80)
      ..cubicTo(17, 49, 25, 24, 32, 10)
      ..cubicTo(68, 14, 93, 44, 90, 100)
      ..close();

    canvas.drawPath(leftLeaf, fillPaint);
    canvas.drawPath(leftLeaf, strokePaint);

    final rightLeaf = Path()
      ..moveTo(92, 122)
      ..cubicTo(91, 75, 121, 22, 171, 0)
      ..cubicTo(182, 43, 175, 78, 148, 101)
      ..cubicTo(130, 115, 110, 120, 92, 127)
      ..close();

    canvas.drawPath(rightLeaf, fillPaint);
    canvas.drawPath(rightLeaf, strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant PlantPainter oldDelegate) {
    return false;
  }
}
