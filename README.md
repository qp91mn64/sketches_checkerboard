# sketches_checkerboard 不只是棋盘格

![示例图片3](c_XOR_3_I/examples/data_9134.png)  
[c_XOR_3_I/examples/data_9134.png](c_XOR_3_I/examples/data_9134.png)

![示例图片2](checkerboard_cell_complementary/examples/data_4726.png)  
[checkerboard_cell_complementary/examples/data_4726.png](checkerboard_cell_complementary/examples/data_4726.png)

![示例图片](checkerboard_cell_interaction/examples/data_7179.png)  
[checkerboard_cell_interaction/examples/data_7179.png](checkerboard_cell_interaction/examples/data_7179.png)

从画棋盘格开始探索，已有多种不同图案可用于画图，也发现了不同的分形。

使用 `Processing 4.3.2` 写的代码。

## 目前草图

运行方式：先 Git 克隆仓库，或者下载 zip 压缩包，自行解压缩。如无特别说明，对每一份草图，用 Processing 4 直接打开运行即可，不需要安装任何第三方库。

### 命名方式

- `checkerboard_` 开头的：画棋盘格
- `checkerboard_cell_` 开头的：棋盘格图案画图
- `c_` 开头的：为了简便才这么写，最开始指 `checkerboard`，后面随着探索进行画出的就不只是棋盘格了，为了一致就沿用了。

实际上，两种命名方式的草图，代码逻辑和画出的图案也确实有区别。

- `AND`、`OR`、`XOR`：与，或，异或，也可理解为按位与、按位或、按位异或省略 `bitwise`。
- `I`：Interaction，这里专门指与 `checkerboard_cell_interaction_2` 类似的代码结构和交互方式。

### 画棋盘格

- `checkerboard_1`：矩形区域里面画棋盘格，由黑白小方格组成
- `checkerboard_2`：棋盘格的推广，小格子长宽不等，留着备用

### 用棋盘格画图

- `checkerboard_cell_1`：4x4 网格区域，`data[y][x] = x + y`
- `checkerboard_cell_2`：8x8 网格区域，`data[y][x] = x ^ y`
- `checkerboard_cell_with_load_data`：演示加载外部数据。
- `checkerboard_cell_with_save_data`：演示保存数据为文本文件。

### 交互

- `checkerboard_cell_interaction`：尺寸倍增棋盘格图案
- `checkerboard_cell_interaction_2`：尺寸倍增棋盘格图案
- `checkerboard_cell_complementary`：尺寸倍增棋盘格图案 + 黑白互补棋盘格图案
- `c_XOR_3_I`：更多种类图案，不只有棋盘格

使用方式：点一下鼠标左键/右键，改变区域里面的棋盘格外观，看用不同图案能拼接出什么。按 `s` 键保存数据、图形，`r` 键重置画布。

如果你把画布调得太大，尽管优化了一下，重置画布的时候还是要等一下；而且部分区域可能就点不到了，从而得到的图片比较空不好看；此外画到后面可能有点眼花缭乱。

注意**没有撤回功能**。

### 位运算

**注意从这里开始，画出的棋盘格左上角通常是黑色的，不像前面的代码，画出的棋盘格左上角通常是白色的。**

- `c_XOR`：棋盘格的本质是异或？按位异或画棋盘格。

#### 引入索引值 `a` 多取几位，扩展图案类型

- `c_XOR_2`：按位异或
- `c_AND_2`：按位与
- `c_OR_2`：按位或

使用方式：点鼠标改变 `a` 值看不同图形，其中左键加 1 右键减 1。可以对照控制台输出值与画出的图形。按 `s` 键保存图片。

#### 预料之外的分形：类似谢尔宾斯基三角形

- `c_AND_2a`：从最细节开始构建，点阵从小到大  
- `c_AND_2b`：从最大的空白开始，点阵从大到小  

使用方式：点几下鼠标，对照控制台输出值与画出的图形，看一看这种图形怎么得到的。按 `s` 键保存图片。

### 拆分与复用代码

- `checkerboard_cell_interaction_2`：拆分出类，受到 DeepSeek 启发使用抽象类，**便于复用**。同时加上了 `checkerboard_cell_with_load_data` 演示的加载外部数据的功能以备用。
- `checkerboard_cell_complementary`：扩展到负数
- `c_XOR_3_I`：复用 `checkerboard_cell_interaction_2` 的代码结构

## 灵感来源

主要是 2026 年 1 月份自己用画图软件画的 [black_white_1.png](why_start_the_repo/black_white_1.png)

把小方格尺寸倍增的棋盘格图案拼在一起，边界十分整齐，有独特的美感。

以及从之前自己写的代码受到的启发。

[详细的灵感来源](why_start_the_repo/inspiration.md)

## 关于Processing

Processing 是一种开源的编程语言，也是一个开发环境，与多种常见的编程语言的区别是，输入代码就能直接画出各种想要的图形。默认 Java 模式。详见官网：[https://processing.org](https://processing.org)

根据其项目地址 [https://github.com/processing/processing4](https://github.com/processing/processing4)，Processing 4 的许可证信息：

- 核心库遵循 [LGPLv2.1](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) 许可证
- Processing 开发环境遵循 [GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) 许可证

如果只是用 Processing 作为工具创作的代码，一般可以自由选择许可证

## 运行环境

建议使用 `Processing 4.3.2` 或更高版本。没有在其他版本上测试，不保证能在每个版本上正常运行。

Processing 最新版本下载地址：[https://processing.org/download](https://processing.org/download)

下载特定版本：[https://github.com/processing/processing4/releases](https://github.com/processing/processing4/releases)

## 许可证

如无特别说明，许可方式如下：

- 代码：MIT 许可证。详见 [LICENSE](LICENSE)。
- 文档，示例数据和图片：[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)。
