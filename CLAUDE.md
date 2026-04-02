- # 🧠 Claude Operating System（COS）

  ------

  # 🚀 1. 启动与上下文恢复

  Claude 在以下情况必须执行初始化：

  - 对话开始
  - 上下文丢失
  - 会话重启

  ## 📥 必须加载文件

  - claude.md
  - task_plan.md
  - findings.md
  - progress.md

  ------

  # 📌 2. 文件更新规则（强制）

  ## 🗂️ task_plan.md（任务计划）

  - 仅在需求新增 / PRD 变更时更新
  - 禁止执行过程中频繁修改

  ## 🧠 findings.md（决策）

  - 仅记录架构 / 技术决策
  - 禁止记录执行过程

  ## 📊 progress.md（进度）

  每步必须更新：

  - 已完成内容
  - 当前状态
  - 下一步行动

  ------

  ## ❗禁止行为

  - 不更新 progress.md
  - 将执行过程写入 findings.md
  - 三文件同时重写

  ------

  # 🔌 3. 工具使用规范

  ## OpenSpec（仅需求输入）

  允许：

  - 用户故事
  - 验收标准
  - 功能描述

  禁止：

  - 写 task_plan.md
  - 写 progress.md
  - 生成代码

  流程：

  OpenSpec → Brainstorm → 用户确认 → 执行

  ------

  ## 🎨 Figma（UI 唯一事实源）

  当涉及 UI：

  - 必须基于 Figma 实现
  - 禁止凭空写 UI

  ------

  # 🧠 4. 系统能力

  Claude 是具备以下能力的工程代理：

  - Planning（规划）
  - Reasoning（推理）
  - Execution（执行）
  - Tracking（记录）

  ------

  # 🎨 5. Design Layer（设计驱动）

  ## Figma → Code（强制流程）

  Figma → Design Analysis → Component → Code

  ------

  ## Design Analysis 必须包含：

  - 页面结构（Layout）
  - 组件拆解（Component）
  - 样式（颜色 / 字体 / 间距）
  - 交互（状态 / 动效）

  ------

  ## ❗禁止

  - 未分析设计稿直接开发
  - UI 与设计稿不一致

  ------

  # 📁 6. Task Planning（强制）

  触发条件：

  - PRD 新增
  - PRD 结构变化

  ------

  ## 执行流程

  PRD → Task Planning → task_plan.md

  ------

  ## ❗约束

  - 未生成 task_plan.md 禁止写代码
  - 不允许跳过任务拆解

  ------

  # 🔄 7. 标准执行流程（强制）

  1. Brainstorm
  2. 用户确认
  3. PRD 更新（如有）
  4. 🎨 Figma 分析（UI 必须）
  5. Task Planning
  6. 组件映射（Design → Code）
  7. 代码实现
  8. Artifact 落地
  9. UI 验证
  10. 更新 progress.md

  ------

  # 📊 8. 输出要求

  每次必须输出：

  [状态对齐报告]

  - 当前任务：
  - 已完成进度：
  - 下一步行动：

  ------

  # 🧠 9. 落盘机制

  必须写入：

  - task_plan.md（任务）
  - findings.md（决策）
  - progress.md（进度）

  ------

  ## 写入格式

  === WRITE_FILE: filename ===
  content
  === END ===

  ------

  # 🎯 10. UI 实现标准（强制）

  ## 视觉一致

  - 布局 / 间距 / 对齐一致
  - 字体 / 颜色一致

  ## 组件一致

  - 结构必须匹配设计稿
  - 必须可复用

  ## 交互一致

  - 状态完整（hover / active / disabled）
  - 动效必须实现

  ------

  ## ❗原则

  - 不允许“接近实现”
  - 必须精确还原

  ------

  # 🚨 11. 核心约束

  - 禁止跳步骤执行
  - 禁止未确认直接开发
  - 禁止自动提交 Git
  - 所有结果必须可追溯

  ------

  # 🔄 执行闭环

  Plan → Findings → Execute → Progress