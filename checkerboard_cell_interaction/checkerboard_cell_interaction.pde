/**
 * 2026/1/15 - 2026/1/17
 *
 * 棋盘格可视化数值演示
 * 点击鼠标左键、右键试一试
 * 看一看能不能用棋盘格画出什么东西
 *
 * 看起来灰蒙蒙的一片实际上是细密的棋盘格
 * 而且分了不同区域
 * 每个区域对应一个数值，这个数值决定了棋盘格的格子边长 a
 *
 * 按下 s 键保存数据和当前画布
 * 按下 r 键重置
 *
 * 注意不能撤回操作，而且可能会看起来有点眼花缭乱
 * 
 * a 的计算公式：a = int(pow(2, data[y][x]))
 */
int w = 8;
int h = 8;
int W;
int H;
int x;
int y;
int dataMax = 7;
int dataMin = 0;
int[][] data = new int[h][w];
String[] dataStrings;
String fileName;
void setup() {
  size(1024, 1024);
  W = width / w;
  H = height / h;
  noStroke();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
    }
  }
}
void draw() {
}
void mousePressed() {
  x = w * mouseX / width;
  y = h * mouseY / height;
  if (mouseButton == LEFT && data[y][x] < dataMax) {
    data[y][x]++;
    checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
  } else if (mouseButton == RIGHT && data[y][x] > dataMin) {
    data[y][x]--;
    checkerboard(x * W, y * H, W, H, int(pow(2, data[y][x])));
  }
}
void keyPressed() {
  switch (key) {
    case 'r':
      data = new int[h][w];
      break;
    case 's':
      int a = int(random(10000));
      fileName = String.format("data_%d.txt", a);
      saveData(fileName, data);
      saveFrame(String.format("data_%d.png", a));
      println("已保存");
      break;
  }
}
void checkerboard(int x0, int y0, int checkerboardWidth, int checkerboardHeight, int a) {
  // 矩形区域里面画棋盘格。
  // 画满整个区域，最右边和最下边可能有不完整的格子。
  // 参数：
  // int x0: 起始横坐标
  // int y0: 起始纵坐标
  // int checkerboardWidth: 棋盘格区域宽度
  // int checkerboardHeight: 棋盘格区域高度
  // int a: 棋盘格内每个小格子边长
  // 返回值: 无
  int W = checkerboardWidth / a + 1;
  int H = checkerboardHeight / a + 1;
  int dx;
  int dy;
  for (int i = 0; i < W * H; i++) {
    dx = i % W;
    dy = i / W;
    if ((dx+dy)%2==0) {fill(255);} else {fill(0);}
    if (dx != W - 1) {
      if (dy != H - 1) {
        rect(x0 + dx * a, y0 + dy * a, a, a);
      } else {
        rect(x0 + dx * a, y0 + dy * a, a, min(a, checkerboardHeight % a));
      }
    } else {
      if (dy != H - 1) {
        rect(x0 + dx * a, y0 + dy * a, min(a, checkerboardWidth % a), a);
      } else {
        rect(x0 + dx * a, y0 + dy * a, min(a, checkerboardWidth % a), min(a, checkerboardHeight % a));
      }
    }
  }
}
void saveData(String fileName, int[][] data) {
  String[] dataStrings = new String[data.length];
  String s;
  for (int y = 0; y < data.length; y++) {
    s = String.valueOf(data[y][0]);
    for (int x = 1; x < data[0].length; x++) {
      s += String.format(" %d", data[y][x]);
    }
    dataStrings[y] = s;
  }
  saveStrings(fileName, dataStrings);
}
