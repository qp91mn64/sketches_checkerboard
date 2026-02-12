# 棋盘格

- `checkerboard_1`：矩形区域里面画棋盘格，由黑白小方格组成
- `checkerboard_2`：棋盘格的推广，小格子长宽不等，留着备用

## 用棋盘格画图

棋盘格是黑白交错方格组成的，方格尺寸决定棋盘格疏密，能否用来表示数据？

把画布分成网格，分别画不同图案。画图参数事先准备好，统一存放，既可以根据坐标算出，也可以来自外部文件。数值不同，图就不同，就能组合各种更加复杂的图形。

- `checkerboard_cell_1`：4x4 网格区域，`data[y][x] = x + y`
- `checkerboard_cell_2`：8x8 网格区域，`data[y][x] = x ^ y`
- `checkerboard_cell_with_load_data`：演示加载外部数据。
- `checkerboard_cell_with_save_data`：演示保存数据为文本文件。
