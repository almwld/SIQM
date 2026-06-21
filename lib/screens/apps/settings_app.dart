import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  final List<String> _themeColors = ['Turquoise', 'Cyan', 'Green', 'Blue', 'Purple', 'Orange'];

  Color _getColorFromName(String name) {
    switch(name) {
      case 'Turquoise': return const Color(0xFF00BCD4);
      case 'Cyan': return Colors.cyan;
      case 'Green': return Colors.green;
      case 'Blue': return Colors.blue;
      case 'Purple': return Colors.purple;
      case 'Orange': return Colors.orange;
      default: return const Color(0xFF00BCD4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context);
    final isDark = tp.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Color(0xFF00BCD4))),
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00BCD4)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          _buildSection('Appearance', Icons.palette, [
            _buildSwitch('Dark Mode', tp.isDarkMode, (v) => tp.toggleTheme()),
            _buildThemeSelector(tp),
            _buildSlider('Font Size', tp.fontSize, 10, 24, (v) => tp.setFontSize(v)),
            _buildSlider('Icon Size', tp.iconSize, 48, 78, (v) => tp.setIconSize(v)),
          ]),
          _buildSection('Security', Icons.security, [
            _buildPinChanger(tp),
            _buildInfo('Encryption', 'AES-256 Active'),
          ]),
          _buildSection('About', Icons.info, [
            _buildInfo('Version', '4.0.0'),
            _buildInfo('Build', '2027.06.16'),
            _buildInfo('Developer', 'Zion Security Team'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF00BCD4)),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Color(0xFF00BCD4), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ...children,
        const Divider(color: Color(0xFF00BCD4)),
      ],
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
          Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF00BCD4)),
        ],
      ),
    );
  }

  Widget _buildThemeSelector(ThemeProvider tp) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Theme Color', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 14)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: _themeColors.map((color) => GestureDetector(
              onTap: () {
                tp.setThemeColor(color);
                tp.setPrimaryColor(_getColorFromName(color));
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getColorFromName(color),
                  shape: BoxShape.circle,
                  border: tp.themeColor == color ? Border.all(color: Colors.white, width: 2) : null,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String title, double value, double min, double max, Function(double) onChanged) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
              Text('${value.toStringAsFixed(1)}', style: const TextStyle(color: Color(0xFF00BCD4))),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFF00BCD4),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildPinChanger(ThemeProvider tp) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Change PIN', style: TextStyle(color: Color(0xFF00BCD4))),
          backgroundColor: Colors.black,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Current PIN',
                  labelStyle: TextStyle(color: Color(0xFF00BCD4)),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newCtrl,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'New PIN (4 digits)',
                  labelStyle: TextStyle(color: Color(0xFF00BCD4)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            TextButton(
              onPressed: () {
                if (oldCtrl.text == tp.pin && newCtrl.text.length == 4) {
                  tp.setPin(newCtrl.text);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN changed successfully'), backgroundColor: Color(0xFF00BCD4)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red),
                  );
                }
              },
              child: const Text('Save', style: TextStyle(color: Color(0xFF00BCD4))),
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.lock, color: Color(0xFF00BCD4)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Change PIN', style: TextStyle(color: Color(0xFF00BCD4))),
                  Text(
                    'Current: ****',
                    style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 11),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF00BCD4)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
          ),
          Text(value, style: TextStyle(color: isDark ? Colors.white54 : Colors.black54)),
        ],
      ),
    );
  }
}
