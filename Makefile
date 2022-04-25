##############
# PARAMETERS #
##############
# should we show commands executed?
DO_MKDBG:=0
# should we depend on the date of the makefile itself ?
DO_ALLDEP:=1
# do tools?
DO_TOOLS:=1

########
# code #
########
# where is the source folder?
SRC_FOLDER:=src
# where is the bin folder?
CLASS_FOLDER:=bin
# what are the source files?
SRC_FILES:=$(shell find $(SRC_FOLDER) -type f -name "*.java")
# what is the jar file we produce?
JAR:=jenable.jar
# what is the tools stamp?
TOOLS:=tools.stamp

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=$(TOOLS)
ALL+=$(TOOLS)
endif # DO_TOOLS

ifeq ($(DO_MKDBG),1)
Q=
# we are not silent in this branch
else # DO_MKDBG
Q=@
#.SILENT:
endif # DO_MKDBG

ALL+=$(JAR)

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

$(TOOLS): packages.txt config/deps.py
	$(info doing [$@])
	$(Q)xargs -a packages.txt sudo apt-get install
	$(Q)touch $(TOOLS)

# next target creates the class folder for the case in which full clear
# including purging of empty dirs was performed...
$(JAR): compile.tag manifest
	$(info doing [$@])
	$(Q)mkdir -p $(CLASS_FOLDER)
	$(Q)jar cmf manifest $@ -C $(CLASS_FOLDER) .
compile.tag: $(SRC_FILES)
	$(info doing [$@])
	$(Q)mkdir -p $(CLASS_FOLDER)
	$(Q)javac -Xlint:all $(SRC_FILES) -d $(CLASS_FOLDER)
	$(Q)touch compile.tag
.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)-rm -rf $(CLASS_FOLDER) compile.tag $(JAR)
.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd
.PHONY: seejar
seejar: $(JAR)
	$(Q)jar tvf $(JAR)
.PHONY: run
run: $(JAR)
	$(Q)java -jar $(JAR)
.PHONY: debug
debug:
	$(info SRC_FOLDER is $(SRC_FOLDER))
	$(info SRC_FILES is $(SRC_FILES))
	$(info CLASS_FOLDER is $(CLASS_FOLDER))
	$(info JAR is $(JAR))
	$(info ALL is $(ALL))
