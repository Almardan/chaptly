import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';

class VerificationCodeInput extends StatefulWidget {
  final Function(String) onCompleted;
  final VoidCallback onResendCode;

  const VerificationCodeInput({
    super.key,
    required this.onCompleted,
    required this.onResendCode,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    String code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      widget.onCompleted(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    _focusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    _focusNodes[index - 1].requestFocus();
                  }
                  if (_controllers.every((c) => c.text.isNotEmpty)) {
                    _verifyCode();
                  }
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "If you didn't receive a code?",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            TextButton(
              onPressed: widget.onResendCode,
              child: const Text(
                'Resend',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            children: [
              ...List.generate(9, (index) => _buildNumberButton(index + 1)),
              _buildNumberButton('.'),
              _buildNumberButton(0),
              _buildBackspaceButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberButton(dynamic number) {
    return TextButton(
      onPressed: () {
        for (int i = 0; i < _controllers.length; i++) {
          if (_controllers[i].text.isEmpty) {
            _controllers[i].text = number.toString();
            if (i < _controllers.length - 1) {
              _focusNodes[i + 1].requestFocus();
            }
            if (_controllers.every((c) => c.text.isNotEmpty)) {
              _verifyCode();
            }
            break;
          }
        }
      },
      child: Text(
        number.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return IconButton(
      onPressed: () {
        for (int i = _controllers.length - 1; i >= 0; i--) {
          if (_controllers[i].text.isNotEmpty) {
            _controllers[i].clear();
            if (i > 0) {
              _focusNodes[i - 1].requestFocus();
            }
            break;
          }
        }
      },
      icon: const Icon(
        Icons.backspace_outlined,
        color: Colors.white,
      ),
    );
  }
}