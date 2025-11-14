set shell := ["bash", "-lc"]

# Default task
default: serve

serve *args:
	export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH" && \
	bundle exec jekyll serve --livereload {{args}}

build *args:
	export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH" && \
	bundle exec jekyll build {{args}}

doctor *args:
	export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH" && \
	bundle exec jekyll doctor {{args}}
