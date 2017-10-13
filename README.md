# CountingVermeer
Software for the Counting Vermeer Project
This is the Software Appendix accompanying 
Counting Vermeer, C. R. Johnson, Jr., Ed., RKD Monograph, 2017
http://countingvermeer.targaryen.edition1.nl/titel-pagina

Several Mathematica programs are introduced in Chapters 4 and 5, and this folder contains the files needed to run the software (those with extension .cdf are in the "computable Data Format" and require only the free Mathematica player http://www.wolfram.com/cdf-player/). Source code appears in the .nb files, which require a full version of Mathematica software http://www.wolfram.com/mathematica/?source=nav. See chapters 4 and 5 for a brief summary of the operation of each module.

All software is written by William Sethares (University of Wisconsin and Rijksmuseum Amsterdam) and is released under an open source license -- attribution required. Attribution should be made to:

W. A. Sethares, “Automated Creation of Weave and Angle Maps” in Counting Vermeer, C. R. Johnson, Jr., Ed., RKD Monograph, 2017 and/or to
W. A. Sethares, “Computer-Assisted Manual Thread Marking” in Counting Vermeer, C. R. Johnson, Jr., Ed., RKD Monograph, 2017.

The programs are:

countingVermeer.cdf and countingVermeer.nb      main routine for calling the various modules

displayWeaveMaps.cdf and displayWeaveMaps.nb    used to display any precalculated weave maps

threadCount.cdf and threadCount25.nb            calculate weave maps from canvas x-rays 

threadMarker.cdf and threadMarker.nb            used to mark threads for semi-automated manual counting

zoomIn.cdf and zoomIn.nb                        look closely at x-rays by zooming in

align.cdf and align11.nb                        read in two weave maps and display them on the same scale

alignaAgle.nb                                   read in two angle maps and display them on the same scale
