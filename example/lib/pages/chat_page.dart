import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_ui/gem_ui.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    return Scaffold(
      appBar: DsAppBar(title: 'Chat Primitives'),
      backgroundColor: c.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.screenPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sent bubble
            Align(
              alignment: Alignment.centerRight,
              child: DsChatBubble(
                isSent: true,
                child: Text(
                  'Hey! How are you?',
                  style: AppTextStyles.body.copyWith(color: c.onBubbleSent),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            // Received bubble
            Align(
              alignment: Alignment.centerLeft,
              child: DsChatBubble(
                isSent: false,
                child: Text(
                  "I'm doing well, thanks for asking!",
                  style: AppTextStyles.body.copyWith(color: c.onBubbleReceived),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.md.h),
            // System messages
            DsChatSystemMessage(
              text: 'You are now connected',
              type: DsSystemMessageType.neutral,
            ),
            DsChatSystemMessage(
              text: 'Message recall: "Hello World"',
              type: DsSystemMessageType.warning,
            ),
            DsChatSystemMessage(
              text: 'John joined the group',
              type: DsSystemMessageType.accent,
            ),
            SizedBox(height: AppSpacing.xl.h),
          ],
        ),
      ),
    );
  }
}
