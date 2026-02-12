/**
 * 2026/1/15 - 2026/2/9
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
int[][] loadData(String fileName) {
  String[] dataStrings = loadStrings(fileName);
  String[] dataRow;
  int value;
  int[][] data;
  int[][] data_temp = new int[h][w];
  for (int y = 0; y < min(dataStrings.length, h); y++) {
    // 保存用的什么分隔符，读取就用什么分隔符分开。
    // 用 splitTokens() 是防止加载的文件出现连续空格时分割出空格
    dataRow = splitTokens(dataStrings[y], " ");
    if (dataRow.length == 0) {
      println(String.format("警告：第 %d 行是空行，视为全 0", y+1, dataRow.length - w));
    } else if (dataRow.length > w) {
      println(String.format("警告：第 %d 行多出 %d 个数据，舍去", y+1, dataRow.length - w));
    } else if (dataRow.length < w) {
      println(String.format("警告：第 %d 行缺少 %d 个数据，视为 0", y+1, w - dataRow.length));
    }
    for (int x = 0; x < min(dataRow.length, w); x++) {
      value = Integer.valueOf(dataRow[x]);
      data_temp[y][x] = max(value, 0);  // 负数视为 0
    }
  }
  if (dataStrings.length > h) {
    println(String.format("警告：多出 %d 行，舍去", dataStrings.length - h));
  } else if (dataStrings.length < h){
    println(String.format("警告：缺少 %d 行，视为全 0", h - dataStrings.length));
  }
  data = data_temp;
  return data;
}
