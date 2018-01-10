# liblog

Super simple logging functionality just here to try something out.

To use it in your code, simply add these lines to your `meson.build`:

``` meson

liblog = subproject('liblog')
liblog_dep = liblog.get_variable('liblog_dep')
```

Then, add `liblog_dep` to your dependencies array.
Finally, copy the [`liblog.wrap`][wrap] to your `subprojects` folder.

[wrap]:https://raw.githubusercontent.com/geoffjay/liblog/master/liblog.wrap
