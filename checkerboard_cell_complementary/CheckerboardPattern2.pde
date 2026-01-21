/**
 * 用于拆分视觉效果
 * 
 * 借助抽象类
 * 每当你想多画一种图案
 * 只需要用类似的方法：
 * 1.从原来的抽象类 Pattern 继承出一个新类
 * 2.重写父类的 display 方法
 * 3.主文件，或者任何画图的地方，把这个类实例化
 * 4.往其中的 display 方法代入合适的参数值即可
 */
class CheckerboardPattern2 extends Pattern {
  @Override  // 按照 DeepSeek 的说法，这个是用于重写父类里面的方法的注解，不写不报错，写了如果出现拼写错误就会保错。
             // 不过这里重写方法在定义的时候使用了 abstract 关键字，就是抽象方法，必须在子类里面重写，否则一定报错，实际上可以省略这一行
  void display(int x0, int y0, int areaWidth, int areaHeight, int a) {
    /*
    子类，重写父类里面的抽象方法 abstract void display(int x0, int y0, int w, int h, int a)
    变量的具体名称可以不同
    参数个数和每个参数类型要与父类里面对应的抽象方法保持一致
    而且参数类型考虑先后顺序
    
    重写之后，子类里面可以新增不同的方法
    
    作为演示，这里重写之后的方法是之前的代码里面画棋盘格的函数：
    
    矩形区域里面画棋盘格。
    画满整个区域，最右边和最下边可能有不完整的格子。
    参数：
    int x0: 起始横坐标
    int y0: 起始纵坐标
    int checkerboardWidth: 棋盘格区域宽度
    int checkerboardHeight: 棋盘格区域高度
    int a: 棋盘格内每个小格子边长
    返回值: 无
    */
    //noStroke();
    //fill(127);
    //rect(x0, y0, areaWidth, areaHeight);
    int W = areaWidth / a + 1;
    int H = areaHeight / a + 1;
    int dx;
    int dy;
    for (int i = 0; i < W * H; i++) {
      dx = i % W;
      dy = i / W;
      if ((dx+dy)%2==0) {fill(0);} else {fill(255);}
      if (dx != W - 1) {
        if (dy != H - 1) {
          rect(x0 + dx * a, y0 + dy * a, a, a);
        } else {
          rect(x0 + dx * a, y0 + dy * a, a, min(a, areaHeight % a));
        }
      } else {
        if (dy != H - 1) {
          rect(x0 + dx * a, y0 + dy * a, min(a, areaWidth % a), a);
        } else {
          rect(x0 + dx * a, y0 + dy * a, min(a, areaWidth % a), min(a, areaHeight % a));
        }
      }
    }
  }
}
