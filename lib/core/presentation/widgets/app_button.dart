import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.visible,
    required this.isLoading,
    this.content = "",
    this.onTap,
  });

  final bool visible;
  final bool isLoading;
  final String? content;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: visible || isLoading ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: visible
              ? isLoading
                  ? Colors.blueAccent.withOpacity(0.2)
                  : Colors.blueAccent
              : Colors.grey,
        ),
        height: 55,
        width: double.infinity,
        child: Stack(
          children: [
            Opacity(
              opacity: isLoading ? 1 : 0,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Center(child: Text(content!)),
          ],
        ),
      ),
    );
  }
}
