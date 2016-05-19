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
    outf.write(str(int(1000*float(line[2:7])))+"\n")

outf.close()

