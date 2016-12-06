#!/bin/bash

dir=$(dirname $1)
kadai=${dir##*/}
ssh _ksjasm "rm -rf $kadai"
scp -r $kadai _ksjasm:~ && ssh _ksjasm "cd $kadai && make && ./main"
