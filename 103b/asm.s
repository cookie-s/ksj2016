# main.cのobject fileからenlargeをlinkできるようにsymbol:enlargeをexportする。
.globl enlarge

# ここからenlarge
enlarge:
    srawi %r4, %r3, 31  # 32bit整数用算術右シフト命令で、31bitシフトする。ここでsizeof(int)が4であることを暗に仮定している。
    ori %r4, %r4, 1     # 最下位bitをset。上と合わせて、%r4は、%r3のsign bitが1のとき-1, sign bitが0のとき1になる。
    add %r3, %r3, %r4   # %r4を%r3に足す。これがenlargeの返り値となる。
    blr
