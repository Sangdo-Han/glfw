project "GLFW"
    kind "StaticLib"
    language "C"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    staticruntime "on"

    -- These are the common files required by ALL platforms.
    -- This now includes the complete "null" backend and common context APIs.
    files
    {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/platform.c",
        "src/vulkan.c",
        "src/window.c",
        
        "src/null_init.c",
        "src/null_monitor.c",
        "src/null_window.c",
        "src/null_joystick.c",
        
        "src/egl_context.c",
        "src/osmesa_context.c"
    }

---

    filter "system:linux"
        pic "On"
        systemversion "latest"

        -- Platform-specific files for Linux (X11)
        files
        {
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/glx_context.c",
            "src/linux_joystick.c"
        }

        defines { "_GLFW_X11" }

---
    filter "system:windows"
        defines { "_GLFW_WIN32" }
		-- buildoptions {"-std=c11", "-lgdi32"}
        systemversion "latest"

        -- Platform-specific files for Windows
        files
        {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/win32_module.c",
            "src/wgl_context.c",
            -- newly added
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

        defines 
        { 
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }


    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"