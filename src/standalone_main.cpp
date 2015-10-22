
#define CATCH_CONFIG_RUNNER
#include <catch_ros/catch.hpp>

#include <boost/filesystem.hpp>

namespace fs = boost::filesystem;

int main( int argc, char* const argv[] )
{
	Catch::Session session; // There must be exactly once instance

	// writing to session.configData() here sets defaults
	// this is the preferred way to set them

	int returnCode = session.applyCommandLine( argc, argv );
	if( returnCode != 0 ) // Indicates a command line error
	return returnCode;

	// The catkin scripts calling tests do not create the output directory for
	// us :-(
	fs::path outputPath = session.configData().outputFilename;

	fs::path outputDir = outputPath.parent_path();
	if(!fs::exists(outputDir))
	{
		fs::create_directories(outputDir);
	}

	// writing to session.configData() or session.Config() here
	// overrides command line args
	// only do this if you know you need to

	return session.run();
}

