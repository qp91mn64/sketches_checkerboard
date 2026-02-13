/**
 * 创建时间：2026/2/13
 * 最近一次修改时间：2026/2/13
 * 
 * 修改自 c_bitwise_3a
 * 
 * 位运算结果用作颜色
 * 要么灰度要么完全不透明
 * a++，从而看动态变化
 * 能画出蓝色
 * 每次刷新之后的颜色都与上一次有所不同
 * 如果你有足够的耐心，能看到其他颜色
 * 
 * 鼠标左键：a 加 1
 * 鼠标右键：a 减 1
 * s 键：保存图片
 * 
 * 一次只画一种位运算的图形，切换不同位运算看不同图形
 * 
 * 数字 1 键：按位与
 * 数字 2 键：按位或
 * 数字 3 键：按位异或
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int a = 1;  // 引入索引值。换一个值试一试能得到什么颜色的图案？
int xMax;
int yMax;
int whichBitwiseOperator = 3;  // 1:按位与& 2:按位或| 3:按位异或^
String bitwiseString;
void setup() {
  size(512, 512);
  noStroke();
  xMax = (width - 1) / cellWidth + 1;  // 防止 width 不能被 cellWidth 整除时的灰边
  yMax = (height - 1) / cellHeight + 1;  // 防止 height 不能被 cellHeight 整除时的灰边
  if (whichBitwiseOperator == 1) {
    bitwiseString = "AND";
  } else if (whichBitwiseOperator == 2) {
    bitwiseString = "OR";
  } else if (whichBitwiseOperator == 3) {
    bitwiseString = "XOR";
  }
  println(bitwiseString, a, binary(a));
  frameRate(64);
}
void draw() {
  a++;
  int b = 0;
  int color1 = 0;
  loadPixels();
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      int x1 = x - mouseX;
      int y1 = y - mouseY;
      if (whichBitwiseOperator == 1) {
        b = x1 & y1;
      } else if (whichBitwiseOperator == 2) {
        b = x1 | y1;
      } else if (whichBitwiseOperator == 3) {
        b = x1 ^ y1;
      }
      color1 = a & b;  // 对 a 按位与即可取特定位的值
      if (color1 >> 8 != 0) {  // 如果不是灰度，就让颜色完全不透明
        color1 |= 0xFF000000;  // 把最高 8 位置 1 颜色就完全不透明了
      }
      // 不用矩形而是填充像素点
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          pixels[min(y * cellHeight + dy, height - 1) * width + min(x * cellWidth + dx, width - 1)] = color(color1,255);
        }
      }
    }
  }
  updatePixels();
}
void mousePressed() {
  if (mouseButton == LEFT) {
    a++;
    println(bitwiseString, a, binary(a));
  } else if (mouseButton == RIGHT) {
    a--;
    println(bitwiseString, a, binary(a));
  }
}
void keyPressed() {
  switch (key) {
    case '1':
      if (whichBitwiseOperator != 1) {
        whichBitwiseOperator = 1;
        bitwiseString = "AND";
        println(bitwiseString, a, binary(a));
      }
      break;
    case '2':
      if (whichBitwiseOperator != 2) {
        whichBitwiseOperator = 2;
        bitwiseString = "OR";
        println(bitwiseString, a, binary(a));
      }
      break;
    case '3':
      if (whichBitwiseOperator != 3) {
        whichBitwiseOperator = 3;
        bitwiseString = "XOR";
        println(bitwiseString, a, binary(a));
      }
      break;
    case 's':
        String s = String.format("your_output/c_bitwise_3b_%s_a_%d_s%s.png", bitwiseString, a, stamp());  // 加上stamp。此外a不知道要用最后几位就不加二进制表示了
        saveFrame(s);
        println(String.format("已保存：%s", s));
      break;
  }
}
String stamp() {
  String stamp1 = year() + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);  // 精确到秒的时间戳
  stamp1 += String.format("_%d_%d", millis(), frameCount);  // 毫秒，以及累计帧数
  return stamp1;
}
