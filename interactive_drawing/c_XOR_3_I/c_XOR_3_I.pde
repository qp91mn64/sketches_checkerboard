/**
 * 创建时间：2026/1/27
 * 最近一次修改时间：2026/2/9
 * 在 c_XOR_2.pde 画棋盘格推广的基础上
 * 借助 checkerboard_cell_interaction_2 （编写时间：2026/1/15 - 2026/1/20）的代码框架
 * 实现点击鼠标就能用不同图案画图形
 * 以及保存、重置的功能
 */
int w = 8;  // 区域列数，调这个试一试
int h = 8;  // 区域行数，调这个试一试
int W;
int H;
int x;
int y;
int dataMax;  // 不用徒手调
int dataMin = 0;
String[] dataStrings;
String fileName;
boolean r = false;
boolean isSaved = false;  // 防止重复保存
Grid grid;
Pattern1 pattern = new Pattern1();  // 然后实例化这个子类
void setup() {
  size(512, 512);  // 调这个试一试
  W = width / w;  // 每个矩形区域宽度
  H = height / h;  // 每个矩形区域高度
  noStroke();
  int i = 1;
  while (i < max(W, H)) {
    i *= 2;
  }
  dataMax = i - 1;
  grid = new Grid(w, h, dataMax, dataMin);
  loadPixels();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
    }
  }
  updatePixels();
}
void draw() {
  if (r) {
    loadPixels();
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
      }
    }
    updatePixels();
    r = !r;
  }
}
void mousePressed() {
  x = mouseX / W;  // 矩形区域 x 坐标
  y = mouseY / H;  // 矩形区域 y 坐标
  if (x >= w || x < 0 || y >= h || y < 0) {  // 限制坐标范围
    return;                                  // 超出画图区域的部分，点不动即可
  }
  if (mouseButton == LEFT) {
    grid.updateValue(x, y, '+');
    loadPixels();
    pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
    updatePixels();
    isSaved = false;
  } else if (mouseButton == RIGHT) {
    grid.updateValue(x, y, '-');
    loadPixels();
    pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
    updatePixels();
    isSaved = false;
  }
}
void keyPressed() {
  switch (key) {
    case 'r':
      // 重置
      myReset();
      r = true;
      break;
    case 's':
      // 保存
      if (!isSaved) {
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
        isSaved = true;
      }
      break;
  }
}
void myReset() {
  int[][] data1 = new int[grid.h][grid.w];
  for (int i = 0; i < grid.h; i++) {
    for (int j = 0; j < grid.w; j++) {
      data1[i][j] = grid.data[i][j];
    }
  }
  grid.reset();
  // 防止交替按下 r、s 键重复保存
  for (int i = 0; i < grid.h; i++) {
    for (int j = 0; j < grid.w; j++) {
      if (!isSaved) {
        break;
      }
      if (data1[i][j] != grid.data[i][j]) {
        isSaved = false;
        break;
      }
    }
    if (!isSaved) {
      break;
    }
  }
}
