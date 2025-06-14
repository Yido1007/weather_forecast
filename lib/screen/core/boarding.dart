import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  final List<_OnboardInfo> _pages = [
    _OnboardInfo(
      title: 'Güncel Hava Durumu',
      description: 'Şehrinizin anlık ve haftalık hava durumunu görün.',
      imageAsset: 'assets/img/Raining-pana.png',
    ),
    _OnboardInfo(
      title: 'Favori Şehirler',
      description: 'Sık baktığınız şehirleri favorilerinize ekleyin.',
      imageAsset: 'assets/img/Weather-cuate.png',
    ),
    _OnboardInfo(
      title: 'Kolay ve Hızlı',
      description: 'Modern tasarım ve sade kullanım deneyimi.',
      imageAsset: 'assets/img/Weather-rafiki.png',
    ),
  ];

  void _nextPage() {
    if (_pageIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _pageIndex = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 220,
                          child:
                              page.imageAsset.endsWith('.json')
                                  ? Lottie.asset(page.imageAsset)
                                  : Image.asset(page.imageAsset),
                        ),
                        const Gap(36),
                        Text(
                          page.title,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(16),
                        Text(
                          page.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                final isActive = index == _pageIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isActive ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isActive
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(180, 48),
                ),
                onPressed: _nextPage,
                child: Text(
                  _pageIndex == _pages.length - 1 ? 'Başla' : 'İleri',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardInfo {
  final String title;
  final String description;
  final String imageAsset;
  _OnboardInfo({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}
