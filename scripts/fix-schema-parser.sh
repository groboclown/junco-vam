#!/bin/sh

# Tool to help clean up the go-jsonschema generated parser file.
if [ ! -f "$1" ] ; then
  echo "No such file: $1"
  exit 1
fi

# The import statements don't include all the necessary imports.
sed -i '/package schema/a import "strings"' "$1"
sed -i '/package schema/a import "github.com/mitchellh/mapstructure"' "$1"

# There's some use of "interface{}" when it really shouldn't.
sed -i -e 's/type Vac10SchemaJsonAuthors map\[string\]interface{}/type Vac10SchemaJsonAuthors map[string]AuthorDetail/g' "$1"

# And enums seem very unoptimal.
sed -i -E 's/var enumValues_(.*) = \[\]interface\{\}\{/var enumValues_\1 = []string\{/g' "$1"
sed -i -E 's/if reflect\.DeepEqual\(v, expected\)/if v == expected/g' "$1"

# Make it pretty
go fmt "$1"
