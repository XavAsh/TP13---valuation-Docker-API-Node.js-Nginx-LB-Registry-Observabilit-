Node api Dockerfile of api , private register, nginx , privy tests(only critical), graphana, prometheus nodexporter, cadvisor,mounted volumes, named volumes and cicd pipeline GitHub , clean GitHub with readme with questions of test party 1 , config files need to be clear as he won’t clone project, and the notebook need to be readable by a human (pdf) 3 extra points for doing it on vps

Architectural structure

tp13/
.github/
workflows/
docker.yml
api/
app.js
[...]
nginx/
[...]
monitoring/
[...]
docker-compose.yml
docker-compose.registry.yml
docker-compose.prod.yml
README.md
captures/
