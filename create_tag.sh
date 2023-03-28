#!/bin/bash

# [envName]_[versionName]_[yyMMddHH]_[versionCode]
TAG_NAME=develop_1.0.0_23032820_1

git tag $TAG_NAME
git push origin $TAG_NAME