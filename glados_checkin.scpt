#!/usr/bin/osascript

-- GLaDOS 自动签到脚本
-- 依赖：Chrome 已登录 GLaDOS

tell application "Google Chrome"
    activate
    
    -- 找已有的 GLaDOS 标签页
    set gladosTab to missing value
    set gladosWin to missing value
    
    repeat with w in windows
        repeat with t in tabs of w
            if URL of t contains "glados.rocks" then
                set gladosTab to t
                set gladosWin to w
                exit repeat
            end if
        end repeat
        if gladosTab is not missing value then exit repeat
    end repeat
    
    -- 没有就打开
    if gladosTab is missing value then
        open location "https://glados.rocks/console/checkin"
        delay 6
        set gladosTab to active tab of window 1
    end if
    
    -- 切到该标签
    set active tab index of gladosWin to index of gladosTab
    set index of gladosWin to 1
    delay 3
    
    -- 执行签到
    set jsResult to execute javascript "
(async () => {
  try {
    const resp = await fetch('https://glados.rocks/api/user/checkin', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
      body: JSON.stringify({token: 'glados.network'}),
      credentials: 'include'
    });
    const data = await resp.json();
    return JSON.stringify(data);
  } catch(e) {
    return 'ERROR: ' + e.message;
  }
})();
"
    
    return jsResult
end tell