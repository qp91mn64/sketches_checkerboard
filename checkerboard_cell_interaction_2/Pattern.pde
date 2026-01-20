/**
 * 2026/1/20
 *
 * 受DeepSeek启发，使用抽象类
 *
 * 与普通的类不同的是
 * 定义抽象类，在 class 关键字前面，再加上 abstract 关键字
 * 抽象类里面可以定义抽象方法
 * 定义抽象方法与定义一般方法不同的是
 * 1.开头位置加上 abstract 关键字
 * 2.没有 { } 及其里面的部分，否则报错
 * 而抽象方法不能在普通类里面定义否则报错
 *
 * 抽象类不可实例化
 * 即：Pattern pattern = new Pattern();会报错
 */
abstract class Pattern {
  abstract void display(int x0, int y0, int w, int h, int a);
}
