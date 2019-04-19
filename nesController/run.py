from os.path import join, dirname
from vunit.verilog import VUnit

root = dirname(__file__)

vu = VUnit.from_argv()

lib = vu.add_library("lib")

lib.add_source_files(join(root, "src/*.v"))
lib.add_source_files(join(root, "tests/*.sv"))
vu.main()
