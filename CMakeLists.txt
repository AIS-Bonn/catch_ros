
cmake_minimum_required(VERSION 2.8)
project(catch_ros)

find_package(catkin REQUIRED)

find_package(Boost REQUIRED COMPONENTS filesystem)

catkin_package(
	INCLUDE_DIRS include
	CFG_EXTRAS catch.cmake
)

include_directories(include)

add_library(catch_ros_standalone
	src/standalone_main.cpp
)
target_link_libraries(catch_ros_standalone
	${Boost_LIBRARIES}
)

add_library(catch_ros_rostest
	src/rostest_main.cpp
)
target_link_libraries(catch_ros_rostest
	${Boost_LIBRARIES}
)
