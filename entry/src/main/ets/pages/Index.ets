interface PlanItem {
  id: number
  plan: string
  isFinished: boolean
  createTime?: number
}

@Entry
@Component
struct Index {
  // ========== 属性/状态 ==========
  @State showAddDialog: boolean = false  // 是否显示文本框
  @State newPlanText: string = ''        // 输入的文本

  @State planList: PlanItem[] = [
    { id: 1, plan: '早起跑步', isFinished: false },
    { id: 2, plan: '吃早餐', isFinished: true },
    { id: 3, plan: '清理智', isFinished: false },
    { id: 4, plan: '学习ArkTS', isFinished: false },
    { id: 5, plan: '完成信号与系统作业', isFinished: false }
  ]

  // ========== 计算属性 ==========
  // get finishedCount(): number {
  //   const count=this.planList.filter(item => item.isFinished).length
  //   return Number(count)
  // }
  //
  // get unfinishedCount(): number {
  //   return this.planList.filter(item => !item.isFinished).length
  // }

  // ========== Builder函数 ==========
  @Builder tuBiao(icon: Resource) {
    Image(icon)
      .width(28)
      .height(28)
  }

  @Builder addTaskDialog() {
    Column() {
      Text('添加新任务')
        .fontSize(20)
        .margin({ bottom: 20 })

      TextInput({
          text: this.newPlanText,
          placeholder: '请输入任务内容'
      })
        .width('80%')
        .onChange((value: string) => {
          this.newPlanText = value
        })
        .margin({ bottom: 20 })

      Row({ space: 20 }) {
        Button('取消')
          .onClick(() => {
            this.showAddDialog = false
            this.newPlanText = ''
          })

        Button('确定')
          .onClick(() => {
            this.addNewPlan()
          })
      }
    }
    .padding(30)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .width('70%')
  }

  // ========== 普通方法 ==========
  // 切换单个项目的完成状态
  toggleItemById(id: number): void {
    // 创建新数组
    this.planList = this.planList.map(item => {
      if (item.id === id) {
        return {
          id: item.id,
          plan: item.plan,
          isFinished: !item.isFinished,
          createTime: item.createTime
        }
      }
      return item
    })
  }

  // 格式化时间显示
  formatTime(timestamp: number): string {
    const date = new Date(timestamp)
    const month = date.getMonth() + 1
    const day = date.getDate()
    const hour = date.getHours().toString().padStart(2, '0')
    const minute = date.getMinutes().toString().padStart(2, '0')
    return `${month}月${day}日 ${hour}:${minute}`
  }

  // 全部完成/全部取消
  markAll(finished: boolean): void {
    this.planList = this.planList.map((item: PlanItem): PlanItem => ({
      id: item.id,
      plan: item.plan,
      isFinished: finished,
      createTime: item.createTime
    }))
  }

  // 添加新任务
  addNewPlan(): void {
    if (this.newPlanText.trim() === '') return

    const maxId = this.planList.reduce((max, item) => item.id > max ? item.id : max, 0)
    const newId = maxId + 1

    const newItem: PlanItem = {
      id: newId,
      plan: this.newPlanText.trim(),
      isFinished: false,
      createTime: Date.now()
    }

    this.planList = this.planList.concat([newItem])
    this.newPlanText = ''
    this.showAddDialog = false
  }

  // 删除任务
  deletePlanById(id: number): void {
    this.planList = this.planList.filter(item => item.id !== id)
  }

  // ========== build() 方法 ==========
  build() {
    Column() {
      // 标题和统计
      Row() {
        Text('待办')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .padding({ left: 20 })

        Text(`已完成: ${this.planList.filter(item => item.isFinished).length}/${this.planList.length}`)
          .fontSize(16)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .margin({ top: 5, bottom: 5 })

      // 待办列表
      List() {
        ForEach(this.planList, (item: PlanItem) => {
          ListItem() {
            Row({ space: 20 }) {
              // 图标
              Image(item.isFinished ? $r('app.media.finish') : $r('app.media.unfinish'))
                .width(28)
                .height(28)
                .onClick(() => {
                  this.toggleItemById(item.id)
                })

              Column({ space: 5 }) {
                Text(item.plan)
                  .fontSize(16)
                  .fontWeight(500)
                  .decoration({
                    type: item.isFinished ? TextDecorationType.LineThrough : TextDecorationType.None
                  })
                  .fontColor(item.isFinished ? Color.Gray : Color.Black)

                if (item.createTime) {
                  Text(this.formatTime(item.createTime))
                    .fontSize(12)
                    .fontColor(Color.Gray)
                }
              }
              .layoutWeight(1)
            }
            .padding({ left: 20, right: 20 })
            .margin({ top: 10, bottom: 10 })
            .borderRadius(25)
            .backgroundColor(Color.White)
            .width('100%')
            .height(70)
          }
        })
      }
      .width('100%')
      .height('50%')
      .padding({ left: 20, right: 20 })

      // 操作按钮
      Row({ space: 30 }) {
        Button('全部完成')
          .onClick(() => {
            this.markAll(true)
          })

        Button('全部取消')
          .onClick(() => {
            this.markAll(false)
          })

        Button('添加任务')
          .onClick(() => {
            this.showAddDialog = true
          })
      }
      .margin({ top: 20 })

      if (this.showAddDialog) {
        Column() {
          this.addTaskDialog()
        }
        .margin({ top: 20 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}