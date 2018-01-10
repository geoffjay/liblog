if get_option('shared_lib')
  libtype = 'shared_library'
else
  libtype = 'static_library'
endif

log_sources = [
  'log.vala',
]

liblog = build_target('log',
       sources: log_sources,
  dependencies: log_deps,
   target_type: libtype,
   vala_header: 'log.h',
     vala_vapi: 'log.vapi',
   install_dir: [true, true, true],
       install: true,
)

liblog_dep = declare_dependency(
  include_directories: include_directories('.'),
            link_with: liblog,
)

pkg = import('pkgconfig')
pkg.generate(
    libraries: liblog,
      version: meson.project_version(),
         name: 'log',
  description: 'Simplify some stupid logging things that I occasionally do',
)
