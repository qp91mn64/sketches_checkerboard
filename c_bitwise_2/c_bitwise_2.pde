/**
 * 创建时间：2026/2/6
 * 最近一次修改时间：2026/2/8
 *
 * 修改自 c_bitwise_1
 *
 * 比较不同的位运算的图形差异
 * 方式2：放一起比较
 *
 * 画布从左到右分别对应：按位与、按位或、按位异或
 *
 * 在 PImage 的帮助下画图比原来快多了
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
PImage image1;
void setup() {
  size(1536, 512);  // 有 3 个区域，故 width 是 height 的 3 倍
  noStroke();
  xMax = (width / 3 - 1) / cellWidth + 1;  // 防止 width 不能被 cellWidth 整除时的灰边
  yMax = (height - 1) / cellHeight + 1;  // 防止 height 不能被 cellHeight 整除时的灰边
  int i = 2;
  while (i < max(xMax, yMax)) {  // 只考虑这么多格子即可
    i *= 2;                      // 能画在画布上的图形只取决于 a 的补码最后 lastBits 位
    lastBits += 1;               // 与其余位无关，可以忽略，无论 a 正负
  }                              // 最后 lastBits 位也不包括符号位
  println(i, lastBits);
  println(a, binary(a, lastBits));
  image1 = createImage(width, height, RGB);
}
void draw() {
  int result;
  int color1;
  int b = 0;
  image1.loadPixels();
  for (int x = 0; x < xMax; x++) {
    for (int y = 0; y < yMax; y++) {
      b = x & y;  // 按位与
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        color1 = colorOne;
      } else {
        color1 = colorZero;
      }
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          image1.pixels[min(y * cellHeight + dy, image1.height - 1) * image1.width + min(x * cellWidth + dx, image1.width / 3 - 1)] = color(color1);
        }
      }
      b = x | y;  // 按位或
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        color1 = colorOne;
      } else {
        color1 = colorZero;
      }
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          image1.pixels[min(y * cellHeight + dy, image1.height - 1) * image1.width + image1.width / 3 + min(x * cellWidth + dx, image1.width / 3 - 1)] = color(color1);
        }
      }
      b = x ^ y;  // 按位异或
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        color1 = colorOne;
      } else {
        color1 = colorZero;
      }
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          image1.pixels[min(y * cellHeight + dy, image1.height - 1) * image1.width + 2 * image1.width / 3 + min(x * cellWidth + dx,image1.width / 3 - 1)] = color(color1);
        }
      }
    }
  }
  image1.updatePixels();
  image(image1, 0, 0);
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
  switch (key) {
    case '1':
      whichBitwiseOperator = 1;
      break;
    case '2':
      whichBitwiseOperator = 2;
      break;
    case '3':
      whichBitwiseOperator = 3;
      break;
    case 's':
      String s = String.format("your_output/c_bitwise_2 a_%d_%s.png", a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
      image1.save(s);
      println(String.format("已保存：%s", s));
      break;
  }
}
