import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:ionicons/ionicons.dart';

class CustomSelectInput extends StatelessWidget {
  final IconData? prefixIcon;
  final String? hintText;
  final String? labelText;
  final void Function(Object?)? onChanged;
  final List<DropdownMenuItem<Object?>>? items;

  const CustomSelectInput({ super.key, this.hintText = '', this.labelText, this.prefixIcon, this.onChanged, this.items });

  Widget get _label {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            labelText ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelText != null ? _label : Container(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF777777)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField(
            items: items,
            onChanged: (value) => onChanged!(value),
            icon: Container(),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: prefixIcon != null
                ? const EdgeInsets.only(bottom: 0, top: 8)
                : const EdgeInsets.only(bottom: 0, top: 6, left: 16),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFFD9D9D9),
              ),
              border: InputBorder.none,
              prefixIcon: prefixIcon != null ? IconButton(
                padding: EdgeInsets.all(10),
                icon: Icon(
                  prefixIcon,
                  color: Color(0xFF777777),
                  size: 24,
                ),
                onPressed: null,
              ) : null,
              suffixIcon: IconButton(
                icon: Container(
                  child: const Icon(
                    Ionicons.chevron_down,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
                onPressed: null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}