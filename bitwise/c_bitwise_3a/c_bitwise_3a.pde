/**
 * 创建时间：2026/2/12
 * 最近一次修改时间：2026/2/13
 * 
 * 修改自 c_bitwise_3
 * 
 * 位运算结果用作颜色
 * 只画灰度，大于 255 的颜色值不画
 * 保留画不出来的区域
 * a++，从而看动态变化
 * 移动鼠标，图案跟着鼠标光标走
 * 0 透明度的不影响画布显示，到了保存的图片里面却盖住原来的颜色，如果用 PGraphics 就会得到透明背景，只有不画
 * 这样就会留下灰度痕迹，同时也让完全复现变得几乎不可能
 * 图片名称加入由毫秒级时间戳和累计帧数结合的stamp作为标记
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
      if (color1 >> 8 != 0) {  // 只画灰度
        continue;
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
        String s = String.format("your_output/c_bitwise_3a_%s_a_%d_s%s.png", bitwiseString, a, stamp());  // 加上stamp。此外a不知道要用最后几位就不加二进制表示了
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
