# METS metadata for complete beginners
This repository has materials for the a talk at at NDF 2017 by Stuart Yeates and Max Sullivan. See http://www.ndf.org.nz/2017-workshops#mets These are a series of OAIS / ISO 14721:2012 / CCSDSS 650.0-P-1.1 documents (called SIPs (Submission Information Packages) before ingestion or DIPs (Dissemination Information Packages) after export), see https://en.wikipedia.org/wiki/Open_Archival_Information_System

Note that in cases of exported DIPs, per-representation tar files have been unpacked into a directory of file(s). 

##  edmcook
This document is the NZETC TEI version of "The 'Sure to Rise' Cookery Book" (a New Zealand cultural iron) originally published to the web at http://nzetc.victoria.ac.nz/tm/scholarly/tei-EdmCook.html This is an out-of-copyright work.

This work is considered an icon on New Zealand culture, see https://en.wikipedia.org/wiki/Edmonds_Cookery_Book

### edmcook-original
This is the SIP which we created for importing into Rosetta. The script was based on XSLT and bash. 

###  edmcook-exported
This is the DIP exported from Rosetta shortly after ingest.

### edmcook-5.5
This is the DIP exported from Rosetta immediately after upgrading to 5.5.

### edmcook-5.5-metadata-only
This is the DIP exported from Rosetta immediately after upgrading to 5.5, using filters to remove all the REPS leaving only metadata


## thesis
This document is a PhD thesis "Factors Influencing Participant Satisfaction with Free/Libre and Open Source Software Projects" by Brenda Chawner https://en.wikipedia.org/wiki/Brenda_Chawner. It was originally published at http://researcharchive.vuw.ac.nz/handle/10063/1710 This is a CC licensed work.

The permissions PDF contains personal information (the signature of the author) so has been replaced with another PDF which contains only the text "This file replaces one which contained personal information."

### thesis-dspace
This is the DIP as originally exported from DSpace.

### thesis-imported
This is a SIP created from the above DSpace DIP using a script to enforce to Rosetta's ingest requirements.

### thesis-exported
This is the DIP exported from Rosetta shortly after ingest.

### thesis-5.5
This is the DIP exported from Rosetta immediately after upgrading to 5.5.

### theis-5.5-metadata-only
This is the DIP exported from Rosetta immediately after upgrading to 5.5, using filters to remove all the REPS leaving only metadata.
