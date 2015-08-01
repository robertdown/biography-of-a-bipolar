REPO := $(shell git config --get remote.origin.url)
GHPAGES = gh-pages

all: build commit clean

build:
	jekyll build
	cd _site && \
	git init && \
	git remote add origin git@github.com:robertdown/biography-of-a-bipolar.git && \
	git checkout --orphan $(GHPAGES)

clean:
	rm -rf _site

commit:
	cd _site && \
		git add . && \
		git commit --edit --message="Publish @$$(date)"
	cd _site && \
		git push --set-upstream origin $(GHPAGES)

.PHONY: clean commit
