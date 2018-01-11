public enum Log.Level {
    MESSAGE,
    WARNING,
    ERROR,
    CRITICAL,
    INFO,
    DEBUG,
    TRACE
}

public class Log.Context {

    private int verbosity = 0;
    private string domain = "log";
    private GLib.FileStream? stream = null;
    private string? file = null;

    public Context () { }

    public void init (string domain) {
        this.domain = domain;
    }

    public void set_verbosity (int verbosity) {
        this.verbosity = verbosity;
    }

    public int get_verbosity () {
        return verbosity;
    }

    private void _log (int level, string fmt, va_list list) {
        string tag;

        switch (level) {
            case Level.MESSAGE:
                tag = (stream == null)
                    ? " \033[1;32mMESSAGE\033[0m"
                    : " MESSAGE";
                break;
            case Level.WARNING:
                tag = (stream == null)
                    ? " \033[1;33mWARNING\033[0m"
                    : " WARNING";
                break;
            case Level.ERROR:
                tag = (stream == null)
                    ? "   \033[1;31mERROR\033[0m"
                    : "   ERROR";
                break;
            case Level.CRITICAL:
                tag = (stream == null)
                    ? "\033[1;35mCRITICAL\033[0m"
                    : "CRITICAL";
                break;
            case Level.INFO:
                tag = (stream == null)
                    ? "    \033[1;32mINFO\033[0m"
                    : "    INFO";
                break;
            case Level.DEBUG:
                tag = (stream == null)
                    ? "   \033[1;32mDEBUG\033[0m"
                    : "   DEBUG";
                break;
            case Level.TRACE:
                tag = (stream == null)
                    ? "   \033[1;32mTRACE\033[0m"
                    : "   TRACe";
                break;
            default:
                tag = (stream == null)
                    ? " \033[1;32mMESSAGE\033[0m"
                    : " MESSAGE";
                break;
        }

        if (verbosity >= level) {
            var msg = "%s: %8s: ".printf (domain, tag);
            if (stream == null) {
                stdout.puts (msg);
                stdout.vprintf (fmt, list);
            } else {
                stream.puts (msg);
                stream.vprintf (fmt, list);
                stream.flush ();
            }
        }
    }

    public void message (string fmt, ...) {
        var list = va_list ();
        _log (Level.MESSAGE, fmt, list);
    }

    public void warning (string fmt, ...) {
        var list = va_list ();
        _log (Level.WARNING, fmt, list);
    }

    public void error (string fmt, ...) {
        var list = va_list ();
        _log (Level.ERROR, fmt, list);
    }

    public void critical (string fmt, ...) {
        var list = va_list ();
        _log (Level.CRITICAL, fmt, list);
    }

    public void info (string fmt, ...) {
        var list = va_list ();
        _log (Level.INFO, fmt, list);
    }

    public void debug (string fmt, ...) {
        var list = va_list ();
        _log (Level.DEBUG, fmt, list);
    }

    public void trace (string fmt, ...) {
        var list = va_list ();
        _log (Level.TRACE, fmt, list);
    }
}
