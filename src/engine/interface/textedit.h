#ifndef TEXTEDIT_H_
#define TEXTEDIT_H_

struct EditLine
{
    enum { Chunk_Size = 256 };

    char *text;
    int len, maxlen;

    EditLine() : text(nullptr), len(0), maxlen(0) {}
    EditLine(const char *init) : text(nullptr), len(0), maxlen(0)
    {
        set(init);
    }

    bool empty();
    void clear();
    bool grow(int total, const char *fmt = "", ...);
    void set(const char *str, int slen = -1);
    void prepend(const char *str);
    void append(const char *str);
    bool read(stream *f, int chop = -1);
    void del(int start, int count);
    void chop(int newlen);
    void insert(char *str, int start, int count = 0);
    void combinelines(vector<EditLine> &src);
};

enum
{
    Editor_Focused = 1,
    Editor_Used,
    Editor_Forever
};

struct Editor
{
    int mode; //editor mode - 1= keep while focused, 2= keep while used in gui, 3= keep forever (i.e. until mode changes)
    bool active, rendered;
    const char *name;
    const char *filename;

    int cx, cy; // cursor position - ensured to be valid after a region() or currentline()
    int mx, my; // selection mark, mx=-1 if following cursor - avoid direct access, instead use region()
    int maxx, maxy; // maxy=-1 if unlimited lines, 1 if single line editor

    int scrolly; // vertical scroll offset

    bool linewrap;
    int pixelwidth; // required for up/down/hit/draw/bounds
    int pixelheight; // -1 for variable sized, i.e. from bounds()

    vector<EditLine> lines; // MUST always contain at least one line!

    Editor(const char *name, int mode, const char *initval) :
        mode(mode), active(true), rendered(false), name(newstring(name)), filename(nullptr),
        cx(0), cy(0), mx(-1), maxx(-1), maxy(-1), scrolly(0), linewrap(false), pixelwidth(-1), pixelheight(-1)
    {
        //printf("editor %08x '%s'\n", this, name);
        lines.add().set(initval ? initval : "");
    }

    ~Editor()
    {
        //printf("~editor %08x '%s'\n", this, name);
        DELETEA(name);
        DELETEA(filename);
        clear(nullptr);
    }

    bool empty();
    void clear(const char *init = "");
    void init(const char *inittext);
    void updateheight();
    void setfile(const char *fname);
    void load();
    void save();
    void mark(bool enable);
    void selectall();
    bool region(int &sx, int &sy, int &ex, int &ey);
    bool region();
    EditLine &currentline();
    void copyselectionto(Editor *b);
    char *tostring();
    char *selectiontostring();
    void removelines(int start, int count);
    bool del(); // removes the current selection (if any)
    void insert(char ch);
    void insert(const char *s);
    void insertallfrom(Editor *b);
    void scrollup();
    void scrolldown();
    void key(int code);
    void input(const char *str, int len);
    void hit(int hitx, int hity, bool dragged);
    int limitscrolly();
    void draw(int x, int y, int color, bool hit);
};

extern vector<Editor *> editors;
extern Editor *textfocus;

extern void readyeditors();
extern void flusheditors();
extern Editor *useeditor(const char *name, int mode, bool focus, const char *initval = nullptr);

#endif
