
all: clean dirs distribution

dirs:
		mkdir -p build/
		mkdir -p dist/

distribution:
		pushd build/ && cmake .. -DCMAKE_INSTALL_PREFIX=../dist && make install && popd

zip: all
		pushd dist/include/ && \
		zip --symlinks \
			--compression-method deflate \
			-9 -r \
			../../bx-lexical-cast-$(shell cat VERSION).zip \
			bx-lexical-cast/* && \
		popd

tarball: all
		pushd dist/include/ && \
		tar cvzf \
			../../bx-lexical-cast-$(shell cat VERSION).tar.gz \
			--include='*' \
			bx-lexical-cast/ && \
		popd

clean:
		rm -rf build/ dist/

distclean:
		rm -rf build/ dist/ bx-lexical-cast-*.zip bx-lexical-cast-*.tar.gz

.PHONY: all dirs distribution clean
