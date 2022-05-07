#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AutoCheckCode
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName AutoCheckCode.sh

# Documentation:
# @raycast.description AutoCheckCode
# @raycast.author logyxiao
# @raycast.authorURL https://github.com/logyxiao

#!/bin/bash

echo "starting to check code";
  # 路径中的 dufu 记得改成自己电脑的名字
  # 通过 Sqlite3 查 1 条 iMessage 最近 60 秒收到消息（ iMessage 收到消息的时间可能有延迟，这里实际冗余多了 2 秒）
  #! /Users/dufu/Library/Messages/chat.db
  #！这个 DB 文件和目录记得给开权限，默认是不给读的。
  result=$(sqlite3 $HOME/Library/Messages/chat.db 'SELECT text FROM message WHERE datetime(date/1000000000 + 978307200,"unixepoch","localtime") > datetime("now","localtime","-60 second") ORDER BY date DESC LIMIT 1;')

  name="验证码";

  # 看下最近有没有收到消息
  if [ ! $result ]; then
      echo "latest not receive code messsages";
      osascript -e "display notification \"最近 60 秒未收到验证码！\" with title \"提示\"   ";
      return
  fi

#   如果短信中包含验证码则取前 4-6 个数字
  if [[ "$result" =~ "$name" ]]; then
      code=`echo $result | grep -o "[0-9]\{4,6\}"`;
      echo "code is $code";
      # 将获取到的数字输出到剪贴板
      echo "$code" | pbcopy;

      # 发个系统通知，展示内容，同时提醒你可以 Command + v 粘贴了。
      osascript -e "display notification \"$code\" with title \"验证码已复制\"";
  fi

