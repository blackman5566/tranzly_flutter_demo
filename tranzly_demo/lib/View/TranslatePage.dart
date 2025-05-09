import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/TranslateResult.dart';
import '../ViewModel/TranslatePageViewModel.dart';

class TranslatePage extends ConsumerStatefulWidget {
  const TranslatePage({super.key});

  @override
  ConsumerState<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends ConsumerState<TranslatePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(translateViewModelProvider.notifier);
    final state = ref.watch(translateViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('翻譯小工具')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: '輸入文字'),
            ),
            const SizedBox(height: 16),
            DropdownButton<Language>(
              value: state.translatedLanguage,
              items: supportedLanguages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang.name),
                );
              }).toList(),
              onChanged: (lang) {
                vm.updateState(lang: lang!);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => vm.translate(_controller.text, state.translatedLanguage!.code),
              child: const Text('翻譯'),
            ),
            const SizedBox(height: 24),
            if (state.isLoading)
              const CircularProgressIndicator()
            else
              Text('翻譯結果：\n${state.translateResult?.translatedText ?? ""}'),
          ],
        ),
      ),
    );
  }
}
