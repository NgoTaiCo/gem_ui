import 'package:flutter/material.dart';
import 'package:gem_ui/gem_ui.dart';
import 'package:widgetbook/widgetbook.dart';

final textFieldComponent = WidgetbookComponent(
  name: 'DsTextField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: DsTextField(
            labelText: 'Full Name',
            hintText: 'Enter your name',
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'With Error',
      builder: (context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: DsTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
            errorText: 'Invalid email address',
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: DsTextField(
            labelText: 'User ID',
            hintText: 'Cannot be changed',
            enabled: false,
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Password',
      builder: (context) => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: DsTextField(
            labelText: 'Password',
            hintText: 'Enter password',
            obscureText: true,
          ),
        ),
      ),
    ),
  ],
);

final searchFieldComponent = WidgetbookComponent(
  name: 'DsSearchField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DsSearchField(
            controller: TextEditingController(),
            hintText: 'Search contacts...',
          ),
        ),
      ),
    ),
  ],
);

final otpFieldComponent = WidgetbookComponent(
  name: 'DsOtpField',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => const Center(
        child: DsOtpField(length: 6),
      ),
    ),
    WidgetbookUseCase(
      name: '4 Digits',
      builder: (context) => const Center(
        child: DsOtpField(length: 4),
      ),
    ),
  ],
);
