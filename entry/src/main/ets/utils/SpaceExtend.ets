/**
 * 水平方向边距
 * @param size
 * @returns
 */
export function horizontal(size: Length): Padding {
  return { left: size, right: size }
}

/**
 * 垂直方向边距
 * @param size
 * @returns
 */
export function vertical(size: Length): Padding {
  return { top: size, bottom: size }
}

/**
 * 水平垂直方向边距
 * @param horizontal
 * @param vertical
 * @returns
 */
export function bothway(horizontal: Length, vertical: Length): Padding {
  return { left: horizontal, right: horizontal, top: vertical, bottom: vertical }
}