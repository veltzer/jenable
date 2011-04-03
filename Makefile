# parameters
SRC_FOLDER:=src
CLASS_FOLDER:=bin
SRC_FILES:=$(shell find $(SRC_FOLDER) -type f -name "*.java")
CLASS_FILES:=$(shell find $(CLASS_FOLDER) -type f -name "*.class")
ALL_DEP:=Makefile
JAR:=jenable.jar
# here we go...
.PHONY: all
all: $(JAR)
# next target creates the class folder for the case in which full clear
# including purging of empty dirs was performed...
$(JAR): compile.tag manifest $(ALL_DEP)
	-mkdir $(CLASS_FOLDER)
	jar cmf manifest $@ -C $(CLASS_FOLDER) .
compile.tag: $(SRC_FILES) $(ALL_DEP)
	javac -Xlint:all $(SRC_FILES) -d $(CLASS_FOLDER)
	touch compile.tag
.PHONY: clean
clean:
	-rm $(CLASS_FILES) compile.tag $(JAR)
.PHONY: seejar
seejar: $(JAR) $(ALL_DEP)
	jar tvf $(JAR)
.PHONY: run
run: $(JAR) $(ALL_DEP)
	java -jar $(JAR)
