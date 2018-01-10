public static int main (string[] args) {
    var log = new Log.Context ();
    int n = 0;

    log.init ("term");
    log.set_verbosity (Log.Level.DEBUG);

    log.message ("Test %d\n", n++);
    log.warning ("Test %d\n", n++);
    log.error ("Test %d\n", n++);
    log.critical ("Test %d\n", n++);
    log.info ("Test %d\n", n++);
    log.debug ("Test %d\n", n++);
    log.trace ("Test %d\n", n++);

    return 0;
}
