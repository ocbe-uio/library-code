# Introduction

This repository contains scripts to aid research software development.

RSE stands for Research Software Engineer, but these tools are free to use by anyone who finds them potentially useful.

# Motivation

When developing research packages, a developer might write some functions and scripts to make development easier. Such auxiliary files are not to be part of the released package. They may, however, be repurposed for another project. Therefore, it makes sense to put these tools in one place (i.e., this repository).

Moreover, having such tools in one repository makes it easier for the user to clone one repository, include it in their `$PATH` and easily execute the scripts.

# Licence, contribution and citation

All software on this repository is free and open. For details, please read the [LICENSE](https://github.com/ocbe-uio/rse-tools/blob/main/LICENSE) file.

All contributions are welcome. If you are contributing code, please open a [Pull Request](https://github.com/ocbe-uio/rse-tools/pulls) so your changes can be reviewed before incorporation. If you find a bug or would like to request a feature, please open an [Issue](https://github.com/ocbe-uio/rse-tools/issues/new).

If you use this software, please use the metadata on the [CITATION.cff](https://github.com/ocbe-uio/rse-tools/blob/main/CITATION.cff) file as a reference. The CFF format can be converted into various other formats using the [cff-converter-python](https://github.com/citation-file-format/cff-converter-python) software.

# File organization

Files that will probably work across projects are in the "general" folder. Files that were created and should probably only work within a particular project are in a folder with the project's name. Efforts to generalize the latter are very welcome.
