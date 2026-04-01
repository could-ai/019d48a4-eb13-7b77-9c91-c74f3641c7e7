import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaptionGeneratorScreen extends StatefulWidget {
  const CaptionGeneratorScreen({super.key});

  @override
  State<CaptionGeneratorScreen> createState() => _CaptionGeneratorScreenState();
}

class _CaptionGeneratorScreenState extends State<CaptionGeneratorScreen> {
  final TextEditingController _descController = TextEditingController();
  bool _isLoading = false;
  String? _generatedCaption;

  void _generateCaption() async {
    if (_descController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedCaption = null;
    });

    // Simulating AI network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _generatedCaption = '''
✨ নতুন শুরু, নতুন স্বপ্ন! ✨

আজ থেকে আনুষ্ঠানিকভাবে আমার কন্টেন্ট ক্রিয়েশন যাত্রা শুরু হলো। অনেক দিনের ইচ্ছে ছিল নিজের চিন্তাভাবনা এবং ক্রিয়েটিভিটি আপনাদের সাথে শেয়ার করার। জানি পথটা সহজ হবে না, কিন্তু আপনাদের সাপোর্ট থাকলে অসম্ভব কিছু নয়! 

সাথেই থাকুন, দারুণ কিছু আসতে চলেছে! ❤️👇

#NewBeginnings #ContentCreator #BangladeshiCreator #DreamBig #FirstPost #CreatorJourney #Inspiration
''';
    });
  }

  void _copyToClipboard() {
    if (_generatedCaption != null) {
      Clipboard.setData(ClipboardData(text: _generatedCaption!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ক্যাপশন কপি করা হয়েছে!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ক্যাপশন ও হ্যাশট্যাগ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'আপনার পোস্ট বা ছবি সম্পর্কে কিছু লিখুন:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                hintText: 'যেমন: আজ আমার প্রথম ইউটিউব ভিডিও আপলোড করলাম...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateCaption,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('ক্যাপশন তৈরি করুন', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            if (_generatedCaption != null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.pink.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'আপনার ক্যাপশন:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, color: Colors.pink),
                            onPressed: _copyToClipboard,
                            tooltip: 'কপি করুন',
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            _generatedCaption!,
                            style: const TextStyle(fontSize: 16, height: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
