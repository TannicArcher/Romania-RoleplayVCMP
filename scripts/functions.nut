function GetTok(string, separator, n, ...) {
    local m = vargv.len() > 0 ? vargv[0] : n,
        tokenized = split(string, separator),
        text = "";
    if (n > tokenized.len() || n < 1) return null;
    for (; n <= m; n++) {
        text += text == "" ? tokenized[n - 1] : separator + tokenized[n - 1];
    }
    return text;
}

function NumTok(string, separator) {
    local tokenized = split(string, separator);
    return tokenized.len();
}

function PlrColToStrHex(plr)
{
    local r = format("%02X", plr.Color.r);
    local g = format("%02X", plr.Color.g);
    local b = format("%02X", plr.Color.b);
    return "[#"+r+g+b+"]";
}

C_RED <- "[#ff0000]";
C_GREEN <- "[#00ff00]";
C_BLUE <- "[#0000ff]";
C_WHITE <- "[#ffffff]";