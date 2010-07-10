public class StringWrapper
{
	protected String m_text;
	protected int m_offset;

//#REUSE{
	public StringWrapper() {}
//#}REUSE{
//#REUSE:	public StringWrapper(String text) {
//#REUSE:		m_text = text;
//#REUSE:	}
//#REUSE}

//#REUSE{
	public void setText(String text) {
		m_text = text;
		m_offset = 0;
	}
//#REUSE}

	public int next() {
		if (++m_offset < m_text.length()) {
			return m_text.charAt(m_offset);
		} else {
			return -1;
		}
	}

//#!LIMIT{
//#LIMIT:	public int getOffset() {
//#LIMIT:		return m_offset;
//#LIMIT:	}
//#LIMIT:
//#LIMIT:	public void setOffset(int offset) {
//#LIMIT:		m_offset = offset;
//#LIMIT:	}
//#LIMIT:
//#LIMIT:	public int at(int offset) {
//#LIMIT:		if (offset < m_text.length()) {
//#LIMIT:			return m_text.charAt(offset);
//#LIMIT:		} else {
//#LIMIT:			return -1;
//#LIMIT:		}
//#LIMIT:	}
//#LIMIT:
//#LIMIT:	public String substring(int start) {
//#LIMIT:		return m_text.substring(start, m_offset);
//#LIMIT:	}
//#}LIMIT{
	public void reset() {
		m_offset = 0;
	}
//#LIMIT}
}
