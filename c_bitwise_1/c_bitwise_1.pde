/**
 * 创建时间：2026/2/6
 * 最近一次修改时间：2026/2/10
 * 
 * 主要修改自 c_XOR_2
 * 结合 c_XOR_3_I_C 中画图案的类方法
 * 
 * 比较不同的位运算的图形差异
 * 方式1：一次只画一种位运算的图形，切换不同位运算看不同图形
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
int colorZero = 0;  // 0 对应黑色
int colorOne = 255;  // 1 对应白色
int lastBits = 1;  // a 补码的最后 lastBits 位放进图片名
boolean isSaved = false;  // 防止重复保存
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
  println(a, binary(a, lastBits));
}
void draw() {
  int result;
  int color1;
  int b = 0;
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
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        color1 = colorOne;
      } else {
        color1 = colorZero;
      }
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
    println(a, binary(a, lastBits));
    isSaved = false;
  } else if (mouseButton == RIGHT) {
    a--;
    println(a, binary(a, lastBits));
    isSaved = false;
  }
}
void keyPressed() {
  switch (key) {
    case '1':
      if (whichBitwiseOperator != 1) {
        whichBitwiseOperator = 1;
        isSaved = false;
      }
      break;
    case '2':
      if (whichBitwiseOperator != 2) {
        whichBitwiseOperator = 2;
        isSaved = false;
      }
      break;
    case '3':
      if (whichBitwiseOperator != 3) {
        whichBitwiseOperator = 3;
        isSaved = false;
      }
      break;
    case 's':
      if (!isSaved) {
        String s1 = "XOR";
        if (whichBitwiseOperator == 1) {
          s1 = "AND";
        } else if (whichBitwiseOperator == 2) {
          s1 = "OR";
        } else if (whichBitwiseOperator == 3) {
          s1 = "XOR";
        }
        String s = String.format("your_output/c_bitwise_1 %s a_%d_%s.png", s1, a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
        save(s);
        println(String.format("已保存：%s", s));
        isSaved = true;
      }
      break;
  }
}
