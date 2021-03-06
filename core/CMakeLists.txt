include_directories(.)
find_package(Qt5
    REQUIRED COMPONENTS
    Core
    Gui
    Quick
    Sql
    PrintSupport
    LinguistTools)
add_definitions(-DCORE_LIBRARY)

add_library(core SHARED
        cropmodel.cpp
        cropstatmodel.cpp
        databaseutility.cpp
        db.cpp
        expensecategorymodel.cpp
        expensemodel.cpp
        family.cpp
        familymodel.cpp
        harvestmodel.cpp
        inputmodel.cpp
        keyword.cpp
        keywordmodel.cpp
        location.cpp
        locationmodel.cpp
        mdate.cpp
        nametree.cpp
        note.cpp
        notemodel.cpp
        qrpimageprovider.cpp
        planting.cpp
        plantingmodel.cpp
        print.cpp
        recordmodel.cpp
        rolemodel.cpp
        seedcompanymodel.cpp
        seedlistmodel.cpp
        seedlistmonthmodel.cpp
        seedlistquartermodel.cpp
        sortfilterproxymodel.cpp
        task.cpp
        taskimplementmodel.cpp
        taskmethodmodel.cpp
        taskmodel.cpp
        tasktemplatemodel.cpp
        tasktypemodel.cpp
        transplantlistmodel.cpp
        treemodel.cpp
        unitmodel.cpp
        usermodel.cpp
        variety.cpp
        varietymodel.cpp
        buildinfo.cpp
        helpers.cpp
        seedcompany.cpp
        sqltablemodel.cpp
        tasktemplate.cpp
        templatetask.cpp
        templatetaskmodel.cpp
        tableprinter.cpp
        qquicktreemodeladaptor.cpp
	core_resources.qrc)

target_link_libraries(core Qt5::Core Qt5::Quick Qt5::Gui Qt5::Sql Qt5::PrintSupport)
