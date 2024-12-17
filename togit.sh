git push origin master
# 通过中转服务器，将代码同步更新到github
ssh zhangtianqing@www.zhangtq.com -p 22 "cd /home/zhangtianqing/beautify_cnblogs && git pull gitee master && git merge github/master && git push github master"
