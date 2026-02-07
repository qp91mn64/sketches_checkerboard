/**
 * 2026/1/22 - 2026/2/8
 * 
 * 用按位与得到类似谢尔宾斯基三角形分形图
 * 迭代理解，方式1：从最细节开始构建，点阵从小到大
 * 
 * 回顾：
 * 把画布看成网格
 * 每个格子 x、y 坐标的二进制表示
 * 按位与，即计算 x & y
 * 然后取特定位的值
 * 索引值 a（补码）当中哪些位是 1
 * 就取 x & y 哪些位的值
 * 最后一步是，有 1，结果是 1，全 0，结果是 0，相当于按位或
 * 其中 a 的补码有一连串 1 时
 * 能画出类似谢尔宾斯基三角形的图形
 * 一般地，谢尔宾斯基三角形从正三角形开始
 * 而这里画出的分形相当于从点阵（等腰直角三角形）开始
 * 
 * 一连串 1 结尾时，细节最丰富，故 a 从 1 开始
 * a 的值：1，3，7，15，31，63，……
 * 对应补码分别以 1，2，3，4，5，6，……个 1 结尾
 * a 每取下一个值
 * 就相当于把上一个值里面所有 x、y 坐标都是偶数的格子
 * 里面的小一级的类似谢尔宾斯基三角形图案清空变成白色
 * 得到更大一级的类似谢尔宾斯基三角形图案
 * 
 * 使用方式
 * 直接运行
 * 点击鼠标更新索引值 a 看不同图形
 * 左键 a 多一位 1
 * 右键 a 少一位 1
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
 * c_AND_2.pde 中的 c 原本代表 checkerboard，这里扩展到其他位运算，为了一致保留 c
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int a = 1;  // 引入索引值，取其补码中所有 1 所在位
int a1 = 1;
int xMax;
int yMax;
int lastBits = 1;  // a 补码的最后 lastBits 位放进图片名
PImage image1;
void setup() {
  size(512, 512);
  noStroke();
  xMax = (width - 1) / cellWidth + 1;  // 防止 width 不能被 cellWidth 整除时的灰边
  yMax = (height - 1) / cellHeight + 1;  // 防止 height 不能被 cellHeight 整除时的灰边
  int i = 2;
  while (i < max(xMax, yMax)) {  // 只考虑这么多格子即可
    i *= 2;                      // 能画在画布上的图形只取决于 a 的补码最后 lastBits 位
    lastBits += 1;               // 与其余位无关，可以忽略，无论 a 正负
  }                              // 最后 lastBits 位也不包括符号位
  println(i, lastBits);
  println("a", a, binary(a, lastBits));
  println(a1, binary(a1, lastBits));
  image1 = createImage(width, height, RGB);
}
void draw() {
  int color1;
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      color1 = (x & y) & a;  // 先把坐标x、y按位与再和变量 a 按位与，保留相应位的值。
      if (color1 != 0) {
        color1 = 1;  // 只要有一位是 1，就把颜色取 1，相当于对计算结果所有位取或运算
      }
      // 不用矩形而是填充像素点
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          image1.pixels[min(y * cellHeight + dy, image1.height - 1) * image1.width + min(x * cellWidth + dx,image1.width - 1)] = color(color1 * 255);
        }
      }
    }
  }
  image1.updatePixels();
  image(image1, 0, 0);
}
void mousePressed() {
  if (mouseButton == LEFT && (a1 << 1) > 0 && (a1<<1) < max(xMax, yMax)) {  // 防止 a1 变成负数再按位右移的时候高位变成 1。这里为了配合 lastBits 就进一步限制 a1 范围，会影响交互细节
    a1 = (a1<<1);  // 按位左移一位
    a += a1;  // 再加到 a,相当于把 a 的高一位置 1
    println("a", a, binary(a, lastBits));
    println(a1, binary(a1, lastBits));
  } else if (mouseButton == RIGHT && (a1 >> 1) > 0) {  // 防止 a1 变成 0
    a -= a1;  // 先把 a 的高一位清 0
    a1=(a1>>1);  // 再把 a1 按位右移一位
    println("a", a, binary(a, lastBits));
    println(a1, binary(a1, lastBits));
  }
}
void keyPressed() {
  if (key == 's') {
    String s = String.format("your_output/c_AND_2a a_%d_%s.png", a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
    image1.save(s);
    println(String.format("已保存：%s", s));
  }
}
