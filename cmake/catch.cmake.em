#
# Add a Catch executable target.
#
# An executable target is created with the source files, it is linked
# against Catch. It is also registered as dependency of the run_tests target.
#
# :param target: the target name
# :type target: string
# :param source_files: a list of source files used to build the test
#   executable
# :type source_files: list of strings
#
function(catch_add_test target)
	file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/${target}_meta_info.cpp"
	"extern \"C\" { const char* catch_ros_local_package_name = \"${PROJECT_NAME}\"; }")
	add_executable(${target}
		${ARGN}
		"${CMAKE_CURRENT_BINARY_DIR}/${target}_meta_info.cpp"
	)

	# If catch_ros_standalone is built in this CMake instance, add a dependency on it
	if(TARGET catch_ros_standalone)
		add_dependencies(${target} catch_ros_standalone)
	endif()

	target_compile_features(${target} PUBLIC cxx_std_11)
	target_link_libraries(${target}
		@(DEVELSPACE ? CATKIN_DEVEL_PREFIX : CMAKE_INSTALL_PREFIX)/lib/libcatch_ros_standalone.so
	)

	if(TARGET ${target})
		# make sure the target is built before running tests
		add_dependencies(tests ${target})

		get_target_property(_target_path ${target} RUNTIME_OUTPUT_DIRECTORY)
		set(cmd "${_target_path}/${target} -r ros_junit -o ${CATKIN_TEST_RESULTS_DIR}/${PROJECT_NAME}/catch-${target}.xml")
		catkin_run_tests_target("catch" ${target} "catch-${target}.xml" COMMAND ${cmd} DEPENDENCIES ${target})
	endif()
endfunction()

#
# Add a Catch rostest executable target.
#
# An executable target is created with the source files, it is linked
# against Catch.
# In contrast to catch_add_test, this function links against a main() function
# which also calls ros::init(). Also, the test is not registered with the
# run_tests target, because it is expected that you use the test inside of
# a rostest.
#
# :param target: the target name
# :type target: string
# :param source_files: a list of source files used to build the test
#   executable
# :type source_files: list of strings
#
function(catch_add_rostest_node target)
	file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/${target}_meta_info.cpp"
	"extern \"C\" { const char* catch_ros_local_package_name = \"${PROJECT_NAME}\"; }")
	add_executable(${target}
		${ARGN}
		"${CMAKE_CURRENT_BINARY_DIR}/${target}_meta_info.cpp"
	)

	# If catch_ros_rostest is built in this CMake instance, add a dependency on it
	if(TARGET catch_ros_rostest)
		add_dependencies(${target} catch_ros_rostest)
	endif()

	# Make sure the test node is built before running any tests, see #8
	if(TARGET tests)
		add_dependencies(tests ${target})
	endif()

	target_compile_features(${target} PUBLIC cxx_std_11)
	target_link_libraries(${target}
		@(DEVELSPACE ? CATKIN_DEVEL_PREFIX : CMAKE_INSTALL_PREFIX)/lib/libcatch_ros_rostest.so
	)
endfunction()
