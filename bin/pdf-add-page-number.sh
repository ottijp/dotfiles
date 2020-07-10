#!/bin/bash

if [ $# -lt 2 ] ; then
    echo usage: $0 src.pdf dest.pdf
    exit 1
fi

srcpdf="$1"
dstpdf="$2"
numbers_template="$HOME/templates/pdf-add-page-number/numbers.template.tex"

tempdir=$(uuidgen)
mkdir $tempdir
echo tempdir: $tempdir

cp "$srcpdf" "$numbers_template" $tempdir
cd $tempdir

pdfplatex="docker run --rm -v $PWD:/latex sotetsuk/platex build"
pdftk="docker run --rm -v $PWD:/work mnuessler/pdftk"

# devide original PDF
$pdftk "$srcpdf" burst output original_%04d.pdf

# create stamp PDF
pagecount=$(find . -name "original_*.pdf" | wc -l | tr -d " ")
sed 's/##pagecount##/'$pagecount'/' "$numbers_template" > numbers.tex
$pdfplatex numbers.tex
$pdftk numbers.pdf burst output number_%04d.pdf

# add page number
for i in $(seq -f %04g 1 $pagecount)
do
    $pdftk original_$i.pdf stamp number_$i.pdf output original_numbered_$i.pdf
done

# combine numbered PDF
$pdftk original_numbered_????.pdf output "$dstpdf"
mv "$dstpdf" ..

# cleanup
cd ..
rm -r $tempdir
