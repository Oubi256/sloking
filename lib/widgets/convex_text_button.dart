import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConvexTextButton extends StatefulWidget {
  final double elevation;
  final String label;
  final Duration duration;
  final void Function()? onPressed;
  const ConvexTextButton({
    super.key,
    required this.label,
    this.elevation = 4,
    this.duration = const Duration(milliseconds: 50),
    this.onPressed,
  });

  @override
  State<ConvexTextButton> createState() => _ConvexTextButtonState();
}

class _ConvexTextButtonState extends State<ConvexTextButton> {
  late double _elevation;
  late bool _enabled;

  BorderSide _emptyBorderSide(bool enabled) =>  BorderSide(
    color: enabled ? const Color(0xFFFFB400) : const Color(0xFF595959),
    width: 0,
  );

  @override
  void initState() {
    _elevation = widget.elevation;
    _enabled = widget.onPressed != null;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ConvexTextButton oldWidget) {
    _enabled = widget.onPressed != null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!_enabled) return;
        setState(() {
          _elevation = 0;
        });
      },
      onTapUp: (_) {
        setState(() {
          _elevation = widget.elevation;
        });
      },
      onTap: widget.onPressed,
      child: SizedBox(
        height: 62.h,
        child: AnimatedContainer(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: widget.elevation - _elevation),
          duration: widget.duration,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25 * _elevation / widget.elevation),
                blurRadius: 24,
                offset: Offset(0, 8.h * _elevation / widget.elevation),
              ),
            ],
            gradient: LinearGradient(
              colors: _enabled ? const [Color(0xFFFFF069), Color(0xFFFFE600)] : const [Color(0xFFAEAEAE), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border(
              bottom: BorderSide(
                color: _enabled ? const Color(0xFFFFB400) : const Color(0xFF595959),
                width: _elevation,
              ),
              top: _emptyBorderSide(_enabled),
              left: _emptyBorderSide(_enabled),
              right: _emptyBorderSide(_enabled),
            ),
          ),
          child: Text(widget.label, style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w800, fontSize: 20.sp)),
        ),
      ),
    );
  }
}
