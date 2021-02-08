add_definitions(-DBUILDING_SPACEBAR)

set(quickkeyboard_SRCS
    DeclarativeInputEngine.cpp
    VirtualKeyboardInputContext.cpp
    VirtualKeyboardInputContextPlugin.cpp
)

# final lib
add_library(spacebarplatforminputcontextplugin MODULE ${quickkeyboard_SRCS})

target_link_libraries(spacebarplatforminputcontextplugin
                      Qt5::Core Qt5::Qml Qt5::Quick)

# Install phase
install(TARGETS spacebarplatforminputcontextplugin
        EXPORT  SpaceBarQuickPlatformInputContextPluginTargets
        RUNTIME DESTINATION "${INSTALL_INPUTCONTEXT_PLUGINS_DIR}" COMPONENT bin
        LIBRARY DESTINATION "${INSTALL_INPUTCONTEXT_PLUGINS_DIR}" COMPONENT shlib
        COMPONENT spacebar)

file(GLOB keymodel_FILES KeyModel*.qml)

# QML module
set(spacebarqml_FILES
    InputPanel.qml
    KeyButton.qml
    KeyPopup.qml
    qmldir
    ${keymodel_FILES}
)

install(FILES ${spacebarqml_FILES} DESTINATION ${INSTALL_QML_IMPORTS_DIR}/Hemera/Spacebar COMPONENT spacebar)
