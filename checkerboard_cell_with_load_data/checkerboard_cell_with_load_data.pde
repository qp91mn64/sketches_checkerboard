/**
 * 2026/1/15 - 2026/1/16
 *
 * 演示读取文本文件中的数据再画图案
 * 这样就可以用现成数据
 * 
 * 数据里面不能出现负数
 * 
 * 这里用棋盘格图案，格子边长 a 作为图案参数，
 * 计算公式：a = int(pow(2, data[y][x]))
 * 其中 data[y][x]来源于外部数据
 */
int w = 8;
int h = 8;
int[][] data;
String[] dataStrings;
String fileName = "data1.txt";
void setup() {
  size(1024, 1024);
  noStroke();
  data = loadData(fileName);
}
void draw() {
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      Checkerboard(x * width/w, y * height/h, width/w, height/h, int(pow(2, data[y][x])));
    }
  }
}
void Checkerboard(int x0, int y0, int checkerboardWidth, int checkerboardHeight, int a) {
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
int[][] loadData(String fileName) {
  String[] dataStrings = loadStrings(fileName);
  String[] dataRow = splitTokens(dataStrings[0], " ");
  int rows = dataStrings.length;
  int columns = dataRow.length;
  int[][] data = new int[rows][columns];
  for (int x = 0; x < columns; x++) {
    data[0][x] = Integer.valueOf(dataRow[x]);
  }
  for (int y = 1; y < rows; y++) {
    // 保存用的什么分隔符，读取就用什么分隔符分开。
    // 用 splitTokens() 是防止加载的文件出现连续空格时分割出空格
    dataRow = splitTokens(dataStrings[y], " ");
    if (columns == 0) {
      columns = dataRow.length;
    } else if (columns != dataRow.length) {
      println(String.format("警告：不是标准二维数据，第%d行数据有%d个，而上一行有%d个数据", y+1, dataRow.length, columns));
    }
    for (int x = 0; x < columns; x++) {
      data[y][x] = Integer.valueOf(dataRow[x]);
    }
  }
  return data;
}
