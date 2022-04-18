#!/bin/bash

# saves arguments to variables
path=$1
name=$2
flag=$3

# validation
if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters"
    exit 0
fi

# if the 3rd argument is not the '-r' flag - no recursion.
if [ "$3" != "-r" ]; then
    # remove every .out file
    for file in $(ls)
        do
            if [ "${file: -4}" == ".out" ]; then
                rm $file
            fi
        done;
    # compiles every .c file with name being it's substring (ignore caps)
    for file in $(ls)
        do 
            if [ "${file: -2}" == ".c" ]; then
                if [[ $(grep -E '[,]'?'[ ]'?${name}'[0-9]'*'('[?!.]'|( ))' ${file}) ]]; then # if file is in relevant_files (substring of it)
                    filename="${file%.*}"
                    gcc $path/$file -w -o $filename.out 
                fi
            fi
        done;

    # if -r was passed - do recursion
    else
        # gets all files in the directory
        files_in_dir_and_subdir=$(find ${path} -name '*')

        # remove every .out file
        for file in ${files_in_dir_and_subdir}
            do
                if [ "${file: -4}" == ".out" ]; then
                    rm $file
                fi
        done;

        # compiles every .c file with name being it's substring (ignore caps)
        for file in ${files_in_dir_and_subdir}
            do
                if [ "${file: -2}" == ".c" ]; then
                    if [[ $(grep -E '[,]'?'[ ]'?${name}'[0-9]'*'('[?!.]'|( ))' ${file}) ]]; then # if file is in relevant_files (substring of it)
                        filename="${file%.*}"
                        gcc $path/$file -w -o $filename.out 
                    fi
                fi
        done;

fi
