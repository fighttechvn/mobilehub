#!/bin/bash

# [envName]_[versionName]_[yyMMddHH]_[versionCode]
TAG_NAME=develop_1.0.0_23050316_4

git tag $TAG_NAME
git push origin $TAG_NAME