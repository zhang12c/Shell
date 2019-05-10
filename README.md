# Shell
脚本练习册
第二步：

echo "# Test" >> README.md

第三步：建立git仓库

git init

第四步：将项目的所有文件添加到仓库中

git add .

第五步：

git add README.md

第六步：提交到仓库

git commit -m "注释语句"

第七步：将本地的仓库关联到GitHub，后面的https改成刚刚自己的地址，上面的红框处

git remote add origin https://github.com/zlxzlxzlx/Test.git

第八步：上传github之前pull一下

git pull origin master

第九步：上传代码到GitHub远程仓库

git push -u origin master
