/**
 * 2026/1/15 - 2026/1/17
 *
 * 把画布分成若干方形区域，每个区域画不同的图案
 * 预先计算好二维数据
 * 画图案时，则按照区域位置读取数据，作为图案参数
 * 
 * 这里用棋盘格图案，格子边长 a 作为图案参数，
 * 计算公式：a = int(pow(2, data[y][x]))
 * 其中 data[y][x] = x ^ y
 */
int w = 8;
int h = 8;
int[][] data;
void setup() {
  size(1024, 1024);
  noStroke();
  data = generateData(w, h);
}
void draw() {
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      checkerboard(x * width/w, y * height/h, width/w, height/h, int(pow(2, data[y][x])));
    }
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
int[][] generateData(int w, int h) {
  // 生成int[h][w]的二维数组
  int[][] data = new int[h][w];
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      data[y][x] = x ^ y;
    }
  }
  return data;
}
