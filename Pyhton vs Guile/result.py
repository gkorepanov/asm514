inp = open ("times.txt", "r")

def linegen(infile):
    line = "notempty"
    while line:
        line = infile.readline()
        if line:
            yield line


mygen = linegen(inp)

outf = open("result.txt", "w")

for line in mygen:
    outf.write(line[0:-1] + " ")
    line = mygen.next()
    outf.write(str(reduce(lambda res, x: res + float(x), line.split(), 0)) + "\n")

outf.close()

