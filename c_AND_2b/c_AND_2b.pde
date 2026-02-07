/**
 * 2026/1/22 - 2026/2/7
 * 
 * 用按位与得到类似谢尔宾斯基三角形分形图
 * 迭代理解，方式二：从最大的空白开始，点阵从大到小
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
 * 一连串 1 结尾时，细节最丰富，故 a 迭代到等于 2 的幂减 1
 * a 从小于画布长边的最大的 2 的幂开始（每个值都有用，而且最后能画满）
 * 例如 512 x 512 画布，则 a 的值：256, 384, 448, 480, 496, 504, 508, 510, 511
 * 对应补码则从一个 1 开始，依次把低一位置 1，直到以一连串 1 结尾
 * a 每取下一个值
 * 就相当于把上一个值里面所有黑色格子
 * 右下角 1/4 变成白色
 
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
int a = 1;  // 引入索引值，取其补码中所有 1 所在位
int a1 = 1;
int lastBits = 1;  // a 补码的最后 lastBits 位放进图片名
void setup() {
  size(512, 512);
  noStroke();
  int i = 2;
  while (i < max(width, height)) {  // 2 的 lastBits 次幂不小于画布宽度与高度的较大者时
    i *= 2;                         // 能画在画布上的图形只取决于 a 的补码最后 lastBits 位
    lastBits += 1;                  // 与其余位无关，可以忽略，无论 a 正负
  }                                 // 最后 lastBits 位也不包括符号位
  a1 = 1 << (lastBits - 1);  // 在现成的 lastBits 的基础上，左移 (lastBits - 1) 位即可
  a = a1;                    // 注意这里的 a、a1 小于画布长边，从而迭代时每个值都有用
  println(i, lastBits);
  println("a", a, binary(a, lastBits));
  println(a1, binary(a1, lastBits));
}
void draw() {
  int color1;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color1 = (x & y) & a;  // 先把坐标x、y按位与再和变量 a 按位与，保留相应位的值。
      if (color1 != 0) {
        color1 = 1;  // 只要有一位是 1，就把颜色取 1，相当于对计算结果所有位取或运算
      }
      fill(255 * color1);  // 最左上角代表0，黑色。填充的颜色（灰度）值大于最大值就不画？
      rect(x, y, 1, 1);  // 格子边长大于 1 反而不能充分展示细节
    }
  }
}
void mousePressed() {
  if (mouseButton == LEFT && (a1 >> 1) > 0) {  // 防止 a1 变成 0
    a1 = (a1>>1);  // 先把 a1 按位右移一位
    a += a1;  // 再加到 a 上，相当于把 a 的低一位置 1
    println("a", a, binary(a, lastBits));
    println(a1, binary(a1, lastBits));
  } else if (mouseButton == RIGHT && (a1 << 1) > 0 && (a != a1)) { // 防止 a 变成 0
    a -= a1;  // 先把 a 的低一位清零
    a1 = (a1<<1);  // 再把 a1 按位左移一位
    println("a", a, binary(a, lastBits));
    println(a1, binary(a1, lastBits));
  }
}
void keyPressed() {
  if (key == 's') {
    String s = String.format("your_output/c_AND_2b a_%d_%s.png", a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
    saveFrame(s);
    println(String.format("已保存：%s", s));
  }
}
