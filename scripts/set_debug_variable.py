import os

from utils import error

SCRIPT_PATH = os.path.realpath(__file__)
SCRIPT_DIRECTORY = os.path.dirname(SCRIPT_PATH)
GLOBALS_TS_PATH = os.path.join(SCRIPT_DIRECTORY, "..", "src", "types", "Globals.ts")


def set_debug_variable(value):
    if not os.path.exists(GLOBALS_TS_PATH):
        error("The globals file does not exist at: {}".format(GLOBALS_TS_PATH))

    with open(GLOBALS_TS_PATH, "rb") as file:
        file_data = file.read()

    file_string = file_data.decode("utf-8")
    file_string = file_string.replace("debug = true;", "debug = false;")
    file_data = file_string.encode("utf-8")

    with open(GLOBALS_TS_PATH, "wb") as file:
        file.write(file_data)