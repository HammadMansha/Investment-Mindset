// ignore_for_file: prefer_final_fields, unnecessary_this, unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:investment_mindset/constants/app_colors.dart';

///New special chat bubble type
///
///chat bubble color can be customized using [color]
///chat bubble tail can be customized  using [tail]
///chat bubble display message can be changed using [text]
///[text] is the only required parameter
///message sender can be changed using [isSender]
///chat bubble [TextStyle] can be customized using [textStyle]
class ChatUi extends StatelessWidget {
  final bool isSender;
  final VoidCallback onPressed;
  final String firstName;
  final String lastName;
  final String text;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final TextStyle senderNameStyle;
  final String names;
  final String time;

  final TextStyle recieverNameStyle;

  const ChatUi({
    Key? key,
    this.isSender = true,
    required this.onPressed,
    required this.firstName,
    this.time = '',
    required this.names,
    required this.lastName,
    required this.text,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    this.senderNameStyle = const TextStyle(
        color: AppColors.whiteColor, fontSize: 13, fontWeight: FontWeight.w900),
    this.recieverNameStyle = const TextStyle(
        color: AppColors.commonColor,
        fontSize: 13,
        fontWeight: FontWeight.w900),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            isSender
                ? Container()
                : CircleAvatar(
                    backgroundColor: AppColors.commonColor,
                    child: Text(
                      names.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onLongPress: onPressed,
                child: CustomPaint(
                  painter: SpecialChatBubbleTwo(
                      color: color,
                      alignment:
                          isSender ? Alignment.topRight : Alignment.topLeft,
                      tail: tail),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .8,
                    ),
                    margin: isSender
                        ? stateTick
                            ? const EdgeInsets.fromLTRB(7, 7, 14, 7)
                            : const EdgeInsets.fromLTRB(7, 7, 17, 7)
                        : const EdgeInsets.fromLTRB(17, 7, 7, 7),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: stateTick
                                  ? const EdgeInsets.only(right: 20)
                                  : const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                              child: Text(
                                "${firstName} ${lastName}",
                                style: isSender
                                    ? senderNameStyle
                                    : recieverNameStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: stateTick
                                  ? const EdgeInsets.only(right: 20)
                                  : const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                              child: Text(
                                text,
                                style: textStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                        stateIcon != null && stateTick
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: isSender
                                    ? Row(
                                        children: [
                                          Text(
                                            time,
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          stateIcon,
                                        ],
                                      )
                                    : SizedBox(
                                        child: Text(
                                          time,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                              )
                            : const SizedBox(
                                width: 1,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///custom painter use to create the shape of the chat bubble
///
/// [color],[alignment] and [tail] can be changed
class SpecialChatBubbleTwo extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  SpecialChatBubbleTwo({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  double _radius = 10.0;
  double _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      if (tail) {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width - 8,
              size.height,
              bottomLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
            ),
            Paint()
              ..color = this.color
              ..style = PaintingStyle.fill);
        var path = Path();
        path.moveTo(size.width - _x, 4);
        path.lineTo(size.width - _x, size.height - 5);
        path.lineTo(size.width, size.height);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              size.width - _x,
              0.0,
              size.width,
              size.height,
            ),
            Paint()
              ..color = this.color
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width - 8,
              size.height,
              bottomLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
            ),
            Paint()
              ..color = this.color
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              8,
              0,
              size.width,
              size.height,
              bottomRight: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = this.color
              ..style = PaintingStyle.fill);
        var path = Path();
        path.moveTo(_x, 4);
        path.lineTo(0, size.height);
        path.lineTo(_x, size.height - 5);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0.0,
              _x,
              size.height,
              topRight: Radius.circular(_radius),
            ),
            Paint()
              ..color = this.color
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              8,
              0,
              size.width,
              size.height,
              bottomRight: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = this.color
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
