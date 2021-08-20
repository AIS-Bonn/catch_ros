^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package catch_ros
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0.5.0 (2021-08-20)
------------------
* Update Catch to version v2.13.7 (PR #15)
* Update CMakeLists.txt to pass catkin_lint (PR #14)
* Contributors: Jorge Nicho, Martin Jansa, Max Schwarz, augustinmanecy, sven-herrmann

0.4.0 (2020-05-28)
------------------
* cmake: increase minimum version to 3.4 to silence CMP0048 warning
* rostest_main: handle weird rostest behavior on retries
* [reporter] makes tests and failure from test-cases instead of assertions
* Contributors: Max Schwarz, Naveed Usmani

0.3.0 (2019-01-02)
------------------
* cmake: catch_add_rostest() add new target as dependency of 'tests' target
  (issue: #8, PR: #9)
* README.md: add CATCH_CONFIG_MAIN hint (issue: #7)
* README: update link to the catch repo
* updated catch to 2.4.2 (PR: #6)
* ros_junit_reporter: fix warnings
* Contributors: Max Schwarz, Mez Gebre

0.2.0 (2018-05-08)
------------------
* adapt ROSReporter to Catch2
* upgrade to Catch v2.2.2
* Contributors: Max Schwarz

0.1.2 (2017-11-03)
------------------
* cmake: fix meta_info.cpp compilation for install space
* rostest_main: include ROS node name in report
* Contributors: Max Schwarz

0.1.1 (2016-10-26)
------------------
* actually install header files
* Contributors: Max Schwarz

0.1.0 (2016-10-26)
------------------
* initial proper release
* Contributors: Max Schwarz

