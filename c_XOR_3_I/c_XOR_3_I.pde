/**
 * 创建时间：2026/1/27
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
Grid grid;
Pattern1 pattern = new Pattern1();  // 然后实例化这个子类
void setup() {
  size(512, 512);  // 调这个试一试
  W = width / w;
  H = height / h;
  noStroke();
  int i = 1;
  while (i < max(width/i, height/h)) {
    i *= 2;
  }
  dataMax = i - 1;
  grid = new Grid(w, h, dataMax, dataMin);
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
    }
  }
}
void draw() {
  if (r) {
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
      }
    }
    r = !r;
  }
}
void mousePressed() {
  x = w * mouseX / width;
  y = h * mouseY / height;
  if (mouseButton == LEFT) {
    grid.updateValue(x, y, '+');
    pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
  } else if (mouseButton == RIGHT) {
    grid.updateValue(x, y, '-');
    pattern.display(x * W, y * H, W, H, grid.data[y][x]);  // 调用子类里面的 display 方法即可
  }
}
void keyPressed() {
  switch (key) {
    case 'r':
      grid.reset();
      r = true;
      break;
    case 's':
      int a1 = int(random(10000));
      fileName = String.format("output/data_%d.txt", a1);
      grid.saveData(fileName);
      saveFrame(String.format("output/data_%d.png", a1));
      println("已保存");
      break;
  }
}
