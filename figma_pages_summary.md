# Figma 图片集成页面汇总

**更新日期**: 2026-04-02
**Figma 文件 Key**: `HPtpuBt4RrvXdzDLy4vUN1`

---

## 已实现 Figma 远程图片集成的页面

| # | 页面名称 | Swift 文件 | Figma 节点 | 图片数量 | 状态 |
|---|---------|-----------|-----------|---------|------|
| 1 | 商城首页 | ShopPage.swift | `1:2` | 50+ | ✅ |
| 2 | 商品详情页 | ProductDetailPage.swift | `1:6` | 7 | ✅ |
| 3 | 购物车页 | CartPage.swift | `1:10` | 动态 | ✅ |
| 4 | 空购物车 (心愿单) | EmptyCartFromWishlistView.swift | `1:10` | 动态 | ✅ |
| 5 | 空购物车 (热门) | EmptyCartFromPopularView.swift | `1:10` | 4 | ✅ |
| 6 | 支付页 | PaymentPage.swift | `1:14` | 动态 | ✅ |
| 7 | 引导页 - Hello | HelloCardPage.swift | `0:12` | 5 | ✅ |
| 8 | 引导页 - Ready | ReadyCardPage.swift | `0:15` | 5 | ✅ |

---

## 图片 URL 管理

所有图片 URL 已集中管理于：`ShoppeiOS/Utilities/ImageURLProvider.swift`

### 提供的方法

| 方法 | 用途 | 调用示例 |
|------|------|---------|
| `getProductImageURL(for:)` | 商品图片（根据颜色） | `ImageURLProvider.getProductImageURL(for: "#FFB6C1")` |
| `getVariationImageURL(for:)` | 变体缩略图（根据颜色） | `ImageURLProvider.getVariationImageURL(for: "#B6D4FF")` |
| `getBubbleImageURL(id:)` | 装饰气泡（ID: 01-04） | `ImageURLProvider.getBubbleImageURL(id: "01")` |
| `getOnboardingHeroImageURL(page:)` | 引导页英雄图 | `ImageURLProvider.getOnboardingHeroImageURL(page: "hello")` |

### 支持的颜色映射

| 颜色名称 | Hex 值 | 对应 Figma 资源 |
|---------|--------|----------------|
| Pink | #FFB6C1 | ed3e9463-9a3b-43ba-90b9-da37bf20ccaa |
| Blue | #B6D4FF | e3719d83-504e-4f54-a3b0-1b4760a4d9cb |
| Yellow | #FFF4B6 | 95dc9ed1-944f-49ec-b9f6-43b9e090d3da |
| Light Pink | #FFD1DC | d80951b1-d8df-4011-b71e-8824a19e43f1 |
| Green | #E8F5E9 | c8d6c11f-0ac9-411e-9169-335a6e032f55 |
| Peach | #FFD4C5 | c8d6c11f-0ac9-411e-9169-335a6e032f55 |
| Coral | #FF6B6B | ed3e9463-9a3b-43ba-90b9-da37bf20ccaa |
| Gold | #FFD700 | 95dc9ed1-944f-49ec-b9f6-43b9e090d3da |

---

## 各页面 Figma 资源详情

### 1. ShopPage (商城首页)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=1-2

**集成内容**:
- 顶部气泡装饰：4 个 Figma 远程图片
- 分类图标：Beauty, Makeup, Skincare, Anti Aging, Body Care, Hair Oil
- 商品卡片：12+ 商品，每个含主图 + 变体缩略图

**使用的 URL**:
```
气泡 01: https://www.figma.com/api/mcp/asset/519160aa-3a48-4b71-9e85-b0e06d486ccc
气泡 02: https://www.figma.com/api/mcp/asset/a43f07da-7d51-4897-add2-7141a47f82cc
气泡 03: https://www.figma.com/api/mcp/asset/7c3026b7-b34f-4af1-91e6-9ef17b35a5d5
气泡 04: https://www.figma.com/api/mcp/asset/d944b704-3181-4ca2-8e17-79a79b651bee
```

---

### 2. ProductDetailPage (商品详情页)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=1-6

**集成内容**:
- 主产品图片轮播
- 3 个变体颜色缩略图（粉/蓝/黄）
- 分享图标

**使用的 URL**:
```
主图: https://www.figma.com/api/mcp/asset/e3719d83-504e-4f54-a3b0-1b4760a4d9cb
粉: https://www.figma.com/api/mcp/asset/ed3e9463-9a3b-43ba-90b9-da37bf20ccaa
蓝: https://www.figma.com/api/mcp/asset/e3719d83-504e-4f54-a3b0-1b4760a4d9cb
黄: https://www.figma.com/api/mcp/asset/95dc9ed1-944f-49ec-b9f6-43b9e090d3da
```

---

### 3. CartPage (购物车页)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=1-10

**集成内容**:
- 购物车商品图片（根据颜色动态映射）
- 心愿单商品图片（根据颜色动态映射）

**使用方式**:
```swift
AsyncImage(url: URL(string: ImageURLProvider.getProductImageURL(for: item.imageColor)))
```

---

### 4. EmptyCartFromWishlistView (空购物车 - 心愿单)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=1-10

**集成内容**:
- 心愿单商品列表图片

---

### 5. EmptyCartFromPopularView (空购物车 - 热门)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=1-10

**集成内容**:
- 4 个热门商品卡片图片

---

### 6. PaymentPage (支付页)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=1-14

**集成内容**:
- 订单商品图片（根据颜色动态映射）

---

### 7. HelloCardPage (引导页 - Hello)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=0-12

**集成内容**:
- 英雄人物图片
- 装饰元素

**使用的 URL**:
```
英雄图: https://www.figma.com/api/mcp/asset/2573f889-36e4-4317-ad75-a6b0c7cd4ed0
```

---

### 8. ReadyCardPage (引导页 - Ready)

**Figma URL**: https://figma.com/design/HPtpuBt4RrvXdzDLy4vUN1?node-id=0-15

**集成内容**:
- 英雄人物图片
- 装饰元素

**使用的 URL**:
```
英雄图: https://www.figma.com/api/mcp/asset/28737776-dbf1-405e-9a30-5fd7efc8c1d3
```

---

## 技术实现细节

### AsyncImage 使用模式

所有页面统一使用以下模式加载远程图片：

```swift
AsyncImage(url: URL(string: ImageURLProvider.getProductImageURL(for: item.imageColor))) { image in
    image.resizable()
        .aspectRatio(contentMode: .fill)
} placeholder: {
    RoundedRectangle(cornerRadius: 8)
        .fill(Color(hex: item.imageColor))
        .frame(width: 100, height: 100)
}
```

### 颜色标准化处理

```swift
static func getProductImageURL(for color: String) -> String {
    switch color.uppercased().trimmingCharacters(in: .whitespaces) {
    case "#FFB6C1": return "..."
    // ...
    }
}
```

---

## 注意事项

1. **Figma CDN URL 有效期**: 7 天，部署前需验证链接是否有效
2. **本地缓存**: 建议在生产环境中添加图片缓存机制
3. **加载状态**: 所有 AsyncImage 均提供占位图，确保加载过程中的视觉一致性

---

## 下一步 (P1 功能)

| 页面 | 文件路径 | 预计图片数量 |
|------|---------|-------------|
| Profile 页面 | Views/Profile/ProfilePage.swift | 5+ |
| Wishlist 页面 | Views/Wishlist/WishlistPage.swift | 10+ |
| Categories 页面 | Views/Categories/CategoriesPage.swift | 20+ |
| Search 页面 | Views/Search/SearchPage.swift | 10+ |
