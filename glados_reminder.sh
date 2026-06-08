#!/bin/bash
# GLaDOS 签到提醒脚本
# 每天 08:00 自动打开签到页 + macOS 弹窗提醒

# 打开 GLaDOS 签到页
open -a "Google Chrome" "https://glados.rocks/console/checkin"

# macOS 弹窗提醒
osascript -e 'display notification "打开浏览器点击签到按钮 👆" with title "GLaDOS 签到提醒 ⏰" sound name "Glass"'

# 输出给 cron delivery
echo "✅ GLaDOS 签到页已打开，请点击签到按钮。"
echo "📎 https://glados.rocks/console/checkin"
