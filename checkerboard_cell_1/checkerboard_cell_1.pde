/**
 * 2026/1/15 - 2026/1/17
 *
 * 在屏幕上画棋盘格
 * 画布被等分成16个正方形区域
 * 格子尺寸遵循模式：
 * 1 2 3 4
 * 2 3 4 5
 * 3 4 5 6
 * 4 5 6 7
 * 其中1对应棋盘格区域小格子尺寸1，2对应2，3对应4，4对应8，每加1格子大一倍
 */
int w = 4;
int h = 4;
int[][] data;
void setup() {
  size(256, 256);
  noStroke();
  data = generateData(w, h);
}
void draw() {
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      checkerboard(x * width/w, y * height/h, width/w, height/h, int(pow(2, data[x][y])));
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
  // 生成int[w][h]的二维数组
  int[][] data = new int[w][h];
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      data[x][y] = x + y;
    }
  }
  return data;
}
