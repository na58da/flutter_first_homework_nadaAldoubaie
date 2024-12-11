import 'package:flutter/material.dart';
import '../utils/nada_app_colors.dart';

class NadaCustomTextField extends StatefulWidget {
  final String nadaLabel;
  final String nadaHint;
  final IconData nadaIcon;
  final bool nadaIsEmail;
  final Function(String) nadaOnChanged;
  final String? Function(String?) nadaValidator;
  final Color nadaTextColor;

  const NadaCustomTextField({
    super.key,
    required this.nadaLabel,
    required this.nadaHint,
    required this.nadaIcon,
    this.nadaIsEmail = false,
    required this.nadaOnChanged,
    required this.nadaValidator,
    this.nadaTextColor = NadaAppColors.nadaWhite,
  });

  @override
  State<NadaCustomTextField> createState() => _NadaCustomTextFieldState();
}

class _NadaCustomTextFieldState extends State<NadaCustomTextField> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  InputDecoration _nadaBuildDecoration() {
    return InputDecoration(
      labelText: widget.nadaLabel,
      hintText: widget.nadaHint,
      prefixIcon: Icon(widget.nadaIcon, color: widget.nadaTextColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: widget.nadaTextColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: widget.nadaTextColor.withOpacity(0.7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: widget.nadaTextColor),
      ),
      labelStyle: TextStyle(color: widget.nadaTextColor),
      hintStyle: TextStyle(color: widget.nadaTextColor.withOpacity(0.7)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: TextFormField(
          decoration: _nadaBuildDecoration().copyWith(
            prefixIcon: AnimatedScale(
              scale: _isFocused ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(widget.nadaIcon, 
                color: _isFocused 
                  ? widget.nadaTextColor 
                  : widget.nadaTextColor.withOpacity(0.7)
              ),
            ),
          ),
          keyboardType: widget.nadaIsEmail ? TextInputType.emailAddress : TextInputType.text,
          onChanged: widget.nadaOnChanged,
          validator: widget.nadaValidator,
          onTap: () => setState(() => _isFocused = true),
          onTapOutside: (_) => setState(() => _isFocused = false),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 