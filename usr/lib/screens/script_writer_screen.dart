import 'package:flutter/material.dart';

class ScriptWriterScreen extends StatefulWidget {
  const ScriptWriterScreen({super.key});

  @override
  State<ScriptWriterScreen> createState() => _ScriptWriterScreenState();
}

class _ScriptWriterScreenState extends State<ScriptWriterScreen> {
  final TextEditingController _topicController = TextEditingController();
  String _selectedFormat = 'Reels/Shorts (60 sec)';
  bool _isLoading = false;
  String? _generatedScript;

  final List<String> _formats = [
    'Reels/Shorts (60 sec)',
    'YouTube Video (5-10 min)',
    'TikTok',
  ];

  void _generateScript() async {
    if (_topicController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _generatedScript = null;
    });

    // Simulating AI network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _generatedScript = '''
🎬 ফরম্যাট: $_selectedFormat
📝 টপিক: ${_topicController.text}

[হুক - প্রথম ৩ সেকেন্ড]
(ক্যামেরার দিকে তাকিয়ে এনার্জেটিক ভয়েস)
"আপনি কি জানেন, কন্টেন্ট ক্রিয়েশন শুরু করার জন্য দামি ক্যামেরার কোনো প্রয়োজন নেই?"

[বডি - মূল অংশ]
(স্ক্রিনে কিছু টেক্সট পপ-আপ হবে)
"হ্যাঁ, ঠিকই শুনেছেন! আপনার হাতের স্মার্টফোনটি দিয়েই আপনি শুরু করতে পারেন। 
প্রথমত, দরকার একটি ভালো আইডিয়া। 
দ্বিতীয়ত, ন্যাচারাল লাইট বা জানালার পাশে দাঁড়িয়ে ভিডিও করা। 
আর তৃতীয়ত, কনফিডেন্স! ভুল হোক, তবুও শুরু করুন।"

[কল টু অ্যাকশন - শেষ ৫ সেকেন্ড]
"আজই আপনার প্রথম ভিডিও রেকর্ড করুন। আর কন্টেন্ট ক্রিয়েশন নিয়ে এমন আরও টিপস পেতে আমাকে ফলো করতে ভুলবেন না!"
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('স্ক্রিপ্ট রাইটার'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'ভিডিওর টপিক কী?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                hintText: 'যেমন: নতুন ইউটিউবারদের জন্য টিপস',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'ভিডিওর ধরন নির্বাচন করুন:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFormat,
                  isExpanded: true,
                  items: _formats.map((String format) {
                    return DropdownMenuItem<String>(
                      value: format,
                      child: Text(format),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedFormat = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _generateScript,
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
                  : const Text('স্ক্রিপ্ট লিখুন', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            if (_generatedScript != null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _generatedScript!,
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
