/**
 * 创建时间：2026/2/6
 * 最近一次修改时间：2026/2/6
 *
 * c_XOR_3_I 的黑白互补版本，C 指 Complementary
 * 大多数代码复用自之前的草图 c_XOR_3_I 和 checkerboard_cell_complementary
 * 然后稍微整理了一下
 */
int w = 8;  // 区域列数，调这个试一试
int h = 8;  // 区域行数，调这个试一试
int W;
int H;
int x;
int y;
int dataMax;
int dataMin;
String[] dataStrings;
String fileName;
boolean r = false;
boolean isSaved = false;  // 防止重复保存
Grid grid;
Pattern XORpattern = new XORPattern();  // 然后实例化这个子类
Pattern XORpattern_C = new XORPattern_C();  // 然后实例化这个子类
void setup() {
  size(512, 512);  // 调这个试一试
  W = width / w;  // 每个矩形区域宽度
  H = height / h;  // 每个矩形区域高度
  noStroke();
  // 计算没有黑白互补时，一共能画出的图案种类数
  // 结果是2的整数次幂中不小于区域长边的最小值
  int i = 1;
  while (i < max(W, H)) {
    i *= 2;
  }
  dataMax = i - 1;
  dataMin = ~dataMax;  // - dataMax - 1
  grid = new Grid(w, h, dataMax, dataMin);
  drawAll();  // 初始化画布
}
void draw() {
  if (r) {
    drawAll();  // 优化：只有重置全画
    r = !r;
  }
}
void mousePressed() {
  x = mouseX / W;  // 矩形区域 x 坐标
  y = mouseY / H;  // 矩形区域 y 坐标
  if (x >= w || x < 0 || y >= h || y < 0) {  // 限制坐标范围
    return;                                  // 若有灰边，点不动即可
  }
  if (mouseButton == LEFT) {
    grid.updateValue(x, y, '+');  // 加1
    drawPattern(x, y);
    isSaved = false;
  } else if (mouseButton == RIGHT) {
    grid.updateValue(x, y, '-');  // 减1
    drawPattern(x, y);
    isSaved = false;
  }
}
void keyPressed() {
  switch (key) {
    case 'r':
      // 重置
      grid.reset();
      r = true;
      isSaved = false;
      break;
    case 's':
      // 保存
      if (!isSaved) {
        mySave();
        isSaved = true;
      }
      break;
  }
}
void drawPattern(int x, int y) {
  /*
  a 从 0 开始增加
  与从 -1 开始减少
  画出的图案结构相似
  黑白互补
  
  a        <--> ~a
  0        <--> -1
  dataMax  <--> dataMin
  白色     <--> 黑色
  原始图案 <--> 黑白互补图案
  */
  int a = grid.data[y][x];  // 决定图案外观的参数
  if (a >= 0){
    XORpattern.display(x * W, y * H, W, H, a);
  } else {
    XORpattern_C.display(x * W, y * H, W, H, ~a);  // 按位取反 ~a 等于 -a-1
  }
}
void drawAll() {
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      drawPattern(x, y);
    }
  }
}
void mySave() {
  int w1 = w * W;  // 有效画图区域宽度
  int h1 = h * H;  // 有效画图区域高度
  PImage image1 = createImage(w1, h1, RGB);
  loadPixels();
  for (int i = 0; i < w1 * h1; i++) {
    int indexX = i % w1;
    int indexY = i / w1;
    image1.pixels[i] = pixels[indexY * width + indexX];  // 去除当 width 不能被 w 整除，或者 height 不能被 h 整除时，产生的不美观的灰边
  }
  int a1 = int(random(10000));
  String s = String.format("your_output/data_%d", a1);
  fileName = s + ".txt";
  grid.saveData(fileName);
  image1.save(s + ".png");
  println(String.format("已保存：%s", s));
}
