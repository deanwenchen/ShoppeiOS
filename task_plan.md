# 任务计划：PRD 验证与 Figma 对齐

**目标**: 验证 PRD.md 中所有需求的页面是否已实现，并检查与 Figma 设计图的对齐情况

---

## Goal Statement

验证 Shoppe iOS 项目中 PRD.md 定义的所有页面是否已正确实现，并确保每个实现的页面与 Figma 设计稿精确对齐。

---

## Phase 0: 上下文恢复

- [x] 读取 PRD.md 识别所有页面需求
- [ ] 读取现有进度文件了解已实现状态
- [ ] 获取 Figma 文件结构和节点映射

---

## Phase 1: PRD 页面清单识别

从 PRD.md 提取所有页面需求：

| PRD 章节 | 页面名称 | 文件路径 | 优先级 |
|---------|---------|---------|--------|
| 3.1 | 启动页 (StartPage) | Views/Auth/StartPage.swift | P0 |
| 3.2 | 注册页 (CreateAccount) | Views/Auth/CreateAccount.swift | P0 |
| 3.3 | 登录页 (LoginPage) | Views/Auth/LoginPage.swift | P0 |
| 3.4 | 密码页 (PasswordPage) | Views/Auth/PasswordPage.swift | P0 |
| 3.4 | 密码输入态 (PasswordTypingPage) | Views/Auth/PasswordTypingPage.swift | P0 |
| 3.4 | 密码错误态 (WrongPasswordPage) | Views/Auth/WrongPasswordPage.swift | P0 |
| 3.5 | 密码找回 - 选择 (PasswordRecoveryPage) | Views/Auth/PasswordRecoveryPage.swift | P0 |
| 3.5 | 密码找回 - 验证码 (PasswordRecoveryCodePage) | Views/Auth/PasswordRecoveryCodePage.swift | P0 |
| 3.5 | 密码找回 - 新密码 (NewPasswordPage) | Views/Auth/NewPasswordPage.swift | P0 |
| 3.5 | 最大尝试次数 (MaximumAttemptsPage) | Views/Auth/MaximumAttemptsPage.swift | P0 |
| 3.6 | 引导页 - Hello (HelloCardPage) | Views/Onboarding/HelloCardPage.swift | P0 |
| 3.6 | 引导页 - Ready (ReadyCardPage) | Views/Onboarding/ReadyCardPage.swift | P0 |
| 3.7 | 商城首页 (ShopPage) | Views/Shop/ShopPage.swift | P0 |
| 3.8 | 商品详情页 (ProductDetailPage) | Views/Product/ProductDetailPage.swift | P0 |
| 4.x | 购物车 (CartPage) | Views/Cart/CartPage.swift | P0 |
| 4.x | 空购物车 - 心愿单 | Views/Cart/EmptyCartFromWishlist.swift | P0 |
| 4.x | 空购物车 - 热门 | Views/Cart/EmptyCartFromPopular.swift | P0 |
| 4.x | 支付页 (PaymentPage) | Views/Payment/PaymentPage.swift | P0 |
| 4.x | 添加优惠券 (AddCouponPage) | Views/Payment/AddCouponPage.swift | P0 |

---

## Phase 2: 文件实现验证

对每个页面执行：
1. 检查 Swift 文件是否存在
2. 检查文件内容完整性
3. 标记缺失或异常的页面

---

## Phase 3: Figma 设计对齐验证

对每个已实现的页面：
1. 获取 Figma 设计上下文 (get_design_context)
2. 获取设计截图 (get_screenshot)
3. 比较实现与设计的差异
4. 记录对齐度评分

---

## Phase 4: 汇总报告

输出：
1. 已实现页面清单
2. 缺失页面清单
3. Figma 对齐度报告
4. 需要修复的问题列表

---

## Phase 5: 待完成功能实现

实现 4 个待完成功能：

| 功能 | 页面 | 实现内容 |
|------|------|---------|
| 5.1 | 引导页滑动切换 | 添加手势支持、完善 4 页引导 |
| 5.2 | 密码验证导航 | 添加默认账号验证逻辑 (test@gmail.com / 12345678) |
| 5.3 | 验证码错误计数 | 添加本地错误计数逻辑 |
| 5.4 | 商品详情页完善 | 配送方式、用户评价 UI |

---

## Decisions & Notes

- Figma 文件 Key: HPtpuBt4RrvXdzDLy4vUN1
- 使用 Figma MCP 进行设计验证
- 对齐度评分标准：
  - ✅ ~95%: 布局、颜色、字体、间距均一致
  - ⚠️ ~80%: 主要元素一致，细节有差异
  - ❌ <80%: 结构或视觉存在显著差异
- 默认测试账号：test@gmail.com / 12345678

---

## Phase Status

| Phase | Status | Notes |
|-------|--------|-------|
| Phase 0: 上下文恢复 | completed | 初始化完成 |
| Phase 1: PRD 页面清单识别 | completed | 19 个 P0 页面已识别 |
| Phase 2: 文件实现验证 | completed | 19/19 文件存在 |
| Phase 3: Figma 设计对齐验证 | completed | 19/19 已验证 (~95%) |
| Phase 4: 汇总报告 | completed | 验证报告已生成 |
| Phase 5: 待完成功能实现 | completed | 5.1 5.2 5.3 5.4 全部完成 |
| Phase 6: ShopPage Figma 远程图片集成 | completed | ShopPage 所有图片已替换为 Figma 远程资源 |
| Phase 7: ProductDetailPage Figma 远程图片集成 | completed | ProductDetailPage 图片 100% Figma 对齐 |
| Phase 8: CartPage Figma 远程图片集成 | completed | CartPage 商品图片 100% Figma 对齐 |
| Phase 9: PaymentPage Figma 远程图片集成 | completed | PaymentPage 商品图片 100% Figma 对齐 |
| Phase 10: Onboarding 页面 Figma 远程图片集成 | completed | HelloCardPage/ReadyCardPage 图片 100% Figma 对齐 |
| Phase 11: EmptyCart 页面 Figma 远程图片集成 | completed | EmptyCartFromWishlistView/EmptyCartFromPopularView 图片 100% Figma 对齐 |
| Phase 12: Figma 远程图片集成总结 | completed | 7 个主要页面、70+ 图片资源、完整报告生成 |
| Phase 13: ImageURLProvider 重构 | completed | 中央化工具类、消除重复代码、编译错误修复 |
