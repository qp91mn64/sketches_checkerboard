/**
 * 创建时间：2026/2/6
 * 最近一次修改时间：2026/2/10
 *
 * 修改自 c_bitwise_1
 *
 * 比较不同的位运算的图形差异
 * 方式2：放一起比较
 *
 * 画布从左到右分别对应：按位与、按位或、按位异或
 */
int cellWidth = 1;  // 格子宽度
int cellHeight = 1;  // 格子高度
int a = 1;  // 引入索引值
int xMax;
int yMax;
int areaWidth;  // 每种位运算的区域宽度
int areaHeight;  // 每种位运算的区域高度
int whichBitwiseOperator = 3;  // 1:按位与& 2:按位或| 3:按位异或^
int colorZero = 0;  // 0 对应黑色
int colorOne = 255;  // 1 对应白色
int lastBits = 1;  // a 补码的最后 lastBits 位放进图片名
boolean isSaved = false;  // 防止重复保存
void setup() {
  size(1536, 512);  // width 最好是 height 的 3 倍；如果电脑屏幕分辨率不够就调整一下
  noStroke();
  areaWidth = width / 3;  // 整除
  areaHeight = height;
  xMax = (areaWidth - 1) / cellWidth + 1;  // 防止 areaWidth 不能被 cellWidth 整除时的灰边
  yMax = (areaHeight - 1) / cellHeight + 1;  // 防止areaHeight 不能被 cellHeight 整除时的灰边
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
      b = x & y;  // 按位与
      result = a & b;  // 对 a 按位与即可取特定位的值
      if (result != 0) {  // 判 0 即可
        color1 = colorOne;
      } else {
        color1 = colorZero;
      }
      for (int dx = 0; dx < cellWidth; dx++) {
        for (int dy = 0; dy < cellHeight; dy++) {
          pixels[min(y * cellHeight + dy, height - 1) * width + min(x * cellWidth + dx, areaWidth - 1)] = color(color1);
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
          pixels[min(y * cellHeight + dy, height - 1) * width + areaWidth + min(x * cellWidth + dx, areaWidth - 1)] = color(color1);
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
          pixels[min(y * cellHeight + dy, height - 1) * width + 2 * areaWidth + min(x * cellWidth + dx, areaWidth - 1)] = color(color1);
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
      whichBitwiseOperator = 1;
      break;
    case '2':
      whichBitwiseOperator = 2;
      break;
    case '3':
      whichBitwiseOperator = 3;
      break;
    case 's':
      if (!isSaved) {
        int w1 = 3 * areaWidth;
        PImage image1 = createImage(w1, areaHeight, RGB);  // 这样保存的图片就没有由于 width 不能被 3 整除产生的灰边了
        loadPixels();
        for (int i = 0; i < w1 * areaHeight; i++) {
          int indexX = i % w1;
          int indexY = i / w1;
          image1.pixels[i] = pixels[indexY * width + indexX];
        }
        String s = String.format("your_output/c_bitwise_2 a_%d_%s.png", a, binary(a, lastBits));  // 最后几位放进图片名即可，这样便于对照
        image1.save(s);
        println(String.format("已保存：%s", s));
        isSaved = true;
      }
      break;
  }
}
