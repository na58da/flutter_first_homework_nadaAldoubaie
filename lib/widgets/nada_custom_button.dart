import 'package:flutter/material.dart';
import 'package:nada_first_homework/utils/nada_app_colors.dart';

class NadaCustomButton extends StatefulWidget {
  final String nadaText;
  final VoidCallback nadaOnPressed;
  final bool nadaIsSmall;
  final Widget? nadaIcon;
  final AnimationController? nadaAnimationController;
  final Animation<double>? nadaAnimation;

  const NadaCustomButton({
    super.key,
    required this.nadaText,
    required this.nadaOnPressed,
    this.nadaIsSmall = false,
    this.nadaIcon,
    this.nadaAnimationController,
    this.nadaAnimation,
  });

  @override
  State<NadaCustomButton> createState() => _NadaCustomButtonState();
}

class _NadaCustomButtonState extends State<NadaCustomButton> {
  @override
  Widget build(BuildContext context) {
    Widget button = Container(
      height: widget.nadaIsSmall ? 36 : 60,
      width: widget.nadaIsSmall ? null : 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [NadaAppColors.nadaPrimary, NadaAppColors.nadaSecondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(widget.nadaIsSmall ? 8 : 16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF35367F).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.nadaAnimationController?.forward().then((_) {
            widget.nadaAnimationController?.reverse();
          });
          widget.nadaOnPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: widget.nadaIsSmall ? 12 : 32,
            vertical: widget.nadaIsSmall ? 8 : 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.nadaIsSmall ? 8 : 16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.nadaIcon != null) ...[
              widget.nadaIcon!,
              SizedBox(width: widget.nadaIsSmall ? 8 : 12),
            ],
            Text(
              widget.nadaText,
              style: TextStyle(
                fontSize: widget.nadaIsSmall ? 14 : 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.nadaAnimation != null) {
      return ScaleTransition(
        scale: widget.nadaAnimation!,
        child: button,
      );
    }

    return button;
  }
} 