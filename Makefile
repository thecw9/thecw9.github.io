# server and deploy hexo project 

# server: serve hexo project
.PHONY: server
server:
	hexo server


# deploy: deploy hexo project
.PHONY: deploy
deploy:
	hexo clean && hexo deploy
