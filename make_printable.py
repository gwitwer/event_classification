import string
def make_printable(s):
    printable = set(string.printable)
    filter(lambda x: x in printable, s)
    return s
