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

    /**
     * Retrieves a log level as a string.
     *
     * @param log_level Log level flags
     *
     * @return A string which shouldn't be modified or freed.
     */
    private static string level_str (Log.Level log_level) {
        switch ((ulong) log_level) {
            case Log.Level.ERROR:    return "   ERROR";
            case Log.Level.CRITICAL: return "CRITICAL";
            case Log.Level.WARNING:  return " WARNING";
            case Log.Level.MESSAGE:  return " MESSAGE";
            case Log.Level.INFO:     return "    INFO";
            case Log.Level.DEBUG:    return "   DEBUG";
            case Log.Level.TRACE:    return "   TRACE";
            default:                 return " UNKNOWN";
        }
    }

    /**
     * Retrieves a log  level as a term coloured string.
     *
     * @param log_level Log level flags
     *
     * @return A string which shouldn't be modified or freed.
     */
    private static string level_str_with_color (Log.Level log_level) {
        switch ((ulong) log_level) {
            case Log.Level.ERROR:    return "   \033[1;31mERROR\033[0m";
            case Log.Level.CRITICAL: return "\033[1;35mCRITICAL\033[0m";
            case Log.Level.WARNING:  return " \033[1;33mWARNING\033[0m";
            case Log.Level.MESSAGE:  return " \033[1;32mMESSAGE\033[0m";
            case Log.Level.INFO:     return "    \033[1;32mINFO\033[0m";
            case Log.Level.DEBUG:    return "   \033[1;32mDEBUG\033[0m";
            case Log.Level.TRACE:    return "   \033[1;36mTRACE\033[0m";
            default:                return " UNKNOWN";
        }
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
