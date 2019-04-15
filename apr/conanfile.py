from conans import ConanFile, tools


class AprConan(ConanFile):
    name = "apr"
    version = "1.7.0"
    settings = "os", "compiler", "build_type", "arch"
    description = "<Description of Apr here>"
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
