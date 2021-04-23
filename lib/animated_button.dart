import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final double height, width, elevationValue, radius;
  final String beforeClickText, afterClickText;
  final Color buttonColor, textColor;
  final Duration duration;
  final IconData icon;

  const AnimatedButton({
    Key key,
    this.height,
    this.width,
    this.beforeClickText,
    this.afterClickText,
    this.buttonColor,
    this.textColor,
    this.elevationValue,
    this.radius,
    this.duration,
    this.icon,
  }) : super(key: key);
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;

  ButtonState _currentState;
  int countButtonPressed = 0;

  @override
  void initState() {
    super.initState();
    _currentState = ButtonState.SHOW_ONLY_TEXT;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.addListener(
      () {
        var _controllerValue = _controller.value;
        print(_controllerValue);
        if (_controllerValue < 0.2) {
          setState(() {
            _currentState = ButtonState.SHOW_ONLY_ICON;
          });
        } else if (_controllerValue > 0.8) {
          setState(() {
            _currentState = ButtonState.SHOW_TEXT_ICON;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevationValue,
      borderRadius: BorderRadius.circular(widget.radius),
      child: InkWell(
        onTap: () => {
          _controller.forward(),
          countButtonPressed++,
          // setState(() {
          //   _currentState = ButtonState.SHOW_ONLY_ICON;
          // }),
        },
        child: AnimatedContainer(
          duration: Duration(
              milliseconds: (widget.duration.inMilliseconds * 0.2).round()),
          decoration: BoxDecoration(
            border: Border.all(
                color: _currentState == ButtonState.SHOW_ONLY_TEXT
                    ? Colors.transparent
                    : widget.buttonColor,
                width: 2),
            borderRadius: BorderRadius.circular(widget.radius),
            color: _currentState == ButtonState.SHOW_ONLY_TEXT
                ? widget.buttonColor
                : widget.textColor,
          ),
          height: widget.height,
          width: (_currentState == ButtonState.SHOW_ONLY_ICON
              ? widget.width - widget.width * 0.6
              : widget.width),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AnimatedSize(
            vsync: this,
            duration: Duration(
                milliseconds: (widget.duration.inMilliseconds * 0.2).round()),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentState == ButtonState.SHOW_ONLY_ICON ||
                    _currentState == ButtonState.SHOW_TEXT_ICON)
                  Container(
                    padding: _currentState == ButtonState.SHOW_TEXT_ICON
                        ? const EdgeInsets.only(right: 20)
                        : const EdgeInsets.all(0),
                    child: Icon(
                      widget.icon,
                      color: widget.buttonColor,
                    ),
                  ),
                getTextWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (_currentState == ButtonState.SHOW_ONLY_ICON)
      return Container();
    else if (_currentState == ButtonState.SHOW_ONLY_TEXT)
      return Text(
        widget.beforeClickText,
        style: TextStyle(color: widget.textColor),
      );
    else {
      return Text(
        widget.afterClickText,
        style:
            TextStyle(color: widget.buttonColor, fontWeight: FontWeight.bold),
      );
    }
  }
}

enum ButtonState { SHOW_ONLY_TEXT, SHOW_ONLY_ICON, SHOW_TEXT_ICON }
