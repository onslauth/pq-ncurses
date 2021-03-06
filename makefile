include $(PQ_FACTORY)/factory.mk

pq_part_name := ncurses-5.9
pq_part_file := $(pq_part_name).tar.gz

pq_configure_args += --prefix=$(part_dir) --with-shared

#PQ_BIN := infocmp tabs tset tic captoinfo ncurses5-config clear infotocap tput toe reset

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name)
	$(MAKE) -C $(pq_part_name) install  DESTDIR=$(stage_dir)
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_configure_args)
	touch $@

patch-stamp: unpack-stamp
	cd $(pq_part_name) && patch -p1 < $(source_dir)/fix-configure-arflags.patch
	touch $@

unpack-stamp: $(pq_part_file)
	tar -xf $(source_dir)/$(pq_part_file)
	touch $@

