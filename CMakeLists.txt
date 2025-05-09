
cmake_minimum_required(VERSION 3.13)
project(catch_ros)

find_package(catkin REQUIRED COMPONENTS
	roscpp
)

find_package(Boost REQUIRED COMPONENTS filesystem)

catkin_package(
	INCLUDE_DIRS include
	CATKIN_DEPENDS roscpp
	CFG_EXTRAS catch.cmake
)

include_directories(include ${catkin_INCLUDE_DIRS})

add_library(catch_ros_standalone
	src/standalone_main.cpp
	src/meta_info_unknown.cpp
)
target_link_libraries(catch_ros_standalone
	${Boost_LIBRARIES}
)
target_link_options(catch_ros_standalone PRIVATE
	"-Wl,-z,defs"
)

add_library(catch_ros_rostest
	src/rostest_main.cpp
	src/meta_info_unknown.cpp
)
target_link_libraries(catch_ros_rostest
	${Boost_LIBRARIES}
)
target_link_options(catch_ros_standalone PRIVATE
	"-Wl,-z,defs"
)

install(FILES src/meta_info.cpp DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
install(TARGETS catch_ros_standalone catch_ros_rostest
	LIBRARY DESTINATION ${CATKIN_GLOBAL_LIB_DESTINATION}
)

install(DIRECTORY include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)

