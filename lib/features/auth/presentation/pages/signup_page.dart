
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  static const green = Color(0xFF287D35);
  static const cream = Color(0xFFFAF7F0);
  static const ink = Color(0xFF1F3024);
  static const muted = Color(0xFF68766B);

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitSignup() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Form registrasi siap. Integrasi Django API belum dipasang.',
        ),
      ),
    );
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
              _buildWelcome(),
              _buildSignupForm(),
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
              _navItem('Home', () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
              _navItem('Marketplace'),
              _navItem('Events'),
              _navItem('Education'),
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

  Widget _navItem(String title, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title belum tersedia.')),
        );
      },
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
  Widget _buildWelcome() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      height: 490,
      decoration: const BoxDecoration(
        color: Color(0xFFE9F0E5),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          Center(
            child: SizedBox(
              height: 245,
              width: 210,
              child: CustomPaint(
                painter: RegisterPlantPainter(),
              ),
            ),
          ),

          const SizedBox(height: 35),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Join EcoLove\ntoday.',
              style: TextStyle(
                color: ink,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
            ),
          ),

          const SizedBox(height: 27),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'Create an account to discover pre-loved items, share stories, and sell your belongings.',
              style: TextStyle(
                color: muted,
                fontSize: 16,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SIGNUP FORM
  Widget _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 38, 18, 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create an account',
              style: TextStyle(
                color: ink,
                fontSize: 29,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Start your eco-friendly journey with us.',
              style: TextStyle(
                color: muted,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 34),

            _fieldLabel('Username'),
            const SizedBox(height: 9),

            TextFormField(
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration('Choose a username'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 28),

            _fieldLabel('Email'),
            const SizedBox(height: 9),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration(
                'Enter your email address',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email wajib diisi';
                }

                final emailRegex =
                    RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                if (!emailRegex.hasMatch(value.trim())) {
                  return 'Format email tidak valid';
                }

                return null;
              },
            ),

            const SizedBox(height: 28),

            _fieldLabel('Password'),
            const SizedBox(height: 9),

            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submitSignup(),
              decoration: _inputDecoration(
                'Create a password',
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

                if (value.length < 8) {
                  return 'Password minimal 8 karakter';
                }

                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return 'Password harus memiliki huruf kapital';
                }

                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Password harus memiliki karakter khusus';
                }

                return null;
              },
            ),

            const SizedBox(height: 12),

            const Text(
              '* Minimum 8 characters, containing at least 1 uppercase letter and 1 unique character (e.g., !, @12).',
              style: TextStyle(
                color: muted,
                fontSize: 12,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 38),

            SizedBox(
              width: double.infinity,
              height: 49,
              child: FilledButton(
                onPressed: _submitSignup,
                style: FilledButton.styleFrom(
                  backgroundColor: green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: muted,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Log in here',
                    style: TextStyle(
                      color: green,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
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
        vertical: 17,
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
class RegisterPlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const scale = 0.9;

    canvas.save();

    canvas.translate(12, 0);
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
      ..moveTo(90, 260)
      ..lineTo(90, 75);

    canvas.drawPath(
      stem,
      Paint()
        ..color = const Color(0xFF2F803A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
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
  bool shouldRepaint(covariant RegisterPlantPainter oldDelegate) {
    return false;
  }
}
