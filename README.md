# java-jenable

JEnable, a macro processor for Java.

JEnable reads Java source with control statements embedded in comments
starting with `//#` at the very beginning of a line, and enables or disables
blocks of code accordingly. This gives conditional compilation for Java
without leaving valid Java syntax.

## Layout

- `src/` - the Java sources (`JEnable.java`, `StringWrapper.java`).
- `doc/` - usage, control statement formats, a worked example and the changelog.
- `scripts/javac_build.py` - builds the classes and the jar.
