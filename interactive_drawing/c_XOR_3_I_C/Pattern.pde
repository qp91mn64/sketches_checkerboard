/**
 * 图案抽象类
 * 受到 DeepSeek 启发
 * 定义抽象类用 abstract class
 * 里面定义抽象方法用 abstract void，注意没有 { }
 * 使用方式是用 extends 继承得到子类
 * 在子类里按照普通方法重写所有的抽象方法
 * 然后在需要时把子类实例化
 * 注意抽象类不能直接实例化
 */
abstract class Pattern {
  abstract void display(int x0, int y0, int w, int h, int a);
}
