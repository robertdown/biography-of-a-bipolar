REPO := $(shell git config --get remote.origin.url)
GHPAGES = gh-pages

all: clean $(GHPAGES) build commit

build:
	cd $(GHPAGES) && \
	jekyll build && \
	\ls | grep -v "_site" | xargs git rm -fr && \
	mv _site/* . && \
	rm -fr "_site"

$(GHPAGES):
	git clone "$(REPO)" "$(GHPAGES)"
	cd $(GHPAGES) && git checkout $(GHPAGES)

clean:
	rm -rf $(GHPAGES)

commit:
	cd $(GHPAGES) && \
		git add . && \
		git commit --edit --message="Publish @$$(date)"
	cd $(GHPAGES) && \
		git push --set-upstream origin $(GHPAGES)

.PHONY: clean commit
