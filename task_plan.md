# Shoppe iOS 任务计划

**版本**: 1.0
**创建日期**: 2026-04-02
**最后更新**: 2026-04-02

---

## 任务列表

### 阶段 1: 认证流程 (P0)

| ID | 页面名称 | Figma Node | 状态 | 备注 |
|----|----------|------------|------|------|
| 1.1 | 启动页 (Start) | 0:12855 | ⏳ Pending | PRD 3.1 |
| 1.2 | 注册页 (Create Account) | 0:12779 | ⏳ Pending | PRD 3.2 |
| 1.3 | 登录页 (Login - Email) | 0:12718 | ⏳ Pending | PRD 3.3 |
| 1.4 | 密码输入页 (Password) | 0:12649 | ⏳ Pending | PRD 3.4 |
| 1.5 | 密码状态页 (Password Typing/Wrong) | 0:12584/0:12518 | ⏳ Pending | PRD 3.4 |
| 1.6 | 密码找回 - 选择方式 | 0:12449 | ⏳ Pending | PRD 3.5 |
| 1.7 | 密码找回 - 验证码 | 0:12382 | ⏳ Pending | PRD 3.5 |
| 1.8 | 密码找回 - 新密码 | 0:12315 | ⏳ Pending | PRD 3.5 |

### 阶段 2: 引导流程 (P0)

| ID | 页面名称 | Figma Node | 状态 | 备注 |
|----|----------|------------|------|------|
| 2.1 | 引导页 - Hello Card | 0:12177 | ⏳ Pending | PRD 3.6 |
| 2.2 | 引导页 - Ready Card | 0:12113 | ⏳ Pending | PRD 3.6 |

### 阶段 3: 商城首页 (P0)

| ID | 页面名称 | Figma Node | 状态 | 备注 |
|----|----------|------------|------|------|
| 3.1 | 商城首页 (Shop) | 0:11012 | ⏳ Pending | PRD 3.7 |
| 3.2 | Flash Sale + Live | 0:10857 | ⏳ Pending | PRD 3.7 |

### 阶段 4: 商品详情 (P0)

| ID | 页面名称 | Figma Node | 状态 | 备注 |
|----|----------|------------|------|------|
| 4.1 | 商品详情页 (Product) | 0:8785 | ⏳ Pending | PRD 3.8 |
| 4.2 | 商品促销页 (Product Sale) | 0:8689 | ⏳ Pending | PRD 3.8 |
| 4.3 | 商品完整页 (Product Full) | 0:8438 | ⏳ Pending | PRD 3.8 |
| 4.4 | 商品规格选择 (Variations) | 0:8314 | ⏳ Pending | PRD 3.8 |

### 阶段 5: 购物车与支付 (P0)

| ID | 页面名称 | Figma Node | 状态 | 备注 |
|----|----------|------------|------|------|
| 5.1 | 购物车 (Cart) | 0:7209 | ⏳ Pending | PRD 4.3 |
| 5.2 | 空购物车 - 从心愿单 | 0:7085 | ⏳ Pending | - |
| 5.3 | 空购物车 - 从热门 | 0:6969 | ⏳ Pending | - |
| 5.4 | 支付页 (Payment) | 0:6830 | ⏳ Pending | - |
| 5.5 | 添加优惠券 | 0:6638 | ⏳ Pending | - |

### 阶段 6: 其他功能 (P1)

| ID | 页面名称 | Figma Node | 状态 | 备注 |
|----|----------|------------|------|------|
| 6.1 | 个人中心 (Profile) | 0:11956 | ⏳ Pending | - |
| 6.2 | 完整个人资料 | 0:11472 | ⏳ Pending | - |
| 6.3 | 心愿单 (Wishlist) | 0:7998 | ⏳ Pending | - |
| 6.4 | 搜索功能 | 0:9375 | ⏳ Pending | - |
| 6.5 | 分类筛选 | 0:9526 | ⏳ Pending | - |
| 6.6 | 聊天功能 | 0:3542-0:2400 | ⏳ Pending | - |
| 6.7 | 设置 | 0:1460 | ⏳ Pending | - |

---

## 技术规范

### 架构模式
- **MVVM** (Model-View-ViewModel)
- SwiftUI + Combine

### 目录结构
```
ShoppeiOS/
├── Models/           # 数据模型
├── Views/            # SwiftUI Views
│   ├── Auth/         # 认证相关
│   ├── Shop/         # 商城相关
│   ├── Product/      # 商品详情
│   ├── Cart/         # 购物车
│   └── Profile/      # 个人中心
├── ViewModels/       # ViewModel
├── Components/       # 可复用组件
├── Services/         # API 服务
├── Utils/            # 工具类
└── Resources/        # 资源文件
```

### 设计 Tokens
- 颜色、字体、间距从 Figma 提取
- 统一使用 Design System

### 代码要求
- 纯代码实现 (Storyboard)
- 支持 iOS 16+
- 使用 Swift 5.9+

---

## 执行顺序

1. ✅ 阶段 1: 认证流程 (Task 1.1 → 1.8)
2. ⏳ 阶段 2: 引导流程 (Task 2.1 → 2.2)
3. ⏳ 阶段 3: 商城首页 (Task 3.1 → 3.2)
4. ⏳ 阶段 4: 商品详情 (Task 4.1 → 4.4)
5. ⏳ 阶段 5: 购物车与支付 (Task 5.1 → 5.5)
6. ⏳ 阶段 6: 其他功能 (Task 6.1 → 6.7)

---

## 完成标准

- [ ] 所有 P0 页面完成
- [ ] UI 与 Figma 设计稿一致
- [ ] 交互逻辑符合 PRD
- [ ] 代码可编译运行
- [ ] 每个页面包含 Mock 数据预览
