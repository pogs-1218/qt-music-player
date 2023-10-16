cmake_minimum_required(VERSION 3.16)

project(MusicPlayer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Multimedia)

qt_standard_project_setup()

qt_add_executable(appMusicPlayer
    main.cpp
)

qt_add_qml_module(appMusicPlayer
    URI MusicPlayer
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES AudioInfoBox.qml
    QML_FILES ImageButton.qml
    QML_FILES PlayListPanel.qml
    QML_FILES SearchPanel.qml
    QML_FILES SearchField.qml

    RESOURCES
    # Music Albums
    assets/images/CruelSummer-TaylorSwift.png
    assets/images/FastCar-LukeCombs.png
    assets/images/PaintTheTownRed-DojaCat.png
    assets/images/Snooze-SZA.png

    # Controller Icons
    assets/icons/itunes.png
    assets/icons/backward-fast.png
    assets/icons/forward-fast.png
    assets/icons/play.png
    assets/icons/stop.png
    assets/icons/list-music.png
    assets/icons/trash.png
    assets/icons/add.png
    assets/icons/search.png
    assets/icons/undo.png

    # Audios
    assets/audio/sample-15s.mp3
    assets/audio/sample-12s.mp3
    assets/audio/sample-9s.mp3
    assets/audio/sample-6s.mp3

    SOURCES PlayerController.h PlayerController.cpp
    SOURCES AudioInfo.h AudioInfo.cpp
    SOURCES AudioSearchModel.h AudioSearchModel.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMusicPlayer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appMusicPlayer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMusicPlayer
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appMusicPlayer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
