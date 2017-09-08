#!/usr/bin/env bash
# Regenerate repository used in introductory Git lesson.

# Use first command-line argument as path to repository directory.
if [ "$#" -ne 1 ]; then
  echo "Error: must provide path to Git repository as first command-line argument."
  exit 1
fi
REPO=$1

# Make sure the directory doesn't already exist.
if [ -d ${REPO} ]; then
  echo "Error: '${REPO}' already exists."
  exit 1
fi

# Shortcut to run Git in that repo.
G="git -C ${REPO}"

# initial empty repository.
rm -rf ${REPO}
mkdir ${REPO}
${G} init

# add-report-as-markdown: adding first Markdown file.
cat > ${REPO}/report.md <<EOF
# Northwestern Dental Surgeries 2017-18

TODO: write executive summary.

TODO: include link to raw data.
EOF
${G} add report.md
${G} commit -m "Adding summary report file."
${G} tag add-report-as-markdown

# change-report-filetype-to-text: change file suffix to .txt.
${G} mv report.md report.txt
${G} commit -m "Renaming report as plain text file rather than Markdown."
${G} tag change-report-filetype-to-text

# add-line-to-report: append some lines to the report file.
cat >> ${REPO}/report.txt <<EOF

TODO: remember to cite funding sources!
EOF
${G} add report.txt
${G} commit -m "Reminder to cite funding sources."
${G} tag add-line-to-report

# change-report-title: change the title line of the report in situ.
sed -i ${REPO}/report.txt 's/Northwestern Dental Surgeries/Seasonal Dental Surgeries/g'
${G} add report.txt
${G} commit -m "Changing title because purpose of report has changed."
${G} tag change-report-title

# adding-data-files: adding the four seasonal data files.
mkdir ${REPO}/data
cat > ${REPO}/data/spring.csv <<EOF
Date,Tooth
2017-01-25,wisdom
2017-02-19,canine
2017-02-24,canine
2017-02-28,wisdom
2017-03-04,incisor
2017-03-12,wisdom
2017-03-14,incisor
2017-03-21,molar
2017-04-29,wisdom
2017-05-08,canine
2017-05-20,canine
2017-05-21,canine
2017-05-25,canine
2017-06-04,molar
2017-06-13,bicuspid
2017-06-14,canine
2017-07-10,incisor
2017-07-16,bicuspid
2017-07-23,bicuspid
2017-08-13,bicuspid
2017-08-13,incisor
2017-08-13,wisdom
2017-09-07,molar
EOF
cat > ${REPO}/data/summer.csv <<EOF
Date,Tooth
2017-01-11,canine
2017-01-18,wisdom
2017-01-21,bicuspid
2017-02-02,molar
2017-02-27,wisdom
2017-02-27,wisdom
2017-03-07,bicuspid
2017-03-15,wisdom
2017-03-20,canine
2017-03-23,molar
2017-04-02,bicuspid
2017-04-22,wisdom
2017-05-07,canine
2017-05-09,canine
2017-05-11,incisor
2017-05-14,incisor
2017-05-19,canine
2017-05-23,incisor
2017-05-24,incisor
2017-06-18,incisor
2017-07-25,canine
2017-08-02,canine
2017-08-03,bicuspid
2017-08-04,canine
EOF
cat > ${REPO}/data/autumn.csv <<EOF
Date,Tooth
2017-01-05,canine
2017-01-17,wisdom
2017-01-18,canine
2017-02-01,molar
2017-02-22,bicuspid
2017-03-10,canine
2017-03-13,canine
2017-04-30,incisor
2017-05-02,canine
2017-05-10,canine
2017-05-19,bicuspid
2017-05-25,molar
2017-06-22,wisdom
2017-06-25,canine
2017-07-10,incisor
2017-07-10,wisdom
2017-07-20,incisor
2017-07-21,bicuspid
2017-08-09,canine
2017-08-16,canine
EOF
cat > ${REPO}/data/winter.csv <<EOF
Date,Tooth
2017-01-03,bicuspid
2017-01-05,incisor
2017-01-21,wisdom
2017-02-05,molar
2017-02-17,incisor
2017-02-25,bicuspid
2017-03-12,incisor
2017-03-25,molar
2017-03-26,incisor
2017-04-04,canine
2017-04-18,canine
2017-04-26,canine
2017-04-26,molar
2017-04-26,wisdom
2017-04-27,canine
2017-05-08,molar
2017-05-13,bicuspid
2017-05-14,wisdom
2017-06-17,canine
2017-07-01,incisor
2017-07-17,canine
2017-08-10,incisor
2017-08-11,bicuspid
2017-08-11,wisdom
2017-08-13,canine
EOF
${G} add data
${G} commit -m "Adding seasonal CSV data files"
${G} tag adding-data-files

# adding-scripts-for-dates-and-teeth: adding shell scripts to extract dates and teeth from data files.
