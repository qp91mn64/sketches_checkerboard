/**
 * 创建时间：2026/2/10
 * 最近一次修改时间：2026/2/11
 * 
 * 修改自 c_bitwise_1
 * 
 * 位运算结果直接填充颜色，于是得到各种不同灰度
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
int a = 1;  // 引入索引值
int xMax;
int yMax;
int whichBitwiseOperator = 3;  // 1:按位与& 2:按位或| 3:按位异或^
int lastBits = 8;  // 只画 256 种颜色，故只需要最后 8 位
boolean isSaved = false;  // 防止重复保存
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
  println(bitwiseString, a, binary(a, lastBits));
}
void draw() {
  int b = 0;
  int color1 = 0;
  loadPixels();
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      if (whichBitwiseOperator == 1) {
        b = x & y;
      } else if (whichBitwiseOperator == 2) {
        b = x | y;
      } else if (whichBitwiseOperator == 3) {
        b = x ^ y;
      }
      color1 = a & b;  // 对 a 按位与即可取特定位的值
      color1 = color1 % 256;  // 防止大于 255 的画不出来
      // 不用矩形而是填充像素点
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          pixels[min(y * cellHeight + dy, height - 1) * width + min(x * cellWidth + dx, width - 1)] = color(color1);
        }
      }
    }
  }
  updatePixels();
}
void mousePressed() {
  if (mouseButton == LEFT) {
    a++;
    println(bitwiseString, a, binary(a, lastBits));
    isSaved = false;
  } else if (mouseButton == RIGHT) {
    a--;
    println(bitwiseString, a, binary(a, lastBits));
    isSaved = false;
  }
}
void keyPressed() {
  switch (key) {
    case '1':
      if (whichBitwiseOperator != 1) {
        whichBitwiseOperator = 1;
        bitwiseString = "AND";
        println(bitwiseString, a, binary(a, lastBits));
        isSaved = false;
      }
      break;
    case '2':
      if (whichBitwiseOperator != 2) {
        whichBitwiseOperator = 2;
        bitwiseString = "OR";
        println(bitwiseString, a, binary(a, lastBits));
        isSaved = false;
      }
      break;
    case '3':
      if (whichBitwiseOperator != 3) {
        whichBitwiseOperator = 3;
        bitwiseString = "XOR";
        println(bitwiseString, a, binary(a, lastBits));
        isSaved = false;
      }
      break;
    case 's':
      if (!isSaved) {
        String s = String.format("your_output/c_bitwise_3 %s a_%d_%s.png", bitwiseString, a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
        save(s);
        println(String.format("已保存：%s", s));
        isSaved = true;
      }
      break;
  }
}
