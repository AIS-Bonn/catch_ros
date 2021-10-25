// Tell catch_ros about the package we are using it in
// Original Author: Max Schwarz <max.schwarz@uni-bonn.de>
// Rewritten using dlopen() by Timo Röhling <timo.roehling@fkie.fraunhofer.de>

#include <dlfcn.h>

namespace catch_ros
{
	namespace meta
	{
		const char* packageName()
		{
			static const char* package_name = nullptr;
			if (package_name == nullptr)
			{
				void* handle = dlopen(nullptr, RTLD_NOW);
				if (handle)
				{
					const char* const* package_name_ptr = reinterpret_cast<const char* const*>(dlsym(handle, "catch_ros_local_package_name"));
					if (package_name_ptr)
						package_name = *package_name_ptr;
					dlclose(handle);
				}
				if (package_name == nullptr)
					package_name = "UNKNOWN";
			}
			return package_name;
		}
	}
}
