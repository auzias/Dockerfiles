Example to run `pdflatex` or `bibtex` assuming that the docker image name is *pdflatex*, this example is actually the auto-compile script used for my thesis:

```bash
#!/bin/bash

BUILD_DIR="./build"
FILE="thesis"
OPT="-shell-escape -interaction=nonstopmode -output-directory ${BUILD_DIR}"


while inotifywait -e modify ./*tex ./parts/*/*.tex; do
    # -draftmode doesn't write a PDF and doesn't read any included images, thus speeding up execution to produce the .aux
    docker run --rm -it -v `pwd`:/build --entrypoint=pdflatex pdflatex $OPT -draftmode  ${FILE}.tex
    # Create the bib
    docker run --rm -it -v `pwd`:/build --entrypoint=bibtex pdflatex  ${BUILD_DIR}/${FILE}.aux
    # Produce the pdf with the references and citations
    docker run --rm -it -v `pwd`:/build --entrypoint=pdflatex pdflatex $OPT ${FILE}.tex
    # next line may be useless (or not)
    docker run --rm -it -v `pwd`:/build --entrypoint=pdflatex pdflatex $OPT ${FILE}.tex

    # Move the pdf from the subdir to the current dir.
    mv ${BUILD_DIR}/${FILE}.pdf .


    # Display missing Citations or References
    WARNINGS=$(grep -E "Citation|Reference" ${BUILD_DIR}/thesis.log | sort | uniq)
    if [ "$WARNINGS" ]; then
        echo -e "\e[38;5;208m#####################################\e[0m"
        echo $WARNINGS
        echo -e "\e[38;5;208m#####################################\e[0m"
    else
        echo -e "\e[32;1mCompilation OK\e[0m"
    fi

done
```
