import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_animaition/gen/fonts.gen.dart';
import 'package:hooks_animaition/next_page.dart';

class FirstPage extends HookWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    // bool型の値を保持する変数を宣言
    final firstBool = useState<bool>(true);
    // 3秒後にfirstBoolの値を反転させる関数
    Future<void> loadAnimation() async {
      await Future.delayed(Duration.zero, () {
        firstBool.value = !firstBool.value;
      });
      firstBool.value = false;
    }

    // 画面が表示された時にloadAnimationを実行する
    useEffect(() {
      loadAnimation();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'First Page!',
          style: TextStyle(
            fontFamily: FontFamily.rubikDoodleShadow,
            fontSize: 25,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Center(
        child: AnimatedCrossFade(
          duration: const Duration(seconds: 3), // 3秒かけてアニメーションする
          // firstChildは最初に表示されるWidget
          firstChild: const Text(
            'Welcome!',
            style: TextStyle(
              fontFamily: FontFamily.rubikDoodleShadow,
              fontSize: 25,
              color: Colors.deepPurple,
            ),
          ),
          // secondChildはfirstChildが消えた後に表示されるWidget
          secondChild: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const NextPage();
                  },
                ),
              );
            },
            // ignore: sort_child_properties_last
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.purple, Colors.blue],
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child:
                    const Text('次のページへ', style: TextStyle(color: Colors.white)),
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
          ),
          crossFadeState: firstBool.value
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
        ),
      ),
    );
  }
}
