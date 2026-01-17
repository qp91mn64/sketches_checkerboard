/**
 * 2026/1/15 - 2026/1/17
 *
 * 演示数据保存为文本文件
 * 
 * 把画布分成若干方形区域，每个区域画不同的图案
 * 预先计算好二维数据
 * 画图案时，则按照区域位置读取数据，作为图案参数
 * 
 * 这里用棋盘格图案，格子边长 a 作为图案参数，
 * 计算公式：a = int(pow(2, data[y][x]))
 * 其中 data[y][x] = x ^ y
 * 
 * 新建二维数组 data[h][w] 的时候，采用第一个[]填高度/行数，第二个[]填宽度/列数的方式
 * 这样在把里面的数据保存为文本文件的时候
 * 第 y 行依次放置 data[y] 里面所有数据
 * 就能保持原来的排列顺序不变
 */
int w = 8;
int h = 8;
int[][] data;
String[] dataStrings;
String fileName = "data1.txt";
void setup() {
  size(1024, 1024);
  noStroke();
  data = generateData(w, h);
  println(data.length);  // 与新建数组的时候第一个[]里面填入的数字大小相同
  saveData(fileName, data);
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
  // 这里保证存入与读出数据的方式相同即可
  int[][] data = new int[h][w];
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      data[y][x] = x ^ y;
    }
  }
  return data;
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
