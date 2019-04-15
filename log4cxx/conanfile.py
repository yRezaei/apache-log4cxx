from conans import ConanFile, tools


class Log4cxxConan(ConanFile):
    name = "log4cxx"
    version = "0.10.0"
    settings = "os", "compiler", "build_type", "arch"
    description = "<Description of Log4cxx here>"
    url = "None"
    license = "None"
    author = "Yashar A. rezaei"
    topics = None
    options = {"shared": [True, False]}
    default_options = {"shared": False}

    def requirements(self):
        self.requires.add("apr/1.7.0@yrezaei/stable")
        self.requires.add("apr-util/1.5.4@yrezaei/stable")

    def package(self):
        self.copy("*")

    def package_info(self):
        self.cpp_info.libs = tools.collect_libs(self)
