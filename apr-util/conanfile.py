from conans import ConanFile, tools


class AprutilConan(ConanFile):
    name = "apr-util"
    version = "1.5.4"
    settings = "os", "compiler", "build_type", "arch"
    description = "<Description of Aprutil here>"
    url = "None"
    license = "None"
    author = "Yashar A. rezaei"
    topics = None
    options = {"shared": [True, False]}
    default_options = {"shared": False}

    def package(self):
        self.copy("*")

    def package_info(self):
        self.cpp_info.libs = tools.collect_libs(self)
