project('Basic Logging', ['vala', 'c'],
  default_options: [
    'buildtype=release',
    'default_library=shared',
  ],
  version: '0.1.0'
)

glib_dep = dependency('glib-2.0')
gobject_dep = dependency('gobject-2.0')

log_deps = [
  glib_dep,
  gobject_dep,
]

subdir('src')
subdir('examples')
