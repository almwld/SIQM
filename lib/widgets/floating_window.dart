import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FloatingWindow extends StatefulWidget {
  final String title;
  final Widget child;
  final VoidCallback onClose;
  final VoidCallback? onMinimize;
  final VoidCallback? onMaximize;
  final Offset? initialPosition;
  final Size? initialSize;
  final int windowId;

  const FloatingWindow({
    super.key,
    required this.title,
    required this.child,
    required this.onClose,
    this.onMinimize,
    this.onMaximize,
    this.initialPosition,
    this.initialSize,
    required this.windowId,
  });

  @override
  State<FloatingWindow> createState() => _FloatingWindowState();
}

class _FloatingWindowState extends State<FloatingWindow> {
  late Offset _position;
  late Size _size;
  bool _isDragging = false;
  bool _isMaximized = false;
  bool _isMinimized = false;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition ?? const Offset(100, 100);
    _size = widget.initialSize ?? const Size(380, 480);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: _position.dx.clamp(0, screenWidth - _size.width),
      top: _position.dy.clamp(0, screenHeight - _size.height - 60),
      child: GestureDetector(
        onPanUpdate: (details) {
          if (!_isMaximized) {
            setState(() {
              _position += details.delta;
              _position = Offset(
                _position.dx.clamp(0, screenWidth - _size.width),
                _position.dy.clamp(0, screenHeight - _size.height - 60),
              );
            });
          }
        },
        child: Container(
          width: _isMaximized ? screenWidth - 40 : _size.width,
          height: _isMaximized ? screenHeight - 100 : _size.height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.95),
            borderRadius: BorderRadius.circular(_isMaximized ? 0 : 16),
            border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00BCD4).withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Title Bar
              _buildTitleBar(),
              // Content
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(_isMaximized ? 0 : 16),
                    bottomRight: Radius.circular(_isMaximized ? 0 : 16),
                  ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF00BCD4).withOpacity(0.15),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_isMaximized ? 0 : 16),
          topRight: Radius.circular(_isMaximized ? 0 : 16),
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF00BCD4).withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Close button
          _buildWindowButton(Icons.close, Colors.red, widget.onClose),
          const SizedBox(width: 8),
          // Minimize button
          _buildWindowButton(
            Icons.remove,
            Colors.amber,
            () => setState(() => _isMinimized = true),
          ),
          const SizedBox(width: 8),
          // Maximize/Restore button
          _buildWindowButton(
            _isMaximized ? Icons.fullscreen_exit : Icons.fullscreen,
            Colors.green,
            _toggleMaximize,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Color(0xFF00BCD4),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWindowButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 4,
            ),
          ],
        ),
        child: Icon(icon, size: 8, color: Colors.white),
      ),
    );
  }

  void _toggleMaximize() {
    setState(() {
      if (_isMaximized) {
        _size = const Size(380, 480);
        _position = const Offset(100, 100);
      } else {
        _size = Size(
          MediaQuery.of(context).size.width - 40,
          MediaQuery.of(context).size.height - 120,
        );
        _position = const Offset(20, 60);
      }
      _isMaximized = !_isMaximized;
    });
  }
}
