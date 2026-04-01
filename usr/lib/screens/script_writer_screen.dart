import 'package:flutter/material.dart';

class ScriptWriterScreen extends StatefulWidget {
  const ScriptWriterScreen({super.key});

  @override
  State<ScriptWriterScreen> createState() => _ScriptWriterScreenState();
}

class _ScriptWriterScreenState extends State<ScriptWriterScreen> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _characterController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _costumeController = TextEditingController();
  final TextEditingController _accentController = TextEditingController();
  
  String _selectedDuration = 'Reels/Shorts (60 sec)';
  bool _includeBreaks = true;
  
  bool _isLoading = false;
  String? _generatedScript;

  final List<String> _durations = [
    'Reels/Shorts (60 sec)',
    'Short Video (3 min)',
    'YouTube Video (5-10 min)',
    'Long Format (10+ min)',
  ];

  void _generateScript() async {
    if (_topicController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে অন্তত টপিক লিখুন!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _generatedScript = null;
    });

    // Simulating AI network delay
    await Future.delayed(const Duration(seconds: 2));

    final topic = _topicController.text;
    final theme = _themeController.text.isNotEmpty ? _themeController.text : 'সাধারণ';
    final characters = _characterController.text.isNotEmpty ? _characterController.text : '১ জন (নিজে)';
    final location = _locationController.text.isNotEmpty ? _locationController.text : 'স্টুডিও/রুম';
    final costume = _costumeController.text.isNotEmpty ? _costumeController.text : 'ক্যাজুয়াল';
    final accent = _accentController.text.isNotEmpty ? _accentController.text : 'শুদ্ধ বাংলা / স্বাভাবিক';
    
    final breaksText = _includeBreaks 
        ? '\n[ট্রানজিশন / ব্রেক: স্ক্রিন ব্ল্যাক আউট হয়ে নতুন সিনে যাবে]\n' 
        : '\n';

    setState(() {
      _isLoading = false;
      _generatedScript = '''
🎬 প্রোডাকশন ডিটেইলস:
-----------------------------------
📌 টপিক: $topic
🎭 থিম/ধরণ: $theme
⏱ সময়কাল: $_selectedDuration
📍 লোকেশন: $location
👕 পোশাক/কস্টিউম: $costume
🗣 ভয়েস/অ্যাকসেন্ট: $accent
👥 চরিত্র: $characters

📝 মূল স্ক্রিপ্ট:
-----------------------------------
[সিন ১ - হুক / শুরু]
(ক্যামেরা ওপেন হবে $location-এ। $characters $costume পরে আছে।)
ভয়েসওভার ($accent টোনে): "আপনারা কি জানেন, আজকের এই বিষয়টি কেন এত গুরুত্বপূর্ণ? চলুন দেখে নিই!"

$breaksText
[সিন ২ - বডি / মূল গল্প]
(ক্লোজ-আপ শট)
চরিত্রের সংলাপ: "আসলে $topic নিয়ে কাজ করাটা যতটা সহজ মনে হয়, ততটা নয়। এর পেছনে রয়েছে $theme-এর এক দারুণ গল্প।"
(বি-রোল বা ব্যাকগ্রাউন্ড ভিডিও চলবে)

$breaksText
[সিন ৩ - ক্লাইম্যাক্স ও শেষাংশ]
(ওয়াইড অ্যাঙ্গেল শট)
চরিত্র: "আশা করি আজকের এই ভিডিওটি আপনাদের ভালো লেগেছে। আপনার মতামত কমেন্টে জানান!"
(আউট্রো মিউজিক বাজবে এবং সাবস্ক্রাইব/ফলো করার অ্যানিমেশন আসবে)
''';
    });
  }

  @override
  void dispose() {
    _topicController.dispose();
    _themeController.dispose();
    _characterController.dispose();
    _locationController.dispose();
    _costumeController.dispose();
    _accentController.dispose();
    super.dispose();
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: icon != null ? Icon(icon, size: 20, color: Colors.blue.shade300) : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('অ্যাডভান্সড স্ক্রিপ্ট রাইটার'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: const Text(
                      'আপনার ভিডিও বা স্টোরির বিস্তারিত তথ্য দিন। যত বিস্তারিত দেবেন, স্ক্রিপ্ট তত ভালো হবে!',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  _buildInputField(
                    label: 'ভিডিওর টপিক (Topic) *',
                    controller: _topicController,
                    hint: 'যেমন: নতুন ইউটিউবারদের জন্য টিপস',
                    icon: Icons.topic,
                  ),
                  
                  _buildInputField(
                    label: 'থিম বা ধরণ (Theme)',
                    controller: _themeController,
                    hint: 'যেমন: কমেডি, হরর, মোটিভেশনাল, শিক্ষামূলক',
                    icon: Icons.category,
                  ),
                  
                  _buildInputField(
                    label: 'চরিত্র (Characters)',
                    controller: _characterController,
                    hint: 'যেমন: ২ জন বন্ধু, একজন বস ও কর্মচারী',
                    icon: Icons.people,
                  ),
                  
                  _buildInputField(
                    label: 'স্থান বা লোকেশন (Location)',
                    controller: _locationController,
                    hint: 'যেমন: কফি শপ, অফিস, গ্রামের রাস্তা',
                    icon: Icons.location_on,
                  ),
                  
                  _buildInputField(
                    label: 'পোশাক (Costume/Cloth)',
                    controller: _costumeController,
                    hint: 'যেমন: ফরমাল শার্ট, পাঞ্জাবি, ক্যাজুয়াল',
                    icon: Icons.checkroom,
                  ),
                  
                  _buildInputField(
                    label: 'ভয়েস অ্যাকসেন্ট (Voice Accent)',
                    controller: _accentController,
                    hint: 'যেমন: শুদ্ধ বাংলা, বরিশালের ভাষা, এনার্জেটিক',
                    icon: Icons.record_voice_over,
                  ),

                  const Text(
                    'সময়কাল (Duration)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDuration,
                        isExpanded: true,
                        items: _durations.map((String duration) {
                          return DropdownMenuItem<String>(
                            value: duration,
                            child: Text(duration),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedDuration = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SwitchListTile(
                    title: const Text(
                      'সিন ব্রেক ও ট্রানজিশন যুক্ত করুন',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('ভিডিওর মাঝে কাট বা ট্রানজিশন নির্দেশিকা'),
                    value: _includeBreaks,
                    activeColor: Colors.blue,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (bool value) {
                      setState(() {
                        _includeBreaks = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  ElevatedButton(
                    onPressed: _isLoading ? null : _generateScript,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('অ্যাডভান্সড স্ক্রিপ্ট তৈরি করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  if (_generatedScript != null)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.auto_awesome, color: Colors.blue.shade600),
                              const SizedBox(width: 8),
                              const Text(
                                'আপনার জেনারেটেড স্ক্রিপ্ট',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 30),
                          Text(
                            _generatedScript!,
                            style: const TextStyle(
                              fontSize: 15, 
                              height: 1.6,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
