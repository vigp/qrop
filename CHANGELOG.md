# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

## Changed 
 - *Plantings* − Always show seed company next to variety name if the feature is
   activated (#176).
 - *Charts* − the whole view is now updated when the user search for a planting.
 - *Calendar* − PDF output now follows the current view : week and
   done/due/overdue filters (#205). 
 - Improve filtering of plantings to show all plantings, or only the field or
   greenhouse ones.

## Fixed
 - *Calendar widget* − Fix days and week number display.
 - *Charts* − Update the view when database is changed (#214).
 - *Task dialog* − Fix display bug for location view: part of it wasn't alway
   visible (#201).
 - *Field map* − Fix planting timegraph for pluriannual crops (#169).
 - *Field map* − Fix refreshing bug when switch to field map view.
 - *Crop map* − Fix editing bug.

## 0.4.4 − 2020-01-28 

### Changed
 - *Planting dialog* − Show density field even if the beds aren't standardized.

### Fixed
 - *Field map* − Fix selection update after adding sublocations.
 - Use "system" as the default language setting.
 - *Calendar* − Fix bad month name.
 - *Planting dialog* − Fix bad seeds numbers for direct seeded planting
   with multiple seeds per hole.

## 0.4.3 "Albens" − 2020-01-23 

### Fixed
  - *Settings* − Fix scrollbar behavior.

## 0.4.2 "Albens" − 2020-01-23 

### Added
  - *Settings* − Add dropbox to select the language (#156).

### Changed
  - *PDF* − Show month name instead of number in sections (#168).
  - Improve the translation infrastructure.

### Fixed
  - *PDF* − Fix bad unit for weights : kg instead of g (#165).
  - *Planting map* − Fix duplication bug when using complete dates (#175).
  - *Field map* - Fix automatic numbering of location names (#164).
  - Fixed date picker's bad year selection (#171).
  - *PDF* - Field map: Fix wrong location height when aren't displayed (#157).

## 0.4.1. - 2019-12-02 

### Changed
  - *Settings* − Use integer text field instead of spinbox (#149).

### Fixed
  - *Field map* − Fix crashing bug when creating a brand new field map.
  - *Settings* − Density switch is now available even if the user doesn't have
    standard beds (#144).
  - *Plantings* − Fix fullscreen displaying of the pictures linked to notes (#154).

## 0.4 "Bobéhec" - 2019-10-15

### Added
  - *Field map* − Show planting length when it doesn't fill the location (or
    when it is longer than the location's length).
  - Add tooltips for the buttons of the left bar.
  - *Planting form* − Add density (m²) field (#126).

### Changed
  - *Field map* - Dropping a planting on location while pressing Ctrl will assign
    the planting to its subsequent siblings if needed.
  - *Field map* − Improve PDF output : multiline view, better tasks and planting
    drawings.
  - *Field map* − Multi-line view (#76).
  - *Field map* − When editing the field map, Crl+Left click now selects all
    children of a location (#113).
  - *Seeds and transplants lists* − Add quarter and month PDF outputs (#131).
  - *Seeds and transplants lists* − Add quarter and month views (#131).
  - *Planting map* − Minor improvement of the chart pane.
  - *PDF* − Minor improvements of PDF output for calendar.
  - *Planting map* − Improve side sheets look.
  - Improve planting and task views performance.

### Fixed
  - *Field map* − Show task color.
  - *Planting form* − Fix the bug which prevented planting conflicts.
  - *Seeds and transplants lists* − Fix sorting bug for dates and names.
  - Fix planting length when assigning to multiple locations.

## 0.3 - 2019-06-15

### Added
  - *Task calendar* − Add sorting function for tasks (#122).
  - *Seed company* − Add a radio button to choose default seed company (#111).
  - *Task dialog* − Create several tasks at once (#133).
  - Add a default variety feature ; create an unknown variety when creating a crop. The
    default varierty is automatically chosen when the user choose a crop in the
    planting form (#128).
  - Add charts for planting distribution and revenue.
  - *Field map* − Show tasks.
  - *Tasks* − Add task templates, which enables the user to define several tasks
    and apply them to plantings.
  - *Crop plan* - Show estimated revenue.
  - Add planting succession numbering by crop and planting date.

### Changed
  - *Planting dialog* − Check date consitency when editing one planting (#119).
  - *Plantings* − It is now possible for a planting not to have a unit (#106).
  - Field map output: more space for long location names (#141).
  - *Harvest dialog* − Show currently harvested crops. When one planting is
    selected, show only the plantings of the same specie.
  - Show error messages for mandatory fields.
  - Improve time edit field behavior: switch between hours and minutes with
    (back)tab (#99).
  - *Crop plan* − Show planting's color only when it has been seeded or planted.

### Fixed
  - Fixed month selection bug in date picker for complete dates (#114).
  - *Planting map* − Duplicate keywords when plantings are duplicated.
  - *Harvest dialog* − Split harvest time between multiple plantings (#96).
  - *Field map* − Don't show rotation conflict when two plantings overlaps on the
    same location (#117).
  - Simple dialogs − fixed bad positioning (#107).
  - *Harvest dialog* − Refresh quantity in editing twice the same harvest (#101).
  - *Harvest dialog* − Show the right unit for the selected planting(s), assuming
    they all have the same unit (#100).
  - Fix time edit field behavior: it is no longer possible to enter minutes > 60
    (#102).

## 0.2.1 - 2019-05-13

### Added
  - It is now possible to work with two databases at the same time, and switch
    between them by clicking on the button "1" and "2" on the left panel. The
    user can create, open and export databases.

## 0.2 - 2019-05-02

### Added
  - *Crop plan* - Import and export from/to CSV file.
  - *Crop plan* − Add "duplicate to another year" feature.
  - Add print output for crop plan, task calendar, field map, harvests, seed and
    transplant lists.
  - Add a view for seed and planting lists to make it easier to order them.
  - *Planting view* - Shift selection of planting intervals with mouse or
    keyboard.
  - *Field map* − Add button show family or crop color.
  - Basic note taking feature for plantings.
  - Harvest page.
  - Standardized beds mode: user can now define a standard bed length, and use
    this length as a unit for planting lengths.
  - *Field map* − Add greenhouse filter mode to only show greenhouse locations
    and plantings. Add a new shortcut for this mode (Ctrl+G).
  - *Field map* − Add a button to show planting conflicts on a location.
    Clicking on the button will open a menu select a conflicting planting and
    either edit, unassign or split the planting if there is remaining space on
    the location.
  - *Field map* − Add an “assign to block” feature: when dropping a planting on
   a location which has sublocations, assign the planting to the sublocations,
    checking for available space if planting conflicts aren't authorized.
  - *Field map* − Add option to allow planting conflicts on the same location.
  - *Field map* − Add option to show full name of locations.

### Changed
  - *Planting form* − When editing a planting, it is now possible to change its
    locations.
  - Show tags in planting view and week calendar.
  - If a planting type is changed from TP, raised to DS or TP, bough, its nursery
    task is now remove and its DTT is set to 0.
  - Improve combo boxes.
  - Use decimal numbers for planting length, surface and seeds per gram.
  - *Planting view/form*: When using week dates, we assume that the harvest will
    end at the *end* of the end harvest week.
  - *Planting form* : it is now possible to bulk edit keywords.
  - The year now begins with winter instead of spring.
  - *Timeline* − For week date format, don't show year indicators < and > anymore.

### Fixed
  - Fix planting type change bug (#94)
  - Fix note view.
  - *Planting form*: quantities are correctly recomputed when (bulk) editing
    plantings.
  - *Planting form* : when (bulk) editing planting(s), if the length, the number
    of rows or the in-row spacing have changed, recompute the number of plants
    needed for each planting.
  - *Planting view/form*: when creating a planting for which locations has been
    selected, the locations are now immediately visible in the planting view.
  - *Planting form*: fields are now always visible when nagivating with tab.
  - Deployment error  on Linux.

## 0.1.2 − 2019-01-23

### Added
  - *Field map* − Add button, menu and shortcuts to expand/collapse location
    level.
  - Keyboard shortcuts for the most common actions (see user guide in the wiki
    for more details).
  - *Settings* − Add restart snackbar.
  - *Planting form* − Add a checkbox for duration fields to enable or disable
    date calculation from durations. Add setting options to enable or disable
    durations by default and to hide duration fields.
  - *Plantings view* − Show an icon for greenhouse crops.
  - *Field map* − After dragging a planting over a location which has
    sublocations for some time, it will expand if it is collapsed.
  - *Database* − Migration framework: start to cleanly migrate database schemas,
    setting a database version and writing a SQL script for each new database
    version. Each script will applied successively to reach the latest version.

### Changed
  - *Field map* − Attach show/hide button to the plantings pane.
  - Update French translation.

### Fixed
  - *Planting view* - Properly set greenhouse checkbox state.
  - *Plantings view* − Timegraph end harvest bar drawing (add one week).
  - *Planting form* − Date update bug which prevented proper duration update.
  - ComboBox: fix popup scrollbar.
  - Properly clean database before reset.

## 0.1.1 - 2019-01-10

### Fixed
  - AppImage building.

## 0.1 - 2019-01-09

First public release.
