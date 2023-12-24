import { buildRules, Parent } from '../utils/RelativeContainerExtend';

@Extend(Text)
function styling() {
  .fontSize(20)
  .fontWeight(FontWeight.Bold)
  .fontColor(Color.Black)
}

@Entry
@Component
struct Index {
  build() {
    Navigation() {
      RelativeContainer() {
        Text('Hello World')
          .margin(12)
          .styling()
          .id("text")
          .alignRules(buildRules({
            centerOf: Parent
          }))
          .backgroundColor(Color.Red)
        Text("Left")
          .id("left")
          .styling()
          .alignRules(buildRules({
            rightToLeftOf: "text",
            centerVerticalOf: "text"
          }))
          .backgroundColor(Color.Brown)
        Text("Right")
          .styling()
          .id("right")
          .alignRules(buildRules({
            leftToRightOf: "text",
            centerVerticalOf: "text"
          }))
          .backgroundColor(Color.Green)
        Text("Top")
          .styling()
          .id("top")
          .alignRules(buildRules({
            bottomToTopOf: "text",
            centerHorizontalOf: "text"
          }))
          .backgroundColor(Color.Yellow)
        Text("Bottom")
          .styling()
          .id("bottom")
          .alignRules(buildRules({
            topToBottomOf: "text",
            centerHorizontalOf: "text"
          }))
          .backgroundColor(Color.Orange)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .title("Hello HarmonyOS")
    .titleMode(NavigationTitleMode.Mini)
  }
}