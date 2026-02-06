/**
 * 创建时间：2026/2/6
 * 最近一次修改时间：2026/2/7
 *
 * 修改自 c_bitwise_1
 *
 * 比较不同的位运算的图形差异
 * 方式2：放一起比较
 *
 * 画布从左到右分别对应：按位与、按位或、按位异或
 *
 * 就是有一点慢
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int a = 1;  // 引入索引值
int whichBitwiseOperator = 3;  // 1:按位与& 2:按位或| 3:按位异或^
int colorZero = 0;  // 0 对应黑色
int colorOne = 255;  // 1 对应白色
int lastBits = 1;  // a 补码的最后 lastBits 位放进图片名
void setup() {
  size(1536, 512);  // 有 3 个区域，故 width 是 height 的 3 倍
  noStroke();
  int i = 2;
  while (i < max(width / 3, height)) {  // 2 的 lastBits 次幂不小于画布宽度与高度的较大者时
    i *= 2;                             // 能画在画布上的图形只取决于 a 的补码最后 lastBits 位
    lastBits += 1;                      // 与其余位无关，可以忽略，无论 a 正负
  }                                     // 最后 lastBits 位也不包括符号位
  println(i, lastBits);
  println(a, binary(a, lastBits));
}
void draw() {
  int result;
  int b = 0;
  for (int x = 0; x < (width / 3 - 1) / cellWidth + 1; x++) {  // 这样当 width 不能被 cellWidth 整除时，画布就不会空一部分了；能整除时，保持恰好画满不变
    for (int y = 0; y < (height - 1) / cellHeight + 1; y++) {  // 这样当 height 不能被 cellHeight 整除时，画布就不会空一部分了；能整除时，保持恰好画满不变
      b = x & y;  // 按位与
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        fill(colorOne);
      } else {
        fill(colorZero);
      }
      rect(x * cellWidth, y * cellHeight, cellWidth, cellHeight);
      b = x | y;  // 按位或
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        fill(colorOne);
      } else {
        fill(colorZero);
      }
      rect(x * cellWidth + width / 3, y * cellHeight, cellWidth, cellHeight);
      b = x ^ y;  // 按位异或
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        fill(colorOne);
      } else {
        fill(colorZero);
      }
      rect(x * cellWidth + 2 * width / 3, y * cellHeight, cellWidth, cellHeight);
    }
  }
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
      saveFrame(s);
      println(String.format("已保存：%s", s));
      break;
  }
}
