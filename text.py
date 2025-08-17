import gdstk
import numpy as np

num_circles = 1000000          # 示例总圆数，可替换成 65_000_000
radius_list = np.random.choice(np.linspace(0.5, 5.0, 100), num_circles)  # 模拟 100 种半径
positions = np.random.rand(num_circles, 2) * 1000  # 随机坐标，单位 um

lib = gdstk.Library(unit=1e-6, precision=1e-9)  # 单位 um

unique_radii = np.unique(radius_list)
circle_cells = {}
for r in unique_radii:
    cell_name = f"CIRCLE_{r:.3f}"
    cell = lib.new_cell(cell_name)
    circle = gdstk.ellipse((0, 0), r, tolerance=1e-3)
    cell.add(circle)
    circle_cells[r] = cell_name


top = lib.new_cell("TOP")

for pos, r in zip(positions, radius_list):
    cell_name = circle_cells[r]
    ref = gdstk.Reference(cell_name, origin=pos)
    top.add(ref)

lib.write_gds("compressed_circles.gds")
print("完成：GDS 文件生成完毕")
