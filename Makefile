REPO := $(shell git config --get remote.origin.url)
GHPAGES = gh-pages

all: clean $(GHPAGES) build

build:
	cd $(GHPAGES) && \
	jekyll build && \
	\ls | grep -v "_site" | xargs git rm -fr && \
	mv _site/* . && \
	rm -fr "_site"

$(GHPAGES):
	@echo $(REPO)
	git clone "$(REPO)" "$(GHPAGES)"
	@echo "Donezo"
	# (cd $(GHPAGES) && git checkout $(GHPAGES) || cd $(GHPAGES) && git checkout --orphan $(GHPAGES))
	cd $(GHPAGES) && git checkout --orphan $(GHPAGES)

clean:
	rm -rf $(GHPAGES)

commit:
	cd $(GHPAGES) && \
		git add . && \
		git commit --edit --message="Publish @$$(date)"
	# cd $(GHPAGES) && \
	# 	git push origin $(GHPAGES)

.PHONY: clean commit
