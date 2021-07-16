project ('com.github.Suzie97.epoch', 'vala', 'c',
    version: '0.0.1'
)

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language: 'c')

gnome = import ('gnome')
i18n = import ('i18n')

c_args = [
    '-DGWEATHER_I_KNOW_THIS_IS_UNSTABLE',
]

executable(
    'com.github.Suzie97.epoch',
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Widgets/ClockFaces.vala',
    'src/Widgets/Labels.vala',
    'src/Widgets/CitiesChooser.vala',
    'src/Widgets/CitiesSearch.vala',
    'src/Views/PreferencesView.vala',
    'src/Views/MainView.vala',
    c_args: c_args,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('gtk+-3.0'),
        dependency('libgeoclue-2.0'),
        dependency('gweather-3.0'),
        dependency('granite'),
        dependency('geocode-glib-1.0'),
        dependency('cairo'),
        dependency('libhandy-1'),
        meson.get_compiler('c').find_library('m', required: false),
    ],
    install : true
)

meson.add_install_script('meson/post_install.py')

subdir ('data')
