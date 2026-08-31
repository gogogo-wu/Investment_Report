# AGENTS.md — AI 智能体操作手册

> 本文件面向接手本仓库的 AI 智能体（WorkBuddy / Claude / Codex / Cursor 等）。**动手前必读。** 人类读者请看 README.md。

## 0. 这个仓库是什么

- 公开仓库 `gogogo-wu/Investment_Report`，经 GitHub Pages 自动部署（推送 main 后约 1-2 分钟生效）
- 内容：金融学习与研究报告，编号 **P01–P26** 递增，纯静态中文文件名 HTML，**无构建步骤**；另有按年月的**月度总结**（`mYY` 路由）
- 收纳规则：报告一律按 `2026/07/`、`2026/08/` 这样的 `年份/月份` 目录存放（**2026-08-31 起执行**，当月新报告进当月目录）
- 唯一入口：`index.html`（SPA：左侧导航 + 首页目录 + iframe + hash 路由，双击即可本地打开）

## 1. 文件角色

| 文件 | 角色 |
|---|---|
| `index.html` | 导航壳。多处需同步：月度总结分组（nav/toc）、侧栏 nav（约 L192 起）、首页 toc 目录（约 L450 起）、`REPORTS` 路由表（约 L530 起）、footer 统计与日期 |
| `2026/08/xxx.html` 等 | 报告按年月收纳，文件名与 `REPORTS` 表 `file` 字段（含目录前缀）逐字一致 |
| `2026/08/YYYY年M月发散笔记月度总结.html` | 每月月底生成的月度收束总结，登记为 `mYY` 路由，导航分组"月度总结" |
| `README.md` | 人类入口 + 目录结构树 + **变更日志（每份新报告必须补一条）** |
| `update.bat` | 人类用的一键提交（`git add -A`）。智能体**不要用它**，逐文件 add 避免误提交 |
| `.workbuddy/`、`website/` | 私人数据 / 另一项目，已 gitignore，**禁止提交** |

## 2. 硬红线

- **禁止** force push、删分支、改写历史
- **禁止**提交 `.workbuddy/`（含私人记忆与持仓数据）和 `website/`
- **禁止**删除旧报告：过时结论用新报告覆盖，不回头改历史判断——仓库的价值一半在 commit 历史保留的决策原貌。修正仅限事实性错误
- 报告中真实持仓权重/成本价等敏感数字，收录或改动前**必须先向仓库主人确认**（现行 P23/P24 中为示例数字口径）

## 3. 新增一份报告的 SOP

设新编号为 `pageN`（当前最大 26，即下一份 27），报告放入当前月目录（如 `2026/09/报告标题.html`）：

1. 写 `2026/MM/报告标题.html`（规范见 §5）
2. `index.html` 注册（重点：REPORTS 的 `file` 字段必须带 `2026/MM/` 前缀）：
   - 侧栏：最后一个 `nav-item` 按钮后追加
     ```html
     <button class="nav-item" data-page="pageN">
       <span class="t">报告标题</span>
       <span class="d">一句话要点 · 分隔 · 分隔</span>
     </button>
     ```
   - 首页目录：最后一个 `toc-row` 后追加（`toc-no` 显示 `PNN`）
   - 路由表：最后一行行尾加逗号，追加
     ```js
     pageN: { file: '2026/MM/报告标题.html', title: '报告标题' }
     ```
   - footer：手动更新 `stat-num` 数字与"最后更新"日期（侧栏 `reportCount` 由 JS 自动统计，仅为冗余初值）
3. **月度总结登记**：月度总结文件放当月目录（`2026/MM/YYYY年M月发散笔记月度总结.html`），REPORTS 用 `mYY` 做 key（如 9 月为 `m09`），导航/目录登记在"月度总结"分组
4. `README.md` 两处更新：目录结构树 + 变更日志（**曾连续 6 轮漏掉变更日志，commit fc581f0 才补齐——别重蹈**）
5. 提交：
   ```bash
   git add "2026/MM/报告标题.html" index.html README.md
   git commit -m "P27 报告标题：三个要点"
   git push
   ```
6. 验证（中文文件名必须百分号编码，裸中文会 400/404；**URL 带目录前缀**）：
   ```bash
   sleep 90   # 等 Pages 构建
   ENC=$(python -c "import urllib.parse; print(urllib.parse.quote('2026/MM/报告标题.html'))")
   curl -sL -o /dev/null -w "%{http_code}\n" "https://gogogo-wu.github.io/Investment_Report/$ENC"
   # 200 = 上线成功
   ```
7. 本地双击 `index.html`，确认 hash 路由 `#pageN` 能打开新报告、侧栏计数正确

## 4. 修正既有报告的 SOP

- **事实性错误**（数字、日期、口径）：直接改报告 HTML；commit message 用 `修正 P2X：` 前缀，README 变更日志同步一条
- **不要悄悄改数字不留痕**——公开研究库的可信度靠 commit 历史
- 数据口径冲突时的处理惯例：优先官方/一手源，其次本土源（日文源 > 英文聚合源），并在文中注明口径与日期
- 改完同样走 §3 的第 5、6 步验证

## 5. 报告写作规范（保持全库一致性）

**视觉 token**（Apple 灰阶深色风）：
- 背景近黑 `#0a0a0c`，正文 `#d1d1d6`，次级 `#86868b`，标题 `#f5f5f7`
- h1 渐变标题；`badge-row` 标签行；section h2 带下边框；callout / conclusion 强调块
- 字体 `-apple-system, 'PingFang SC', sans-serif`
- 图表用**内联 SVG**（`viewBox="0 0 680 …"`，宽 680 自适应），不引用图片文件
- 行情配色遵循 A 股惯例：**涨红跌绿**

**内容结构**：
- 开头固定"大白话总评"——先结论后论证；行话术语先解释再使用
- 主体：事件出发 → 原理拆解 → 数据验证 → 前瞻判断 → 操作区间（Z1/Z2/Z3 分批 + 止损线）
- 结尾固定免责声明：**"以上仅为个人认知范围内的理解"**
- 重磅报告附一条"体系灵魂"编号条款（当前累计至第十一条，新报告接着编第十二条，**不重编号不删旧条**）

## 6. 已知坑

- 中文文件名 URL 必须百分号编码（见 §3 验证命令），且 **2026-08-31 收纳后 URL 必须带 `2026/08/` 目录前缀**——旧根路径链接会 404，属预期
- `index.html` 注册点共七处（nav / toc / REPORTS / stat-num / 日期 / README / 月度总结分组），漏一处会出现"报告存在但打不开"或"计数不符"
- 报告移动/收纳必须用 `git mv`（保留历史），禁止直接 `mv` 后重新 add（会断 rename 追踪）
- Windows 下 CRLF 警告无害，忽略
- iframe + hash 路由：部分手机浏览器 `hashchange` 不可靠，`index.html` 已用同步渲染兜底，不要移除该逻辑
