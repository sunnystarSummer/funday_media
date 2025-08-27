#!/bin/bash

# Setting up json_serializable in a project
#flutter pub add json_annotation dev:build_runner dev:json_serializable

# One-time code generation
dart run build_runner build --delete-conflicting-outputs
