import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/screens/results/results.dart';
import 'package:guatah/screens/search/search.dart';
import 'package:ionicons/ionicons.dart';

class CustomInput extends StatelessWidget {
  final bool searchType;
  final String? hintText;
  final String? labelText;

  const CustomInput({ super.key,  this.searchType = false, this.hintText = '', this.labelText });

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
          padding: const EdgeInsets.only(right: 12),
          child: TextField(
            onSubmitted: (value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultsPage()),
              );
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding: searchType
                ? const EdgeInsets.only(bottom: 8, top: 14)
                : const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFFD9D9D9),
              ),
              border: InputBorder.none,
              // mantém a borda para focus mudar de cor?
              prefixIcon: searchType ? const IconButton(
                padding: EdgeInsets.all(10),
                icon: Icon(
                  Ionicons.search,
                  color: Color(0xFF777777),
                  size: 24,
                ),
                onPressed: null,
              ) : null,
              suffixIcon: searchType ? IconButton(
                // padding: EdgeInsets.all(10),
                icon: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF777777),
                      ),
                    ),
                  ),
                  child: const Icon(
                    Ionicons.options,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
              ) : null,
            ),
          ),
        ),
      ],
    );
  }
}