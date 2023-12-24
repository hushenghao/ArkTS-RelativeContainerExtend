export const Parent = "__container__"

declare interface AlignRules {
  leftToLeftOf?: string,
  leftToRightOf?: string,
  rightToLeftOf?: string,
  rightToRightOf?: string,
  topToTopOf?: string,
  topToBottomOf?: string,
  bottomToTopOf?: string,
  bottomToBottomOf?: string,

  // 居中属性
  centerOf?: string,
  centerHorizontalOf?: string,
  centerVerticalOf?: string,
}

/**
 * 构建相对布局规则
 * @param rules
 * @returns
 */
export function buildRules(rules: AlignRules): AlignRuleOption {
  let _left: HorizontalRule | undefined = undefined
  if (rules.leftToLeftOf != null && rules.leftToRightOf != null) {
    throw Error("leftToLeftOf 和 leftToRightOf 不能同时约束")
  } else if (rules.leftToLeftOf != null) {
    _left = toLeftOf(rules.leftToLeftOf!)
  } else {
    _left = toRightOf(rules.leftToRightOf!)
  }

  let _right: HorizontalRule | undefined = undefined
  if (rules.rightToLeftOf != null && rules.rightToRightOf != null) {
    throw Error("rightToLeftOf 和 rightToRightOf 不能同时约束")
  } else if (rules.rightToLeftOf != null) {
    _right = toLeftOf(rules.rightToLeftOf!)
  } else {
    _right = toRightOf(rules.rightToRightOf!)
  }

  let _middle: HorizontalRule | undefined = undefined
  if (
    rules.centerHorizontalOf != null ||
      (_left != null && _right != null &&
        _left.anchor == _right.anchor &&
        _left.align == HorizontalAlign.Start &&
        _right.align == HorizontalAlign.End)
  ) {
    _middle = rules.centerHorizontalOf != null ? centerHorizontalOf(rules.centerHorizontalOf!) : centerHorizontalOf(_left.anchor!)
    _left = undefined
    _right = undefined
  }

  let _top: VerticalRule | undefined = undefined
  if (rules.topToTopOf != null && rules.topToBottomOf != null) {
    throw Error("topToTopOf 和 topToBottomOf 不能同时约束")
  } else if (rules.topToTopOf != null) {
    _top = toTopOf(rules.topToTopOf!)
  } else {
    _top = toBottomOf(rules.topToBottomOf!)
  }

  let _bottom: VerticalRule | undefined = undefined
  if (rules.bottomToTopOf != null && rules.bottomToBottomOf != null) {
    throw Error("bottomToTopOf 和 bottomToBottomOf 不能同时约束")
  } else if (rules.bottomToTopOf != null) {
    _bottom = toTopOf(rules.bottomToTopOf!)
  } else {
    _bottom = toBottomOf(rules.bottomToBottomOf!)
  }

  let _center: VerticalRule | undefined = undefined
  if (
    rules.centerVerticalOf != null ||
      (_top != null && _bottom != null &&
        _top.anchor == _bottom.anchor &&
        _top.align == VerticalAlign.Top &&
        _bottom.align == VerticalAlign.Bottom)
  ) {
    _center = rules.centerVerticalOf != null ? centerVerticalOf(rules.centerVerticalOf!) : centerVerticalOf(_top.anchor!)
    _top = undefined
    _bottom = undefined
  }

  if (rules.centerOf != null) {
    _middle = centerHorizontalOf(rules.centerOf)
    _center = centerVerticalOf(rules.centerOf)
    _left = undefined
    _right = undefined
    _top = undefined
    _bottom = undefined
  }

  return {
    left: _left,
    right: _right,
    middle: _middle,
    top: _top,
    bottom: _bottom,
    center: _center,
  }
}

declare interface VerticalRule {
  anchor: string,
  align: VerticalAlign
}

declare interface HorizontalRule {
  anchor: string,
  align: HorizontalAlign
}

export function toLeftOf(id: string): HorizontalRule {
  return { anchor: id, align: HorizontalAlign.Start }
}

export function toRightOf(id: string): HorizontalRule {
  return { anchor: id, align: HorizontalAlign.End }
}

export function centerHorizontalOf(id: string): HorizontalRule {
  return { anchor: id, align: HorizontalAlign.Center }
}

export function toTopOf(id: string): VerticalRule {
  return { anchor: id, align: VerticalAlign.Top }
}

export function toBottomOf(id: string): VerticalRule {
  return { anchor: id, align: VerticalAlign.Bottom }
}

export function centerVerticalOf(id: string): VerticalRule {
  return { anchor: id, align: VerticalAlign.Center }
}