import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ui_test/theme_notifier.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscurePassword = true;
  bool rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please fill in all fields",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );
      return;
    }
    if (_emailController.text.trim() != "email@email.com" ||
        _passwordController.text != "email") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Invalid credentials",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );
      return;
    }
    _handleLogin();
  }

  void _handleLogin() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, '/news');
  }

  Widget _buildSocialButton(String text, IconData icon, {Color? color}) {
    final bool isColored = color != null && color != Colors.white;
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: const Size(0, 40),
      ),
      icon: Icon(
        icon,
        color: isColored ? Colors.white : Colors.black,
        size: 16,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: isColored ? Colors.white : Colors.black,
          fontSize: 12,
          fontWeight: isColored ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget get _form {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/logo.png', height: 40),
          const SizedBox(height: 16),
          const Text(
            "Welcome Back",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Login to access your account",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 42,
            child: TextFormField(
              controller: _emailController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 42,
            child: TextFormField(
              controller: _passwordController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(fontSize: 12),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              obscureText: _obscurePassword,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const Text("Remember me", style: TextStyle(fontSize: 10)),
                ],
              ),
              Flexible(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Or Sign In With", style: TextStyle(fontSize: 10)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _buildSocialButton("Google", Icons.g_translate),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSocialButton("Facebook", Icons.facebook),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?",
                  style: TextStyle(fontSize: 10)),
              TextButton(
                onPressed: () {},
                child: Text("Sign Up",
                    style: TextStyle(
                        color: const Color(0xFFEF3054), fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (MediaQuery.of(context).viewInsets.bottom == 0) _loginButtonNormal,
        ],
      ),
    );
  }

  Widget get _loginButtonNormal {
    final Color mainColor = const Color(0xFFEF3054);
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onLoginPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "Log In",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFFEF3054);
    bool isMobile = defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
    bool isWide = MediaQuery.of(context).size.width >= 800;

    // Select background image based on theme:
    final String backgroundImage = themeNotifier.value == ThemeMode.dark
        ? 'assets/images/fondo.png'
        : 'assets/images/fondo-claro.png';

    return isWide
        ? Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: _form,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(backgroundImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: const RotatingMessages(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Switch(
                        value: themeNotifier.value == ThemeMode.dark,
                        onChanged: (bool value) {
                          setState(() {
                            themeNotifier.value =
                                value ? ThemeMode.dark : ThemeMode.light;
                          });
                        },
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Icon(Icons.wb_sunny,
                                  color: Colors.yellow, size: 20);
                            }
                            return const Icon(Icons.nightlight_round,
                                color: Colors.white, size: 20);
                          },
                        ),
                        thumbColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color.fromARGB(255, 13, 64, 106);
                            }
                            return Colors.black;
                          },
                        ),
                        activeColor: Colors.white,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottomSheet: isMobile &&
                    MediaQuery.of(context).viewInsets.bottom > 0 &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty
                ? SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onLoginPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  )
                : null,
            body: SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: _form,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Switch(
                        value: themeNotifier.value == ThemeMode.dark,
                        onChanged: (bool value) {
                          setState(() {
                            themeNotifier.value =
                                value ? ThemeMode.dark : ThemeMode.light;
                          });
                        },
                        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Icon(Icons.wb_sunny,
                                  color: Colors.yellow, size: 20);
                            }
                            return const Icon(Icons.nightlight_round,
                                color: Colors.white, size: 20);
                          },
                        ),
                        thumbColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color.fromARGB(255, 13, 64, 106);
                            }
                            return Colors.black;
                          },
                        ),
                        activeColor: Colors.white,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class RotatingMessages extends StatefulWidget {
  const RotatingMessages({Key? key}) : super(key: key);
  @override
  _RotatingMessagesState createState() => _RotatingMessagesState();
}

class _RotatingMessagesState extends State<RotatingMessages> {
  final List<String> messages = [
    'Did you know? The term "analytics" comes from the Greek word analytikos, which means "to break down into parts."',
    'Fun fact: 90% of the world’s data has been created in the last two years alone.',
    'Did you know? The first recorded use of data visualization dates back to the 17th century with maps and charts.',
    'Interesting! Predictive analytics can improve business efficiency by up to 30%.',
    'Surprising fact: The human brain processes visual data 60,000 times faster than text.',
    'Did you know? Google processes over 8.5 billion searches per day.',
    'Fun fact: The world\'s first data breach occurred in 1984 when a German hacker stole US military secrets.',
    'Did you know? By 2025, global data creation is expected to reach 181 zettabytes.',
    'Interesting! 75% of businesses say data analytics helps them make better decisions.',
    'Surprising fact: 2.5 quintillion bytes of data are created every day.',
    'Did you know? 80% of enterprise data is unstructured, making it difficult to analyze without AI.',
    'Fun fact: The concept of Big Data was first introduced in 2005 by Roger Magoulas.',
    'Interesting! Dark data refers to information collected but never analyzed or used.',
    'Surprising fact: Only 0.5% of all available data is ever analyzed and used.',
    'Did you know? Companies using AI-powered analytics see a 50% increase in decision-making speed.',
    'Fun fact: The world\'s first programmable computer, the Zuse Z3 (1941), was an early example of data processing.',
    'Interesting! 97% of businesses are investing in data analytics to stay competitive.',
    'Surprising fact: The term "data science" was first coined in 2001 by William S. Cleveland.',
    'Did you know? In 2023, AI-driven analytics saved businesses an estimated \$300 billion.',
    'Fun fact: Data visualization expert Edward Tufte once said, "The simple graph has brought more information to the data analyst’s mind than any other device."'
  ];
  late final int randomIndex;

  @override
  void initState() {
    super.initState();
    randomIndex = Random().nextInt(messages.length);
  }

  Map<String, String> _splitMessage(String message) {
    int sepIndex = message.indexOf('?');
    if (sepIndex == -1) {
      sepIndex = message.indexOf('!');
    }
    if (sepIndex == -1) {
      sepIndex = message.indexOf(':');
    }
    if (sepIndex != -1) {
      String question = message.substring(0, sepIndex + 1).trim();
      String answer = message.substring(sepIndex + 1).trim();
      return {'question': question, 'answer': answer};
    } else {
      return {'question': message, 'answer': ''};
    }
  }

  @override
  Widget build(BuildContext context) {
    // Choose text styles based on theme mode:
    final TextStyle questionStyle = themeNotifier.value == ThemeMode.dark
        ? const TextStyle(
            fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white)
        : const TextStyle(
            fontSize: 60, fontWeight: FontWeight.bold, color: Colors.black);
    final TextStyle answerStyle = themeNotifier.value == ThemeMode.dark
        ? const TextStyle(
            fontSize: 60, fontWeight: FontWeight.normal, color: Colors.white)
        : const TextStyle(
            fontSize: 60, fontWeight: FontWeight.normal, color: Colors.black);

    final split = _splitMessage(messages[randomIndex]);
    return StaggeredFadeTextDouble(
      key: ValueKey<int>(randomIndex),
      question: split['question']!,
      answer: split['answer']!,
      questionStyle: questionStyle,
      answerStyle: answerStyle,
      perWordMillis: 300,
    );
  }
}

class StaggeredFadeTextDouble extends StatefulWidget {
  final String question;
  final String answer;
  final TextStyle? questionStyle;
  final TextStyle? answerStyle;
  final int perWordMillis;
  // fadeOutMillis is no longer used.
  final VoidCallback? onCompleted;
  const StaggeredFadeTextDouble({
    Key? key,
    required this.question,
    required this.answer,
    this.questionStyle,
    this.answerStyle,
    this.perWordMillis = 300,
    this.onCompleted,
  }) : super(key: key);
  @override
  _StaggeredFadeTextDoubleState createState() =>
      _StaggeredFadeTextDoubleState();
}

class _StaggeredFadeTextDoubleState extends State<StaggeredFadeTextDouble>
    with SingleTickerProviderStateMixin {
  late final List<String> _questionWords;
  late final List<String> _answerWords;
  late final AnimationController _controller;
  late final int _totalWords;
  late final int _totalDurationMillis;

  @override
  void initState() {
    super.initState();
    _questionWords = widget.question.split(' ');
    _answerWords = widget.answer.split(' ');
    _totalWords = _questionWords.length + _answerWords.length;
    // Total duration for the fade-in animation per word.
    _totalDurationMillis = _totalWords * widget.perWordMillis;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _totalDurationMillis),
    )..forward();
  }

  double _wordOpacity(
      int wordIndex, double currentMillis, int wordCountOffset) {
    double start =
        (wordIndex * widget.perWordMillis + wordCountOffset).toDouble();
    double end =
        ((wordIndex + 1) * widget.perWordMillis + wordCountOffset).toDouble();
    if (currentMillis < start) {
      return 0.0;
    } else if (currentMillis < end) {
      return (currentMillis - start) / widget.perWordMillis;
    } else {
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double currentMillis = _controller.value * _totalDurationMillis;
        List<Widget> questionWidgets = [];
        for (int i = 0; i < _questionWords.length; i++) {
          double opacity = _wordOpacity(i, currentMillis, 0);
          questionWidgets.add(Opacity(
            opacity: opacity,
            child: Text(_questionWords[i] + ' ', style: widget.questionStyle),
          ));
        }
        List<Widget> answerWidgets = [];
        int answerOffset = _questionWords.length * widget.perWordMillis;
        for (int i = 0; i < _answerWords.length; i++) {
          double opacity = _wordOpacity(i, currentMillis, answerOffset);
          answerWidgets.add(Opacity(
            opacity: opacity,
            child: Text(_answerWords[i] + ' ', style: widget.answerStyle),
          ));
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(alignment: WrapAlignment.start, children: questionWidgets),
            const SizedBox(height: 16),
            Wrap(alignment: WrapAlignment.start, children: answerWidgets),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
