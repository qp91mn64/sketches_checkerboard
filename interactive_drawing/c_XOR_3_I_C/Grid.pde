class Grid {
  /*
  一个网格，每个格子对应一个数值
  表示一个二维整数列表形式数据
  用来画图的时候按照其位置代入参数
  
  里面的类方法：
  void loadData(String fileName): 加载外部数据
  void saveData(String fileName): 保存数据为文本文件
  void updateValue(int x, int y, char c): 更新指定位置数据
  void reset(): 重置数据
  
  这里暂时没有生成数据的方法
  */
  int w;  // 网格列数
  int h;  // 网格行数
  int dataMax;  // 最大数值
  int dataMin;  // 最小数值
  int[][] data;  // 网格数据
  Grid(int w_temp, int h_temp, int dataMax_temp, int dataMin_temp) {
    w = w_temp;
    h = h_temp;
    dataMax = dataMax_temp;
    dataMin = dataMin_temp;
    data = new int[h][w];  // 网格数据初始化
  }
  void loadData(String fileName) {
    // 加载外部文本文件中的二维数据
    // 格式要求是：所有的数字是整数，数据之间空格隔开
    // 空格数量不限，行首行末空格不影响
    // 行列数不限
    // 只加载前 h 行前 w 列, 多出的舍去，不足的视为 0，空行视为全 0
    // 大于 dataMax 的视为 dataMax
    // 小于 dataMin 的视为 dataMin
    String[] dataStrings = loadStrings(fileName);
    String[] dataRow;
    int value;
    int[][] data_temp = new int[h][w];
    for (int y = 0; y < min(dataStrings.length, h); y++) {
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
        data_temp[y][x] = max(min(value, dataMax), dataMin);  // 截断超出范围的数据
      }
    }
    if (dataStrings.length > h) {
      println(String.format("警告：多出 %d 行，舍去", dataStrings.length - h));
    } else if (dataStrings.length < h){
      println(String.format("警告：缺少 %d 行，视为全 0", h - dataStrings.length));
    }
    data = data_temp;
  }
  void saveData(String fileName) {
    // 把数据保存为文本文件
    // 格式是：行列数不限，每行的数据个数相同，用一个空格隔开
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
  void updateValue(int x, int y, char c) {
    // 更新指定位置数值
    if (c == '+') {
      if (data[y][x] < dataMax) {
        data[y][x]++;
      }
    } else if (c == '-') {
      if (data[y][x] > dataMin) {
        data[y][x]--;
      }
    }
  }
  void reset() {
    // 重置网格数值。可能有点慢
    data = new int[h][w];
  }
}
