/**
 * 2026/1/22 - 2026/2/8
 * 
 * 棋盘格的本质是异或？
 * 
 * 或者说按位异或？还是奇偶？
 * 
 * 把棋盘格看作网格填格子
 * 每个格子 x、y 坐标的二进制表示
 * 按位异或
 * 然后取特定位的值
 * 有1，结果是1，全0，结果是0，相当于按位或
 * 取哪些位呢？
 * 引入一个索引值 a，取其补码所有 1 所在位
 *
 * 只取一位则画出的是棋盘格结构
 * 越高位，对应方格越大
 * 直到画不下
 *
 * 现在多取几位
 * 看起来就像
 * 把不同方格尺寸的棋盘格放在一起的结果
 * 索引值 a 的补码出现重复片段、周期的时候
 * 画出的图案就会出现嵌套、层次、分形特征
 * 只是能画的范围很有限
 * 
 * 使用方式
 * 直接运行
 * 点击鼠标更新索引值 a 看不同图形
 * 左键 a 加 1
 * 右键 a 减 1
 * 控制台查看 a 的值以及补码
 * 按 s 键保存图片
 * 
 * 按位异或计算规则是
 * 对每一位
 * 用补码运算，得到补码
 * 不同得 1 相同得 0
 * 奇数个 1 得 1 偶数个 1 得 0
 * 
 * 按位与也是补码
 * 有 1 得 1 全 0 得 0
 * 和 1 按位与不变和 0 按位与置 0
 * 故可以用按位与把一些二进制位置 0 或者取相应位的值
 * 
 * 左上角格子对应0，涂黑
 * 
 * c_XOR_2.pde 中的 c 代表 checkerboard
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int a = 1;  // 引入和索引值，取其补码中所有 1 所在位
int xMax;
int yMax;
int lastBits = 1;  // a 补码的最后 lastBits 位放进图片名
void setup() {
  size(512,512);
  noStroke();
  xMax = (width - 1) / cellWidth + 1;  // 防止 width 不能被 cellWidth 整除时的灰边
  yMax = (height - 1) / cellHeight + 1;  // 防止 height 不能被 cellHeight 整除时的灰边
  int i = 2;
  while (i < max(xMax, yMax)) {  // 只考虑这么多格子即可
    i *= 2;                      // 能画在画布上的图形只取决于 a 的补码最后 lastBits 位
    lastBits += 1;               // 与其余位无关，可以忽略，无论 a 正负
  }                              // 最后 lastBits 位也不包括符号位
  println(i, lastBits);
  println(a, binary(a, lastBits));
}
void draw() {
  int color1;
  loadPixels();
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      color1 = (x ^ y) & a;  // 先把坐标x、y按位异或再和变量 a 按位与，保留相应位的值。
      if (color1 != 0) {
        color1 = 1;  // 只要有一位是 1，就把颜色取 1，相当于对计算结果所有位取或运算
      }
      // 不用矩形而是填充像素点
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          pixels[min(y * cellHeight + dy, height - 1) * width + min(x * cellWidth + dx, width - 1)] = color(color1 * 255);
        }
      }
    }
  }
  updatePixels();
}
void mousePressed() {
  if (mouseButton == LEFT) {
    a++;
    println(a, binary(a, lastBits));
  } else if (mouseButton == RIGHT) {
    a--;
    println(a, binary(a, lastBits));
  }
}
void keyPressed() {
  if (key == 's') {
    String s = String.format("your_output/c_XOR_2 a_%d_%s.png", a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
    save(s);
    println(String.format("已保存：%s", s));
  }
}
