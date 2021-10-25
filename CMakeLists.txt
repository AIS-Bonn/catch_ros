
cmake_minimum_required(VERSION 3.4)
project(catch_ros)

find_package(catkin REQUIRED COMPONENTS roscpp)
find_package(Boost REQUIRED COMPONENTS filesystem)

catkin_package(
	INCLUDE_DIRS include
	CATKIN_DEPENDS roscpp
	CFG_EXTRAS catch.cmake
)

include_directories(include ${catkin_INCLUDE_DIRS})

add_library(catch_ros_standalone
	src/standalone_main.cpp src/meta_info.cpp
)
target_compile_features(catch_ros_standalone PUBLIC cxx_std_11)
target_link_libraries(catch_ros_standalone PRIVATE ${Boost_LIBRARIES} ${CMAKE_DL_LIBS})

add_library(catch_ros_rostest
	src/rostest_main.cpp src/meta_info.cpp
)
target_compile_features(catch_ros_rostest PUBLIC cxx_std_11)
target_link_libraries(catch_ros_rostest PRIVATE ${Boost_LIBRARIES} ${catkin_LIBRARIES} ${CMAKE_DL_LIBS})

install(TARGETS catch_ros_standalone catch_ros_rostest
	LIBRARY DESTINATION ${CATKIN_GLOBAL_LIB_DESTINATION}
)

install(DIRECTORY include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
