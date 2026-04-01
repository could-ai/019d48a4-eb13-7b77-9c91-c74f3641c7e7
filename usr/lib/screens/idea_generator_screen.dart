import 'package:flutter/material.dart';

class IdeaGeneratorScreen extends StatefulWidget {
  const IdeaGeneratorScreen({super.key});

  @override
  State<IdeaGeneratorScreen> createState() => _IdeaGeneratorScreenState();
}

class _IdeaGeneratorScreenState extends State<IdeaGeneratorScreen> {
  final TextEditingController _interestController = TextEditingController();
  bool _isLoading = false;
  String? _generatedIdeas;

  void _generateIdeas() async {
    if (_interestController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedIdeas = null;
    });

    // Simulating AI network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _generatedIdeas = '''
আপনার জন্য কিছু দারুণ কন্টেন্ট আইডিয়া:

১. "আমার প্রথম দিন কন্টেন্ট ক্রিয়েটর হিসেবে" - একটি মিনি ভ্লগ যেখানে আপনি আপনার সেটআপ এবং শুরুর গল্প বলবেন।
২. "৫টি ভুল যা নতুন ক্রিয়েটররা করে" - শিক্ষামূলক ভিডিও যা অন্যদের সাহায্য করবে।
৩. "আমার প্রিয় গ্যাজেট" - আপনি ভিডিও বানাতে কী কী ব্যবহার করেন তার একটি রিভিউ।
৪. "Behind the Scenes" - একটি ভিডিওর পেছনের গল্প এবং এডিটিং প্রসেস।
৫. "Q&A সেশন" - দর্শকদের কিছু সাধারণ প্রশ্নের উত্তর দিন।

টিপস: প্রথমে শর্টস (Shorts) বা রিলস (Reels) দিয়ে শুরু করুন, এতে রিচ (Reach) বেশি পাওয়া যায়!
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('টপিক আইডিয়া'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'আপনার কী ধরনের বিষয় পছন্দ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _interestController,
              decoration: InputDecoration(
                hintText: 'যেমন: টেকনোলজি, ট্রাভেল, লাইফস্টাইল, বা রান্না...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateIdeas,
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
                  : const Text('আইডিয়া তৈরি করুন', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 30),
            if (_generatedIdeas != null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _generatedIdeas!,
                      style: const TextStyle(fontSize: 16, height: 1.5),
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
