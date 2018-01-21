[![Build Status](https://travis-ci.org/kuchosauronad0/tbsw.svg?branch=master)](https://travis-ci.org/kuchosauronad0/tbsw)
# Introduction
This Docker image aims to provide an easy  installation of the test beam software framework.
# Usage
```
docker build . -t tbsw
docker run --rm -it -v $PWD/root-files:/root/workspace-test/root-files tbsw testbeam-luise.py
```
