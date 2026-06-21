import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'desktop_home.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = "";
  String _currentTime = "";

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        final now = DateTime.now();
        setState(() {
          _currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
        });
        _updateTime();
      }
    });
  }

  void _unlock() {
    final tp = Provider.of<ThemeProvider>(context, listen: false);
    if (_pinController.text == tp.pin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ZionDesktop()),
      );
    } else {
      setState(() {
        _errorMessage = "PIN INCORRECT";
        _pinController.clear();
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _errorMessage = "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF0A2E38), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFF00838F)]),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00BCD4).withOpacity(0.5),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text("Z", style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "ZION OS",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: Colors.white, letterSpacing: 8),
              ),
              const SizedBox(height: 50),
              Text(
                _currentTime,
                style: TextStyle(fontSize: screenWidth * 0.15, fontWeight: FontWeight.w200, color: Colors.white, letterSpacing: 6),
              ),
              const SizedBox(height: 50),
              Container(
                width: screenWidth * 0.65,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.5)),
                ),
                child: TextField(
                  controller: _pinController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF00BCD4),
                    fontSize: screenWidth * 0.07,
                    letterSpacing: 12,
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: const InputDecoration(
                    hintText: "••••",
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  onSubmitted: (_) => _unlock(),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 12, letterSpacing: 1)),
                ),
              const SizedBox(height: 40),
              SizedBox(
                width: screenWidth * 0.8,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: [
                    _buildButton("1"), _buildButton("2"), _buildButton("3"),
                    _buildButton("4"), _buildButton("5"), _buildButton("6"),
                    _buildButton("7"), _buildButton("8"), _buildButton("9"),
                    _buildButton(""), _buildButton("0"), _buildDeleteButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String num) {
    return GestureDetector(
      onTap: () {
        if (_pinController.text.length < 4) {
          _pinController.text += num;
          if (_pinController.text.length == 4) _unlock();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.3)),
        ),
        child: Center(
          child: Text(
            num,
            style: const TextStyle(color: Color(0xFF00BCD4), fontSize: 28, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: () {
        if (_pinController.text.isNotEmpty) {
          _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.3)),
        ),
        child: const Center(
          child: Icon(Icons.backspace, color: Color(0xFF00BCD4), size: 28),
        ),
      ),
    );
  }
}
