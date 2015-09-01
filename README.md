# Racket Hello World
https://github.com/andreiled/mipt-cs-4sem/wiki/Пошаговая-инструкция-по-работе-с-git-и-github-для-студентов
-- git config --global user.name  "beremour"
-- git config --global user.email "user@email.com"
git clone git@github.com:beremour/racket-hello-world.git
cd racket-hello-world
git config user.name "beremour"
git config user.email "user@email.com"
--
git add %file_path%
git commit -m "%commit_message%"
--
git log
git log --name-only
--
git add README.md
git commit -m "1st commit"
git push
git push origin master
