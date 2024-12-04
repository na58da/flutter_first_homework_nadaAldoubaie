import 'package:flutter/material.dart';
import '../utils/nada_app_colors.dart';

class NadaCustomTextField extends StatelessWidget {
  final String nadaLabel;
  final String nadaHint;
  final IconData nadaIcon;
  final bool nadaIsEmail;
  final Function(String) nadaOnChanged;
  final String? Function(String?) nadaValidator;

  const NadaCustomTextField({
    super.key,
    required this.nadaLabel,
    required this.nadaHint,
    required this.nadaIcon,
    this.nadaIsEmail = false,
    required this.nadaOnChanged,
    required this.nadaValidator,
  });

  InputDecoration _buildDecoration() {
    return InputDecoration(
      labelText: nadaLabel,
      hintText: nadaHint,
      prefixIcon: Icon(nadaIcon, color: NadaAppColors.nadaTextSecondary),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: NadaAppColors.nadaTextSecondary),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: NadaAppColors.nadaTextSecondary),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: NadaAppColors.nadaPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: _buildDecoration(),
      keyboardType: nadaIsEmail ? TextInputType.emailAddress : TextInputType.text,
      onChanged: nadaOnChanged,
      validator: nadaValidator,
    );
  }
} 