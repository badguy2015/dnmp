#!/bin/bash
# git上传、下载时，不自动转换换行符。
git config --global core.autocrlf false
# 拒绝提交混合换行符文件
git config --global core.safecrlf true
