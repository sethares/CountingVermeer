(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 10.4' *)

(*************************************************************************)
(*                                                                       *)
(*                                                                       *)
(*  This file was created under the Wolfram Enterprise licensing terms.  *)
(*                                                                       *)
(*       For additional information concerning CDF licensing see:        *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*                                                                       *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1064,         20]
NotebookDataLength[     59254,       1400]
NotebookOptionsPosition[     59684,       1391]
NotebookOutlinePosition[     60109,       1410]
CellTagsIndexPosition[     60066,       1407]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[TextData[StyleBox["Calculate weave maps from canvas x-rays ", \
"Subsection"]], "Text"],

Cell["\<\
Specify the name of the x-ray .tif file by pressing \
\[OpenCurlyDoubleQuote]load x-ray file\[CloseCurlyDoubleQuote]
horizontal mean -- enter the average of the horizontal thread count from the \
hand count
vertical mean -- enter the average of the vertical thread count from the hand \
count
block size -- do the count over squares of this size (in cm)
overlap -- how much to overlap successive squares
FFT Size -- a convenient power of 2 such as 512 or 1024
DPI -- dots per inch (resolution) of the x-ray .tif file

Once these choices have been set, press the \[OpenCurlyDoubleQuote]Calculate\
\[CloseCurlyDoubleQuote] button and sit back for a cup of coffee. The \
progress bar will show you just how large a cup you need. When the program is \
done, it will write out a data file that contains the horizontal and vertical \
weave maps and angle maps. These can be viewed using the displayWeaveMaps \
function.

calculate all four possiblities for estimating x and y frequencies\
\>", "Text"],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{
    RowBox[{"If", "[", 
     RowBox[{
      RowBox[{"newFile", "\[Equal]", "True"}], ",", 
      RowBox[{
       RowBox[{"fName", "=", 
        RowBox[{"SystemDialogInput", "[", 
         RowBox[{"\"\<FileOpen\>\"", ",", 
          RowBox[{"NotebookDirectory", "[", "]"}], ",", 
          RowBox[{
          "WindowTitle", "\[Rule]", 
           "\"\<Open an x-ray in .tif format\>\""}]}], "]"}]}], ";", 
       RowBox[{"If", "[", 
        RowBox[{
         RowBox[{
          RowBox[{"FileExtension", "[", "fName", "]"}], "\[Equal]", 
          "\"\<tif\>\""}], ",", 
         RowBox[{
          RowBox[{"imgFull", "=", 
           RowBox[{"Import", "[", "fName", "]"}]}], ";", 
          RowBox[{"disp", "=", 
           RowBox[{"ImageResize", "[", 
            RowBox[{"imgFull", ",", 
             RowBox[{"{", "300", "}"}]}], "]"}]}], ";", 
          RowBox[{"fileName", "=", 
           RowBox[{"FileBaseName", "[", "fName", "]"}]}], ";", 
          RowBox[{"fileMess", "=", "\"\<\>\""}], ";", 
          RowBox[{"newFile", "=", "False"}]}]}], "]"}], ";"}]}], 
     "\[IndentingNewLine]", "]"}], ";", "\[IndentingNewLine]", 
    RowBox[{"If", "[", 
     RowBox[{
      RowBox[{"fName", "==", "$Canceled"}], ",", 
      RowBox[{"newFile", "=", "False"}]}], "]"}], ";", "\[IndentingNewLine]", 
    
    RowBox[{"var", "=", "calc"}], ";", "\[IndentingNewLine]", 
    RowBox[{"If", "[", 
     RowBox[{
      RowBox[{
       RowBox[{"var", "\[Equal]", "True"}], "&&", 
       RowBox[{
        RowBox[{"ImageQ", "[", "imgFull", "]"}], "\[Equal]", "True"}]}], ",", 
      
      RowBox[{
       RowBox[{"dpc", "=", 
        RowBox[{"dpi", "/", "2.54"}]}], ";", 
       RowBox[{"suf", "=", 
        RowBox[{"orient", "<>", "\"\<(\>\"", "<>", 
         RowBox[{"ToString", "[", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"sizeSquares", "<", "1"}], ",", 
            RowBox[{"N", "[", "sizeSquares", "]"}], ",", "sizeSquares"}], 
           "]"}], "]"}], "<>", "\"\<-\>\"", "<>", 
         RowBox[{"ToString", "[", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"IntegerQ", "[", "overlap", "]"}], ",", "overlap", ",", 
            RowBox[{"N", "[", "overlap", "]"}]}], "]"}], "]"}]}]}], ";", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"w", ",", "h"}], "}"}], "=", 
        RowBox[{"ImageDimensions", "[", "imgFull", "]"}]}], ";", 
       RowBox[{"sizBlocks", "=", 
        RowBox[{"Floor", "[", 
         RowBox[{"sizeSquares", " ", "dpc"}], "]"}]}], ";", 
       RowBox[{"setW", "=", 
        RowBox[{"Drop", "[", 
         RowBox[{
          RowBox[{"Round", "[", 
           RowBox[{"Range", "[", 
            RowBox[{"1", ",", "w", ",", 
             RowBox[{"sizBlocks", "/", "overlap"}]}], "]"}], "]"}], ",", 
          RowBox[{"Floor", "[", 
           RowBox[{"-", "overlap"}], "]"}]}], "]"}]}], ";", 
       RowBox[{"setH", "=", 
        RowBox[{"Drop", "[", 
         RowBox[{
          RowBox[{"Round", "[", 
           RowBox[{"Range", "[", 
            RowBox[{"1", ",", "h", ",", 
             RowBox[{"sizBlocks", "/", "overlap"}]}], "]"}], "]"}], ",", 
          RowBox[{"Floor", "[", 
           RowBox[{"-", "overlap"}], "]"}]}], "]"}]}], ";", 
       RowBox[{"allPatches", "=", 
        RowBox[{"Outer", "[", 
         RowBox[{"List", ",", "setH", ",", "setW"}], "]"}]}], ";", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"imgRows", ",", "imgCols", ",", "imgPair"}], "}"}], "=", 
        RowBox[{"Dimensions", "[", "allPatches", "]"}]}], ";", 
       "\[IndentingNewLine]", 
       RowBox[{"win", "=", 
        RowBox[{"Image", "@", 
         RowBox[{"Array", "[", 
          RowBox[{
           RowBox[{
            RowBox[{
             RowBox[{"HannWindow", "[", "#1", "]"}], " ", 
             RowBox[{"HannWindow", "[", "#2", "]"}]}], "&"}], ",", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{
              RowBox[{"setW", "[", 
               RowBox[{"[", 
                RowBox[{"overlap", "+", "1"}], "]"}], "]"}], "-", " ", 
              RowBox[{"setW", "[", 
               RowBox[{"[", "1", "]"}], "]"}]}], ",", 
             RowBox[{
              RowBox[{"setH", "[", 
               RowBox[{"[", 
                RowBox[{"overlap", "+", "1"}], "]"}], "]"}], "-", " ", 
              RowBox[{"setH", "[", 
               RowBox[{"[", "1", "]"}], "]"}]}]}], "}"}], ",", 
           RowBox[{"{", 
            RowBox[{"{", 
             RowBox[{
              RowBox[{
               RowBox[{"-", "1"}], "/", "2"}], ",", 
              RowBox[{"1", "/", "2"}]}], "}"}], "}"}]}], "]"}]}]}], ";", 
       RowBox[{"allThreads", "=", 
        RowBox[{"Flatten", "[", 
         RowBox[{
          RowBox[{"Table", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"kk", "=", "ii"}], ";", 
             RowBox[{"fft2D", "[", 
              RowBox[{
               RowBox[{"getPatch", "[", 
                RowBox[{"ii", ",", "jj"}], "]"}], ",", "meanV", ",", "meanH", 
               ",", "fftSize", ",", "2", ",", "orient", ",", "False"}], 
              "]"}]}], ",", 
            RowBox[{"{", 
             RowBox[{"ii", ",", "1", ",", "imgRows", ",", "1"}], "}"}], ",", 
            RowBox[{"{", 
             RowBox[{"jj", ",", "1", ",", "imgCols", ",", "1"}], "}"}]}], 
           "]"}], ",", "1"}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"Do", "[", 
        RowBox[{
         RowBox[{
          RowBox[{"allH", "=", 
           RowBox[{"allThreads", "[", 
            RowBox[{"[", 
             RowBox[{"All", ",", "1", ",", "i"}], "]"}], "]"}]}], ";", 
          RowBox[{"allV", "=", 
           RowBox[{"allThreads", "[", 
            RowBox[{"[", 
             RowBox[{"All", ",", "2", ",", "i"}], "]"}], "]"}]}], ";", 
          RowBox[{"allAngH", "=", 
           RowBox[{"Mod", "[", 
            RowBox[{
             RowBox[{"allThreads", "[", 
              RowBox[{"[", 
               RowBox[{"All", ",", "3", ",", "i"}], "]"}], "]"}], ",", 
             "360"}], "]"}]}], ";", 
          RowBox[{"allAngV", "=", 
           RowBox[{"allThreads", "[", 
            RowBox[{"[", 
             RowBox[{"All", ",", "4", ",", "i"}], "]"}], "]"}]}], ";", 
          RowBox[{"matV", "=", 
           RowBox[{"Partition", "[", 
            RowBox[{
             RowBox[{"N", "[", 
              RowBox[{
               RowBox[{"Round", "[", 
                RowBox[{"100", " ", "allV"}], "]"}], "/", "100"}], "]"}], ",",
              "imgCols"}], "]"}]}], ";", 
          RowBox[{"angV", "=", 
           RowBox[{"Partition", "[", 
            RowBox[{
             RowBox[{"N", "[", 
              RowBox[{
               RowBox[{"Round", "[", 
                RowBox[{"100", " ", "allAngV"}], "]"}], "/", "100"}], "]"}], 
             ",", "imgCols"}], "]"}]}], ";", 
          RowBox[{"matH", "=", 
           RowBox[{"Partition", "[", 
            RowBox[{
             RowBox[{"N", "[", 
              RowBox[{
               RowBox[{"Round", "[", 
                RowBox[{"100", " ", "allH"}], "]"}], "/", "100"}], "]"}], ",",
              "imgCols"}], "]"}]}], ";", 
          RowBox[{"angH", "=", 
           RowBox[{"Partition", "[", 
            RowBox[{
             RowBox[{"N", "[", 
              RowBox[{
               RowBox[{"Round", "[", 
                RowBox[{"100", " ", "allAngH"}], "]"}], "/", "100"}], "]"}], 
             ",", "imgCols"}], "]"}]}], ";", 
          RowBox[{"fileOut", "=", 
           RowBox[{
            RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
            "\"\<threadCount\>\"", "<>", "fileName", "<>", "\"\<Calc\>\"", "<>", 
            RowBox[{"ToString", "[", "i", "]"}], "<>", "suf", "<>", 
            "\"\<).m\>\""}]}], ";", 
          RowBox[{"Save", "[", 
           RowBox[{"fileOut", ",", 
            RowBox[{"{", 
             RowBox[{
             "fileName", ",", "matH", ",", "angH", ",", "matV", ",", "angV"}],
              "}"}]}], "]"}], ";"}], ",", 
         RowBox[{"{", 
          RowBox[{"i", ",", "6"}], "}"}]}], "]"}], ";", "\[IndentingNewLine]", 
       RowBox[{"fileMess", "=", 
        RowBox[{
        "\"\<Weave map data written to file:\\n\>\"", "<>", "fileOut"}]}], 
       ";", "\[IndentingNewLine]", 
       RowBox[{"calc", "=", "False"}]}], ",", 
      RowBox[{"calc", "=", "False"}]}], "]"}], ";", "\[IndentingNewLine]", 
    RowBox[{"Column", "[", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"GraphicsRow", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"disp", ",", 
           RowBox[{"ProgressIndicator", "[", 
            RowBox[{"Dynamic", "[", 
             RowBox[{"kk", "/", "imgRows"}], "]"}], "]"}]}], "}"}], ",", 
         RowBox[{"ImageSize", "\[Rule]", "600"}]}], "]"}], ",", "fileMess"}], 
      "}"}], "]"}]}], ",", "\[IndentingNewLine]", 
   RowBox[{"Row", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"newFile", ",", "False", ",", "\"\<load x-ray file\>\""}], 
          "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"True", ",", "False"}], "}"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "20", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"meanH", ",", "10.", ",", "\"\<horizontal\\nmean\>\""}], 
          "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", " ", 
         RowBox[{"FieldSize", "\[Rule]", "5"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "20", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"meanV", ",", "12.", ",", "\"\<vertical\\nmean\>\""}], 
          "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", 
         RowBox[{"FieldSize", "\[Rule]", "5"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "20", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"orient", ",", "\"\<Linear\>\"", ",", "\"\<Filter\>\""}], 
          "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"\"\<Local\>\"", ",", "\"\<Linear\>\""}], "}"}]}], "}"}], 
       "]"}], ",", 
      RowBox[{"Spacer", "[", "52", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"calc", ",", "False", ",", "\"\<\>\""}], "}"}], ",", 
         RowBox[{
          RowBox[{"Button", "[", 
           RowBox[{"\"\<Calculate\>\"", ",", 
            RowBox[{"calc", "=", "True"}]}], "]"}], "&"}]}], "}"}], "]"}]}], 
     "}"}], "]"}], ",", 
   RowBox[{"Row", "[", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"sizeSquares", ",", 
           RowBox[{"1", "/", "2"}], ",", "\"\<block\\nsize (cm)\>\""}], "}"}],
          ",", 
         RowBox[{"{", 
          RowBox[{"1", ",", 
           RowBox[{"3", "/", "4"}], ",", 
           RowBox[{"1", "/", "2"}], ",", 
           RowBox[{"2", "/", "5"}], ",", 
           RowBox[{"1", "/", "3"}]}], "}"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"overlap", ",", "4", ",", "\"\<overlap\>\""}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"2", ",", "3", ",", "4", ",", "6", ",", "8"}], "}"}]}], 
        "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"fftSize", ",", "512", ",", "\"\<FFT size\>\""}], "}"}], 
         ",", 
         RowBox[{"{", 
          RowBox[{"512", ",", "1024"}], "}"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"dpi", ",", "600", ",", "\"\<DPI\>\""}], "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", 
         RowBox[{"FieldSize", "\[Rule]", "5"}]}], "}"}], "]"}]}], "}"}], 
    "]"}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"Style", "[", 
     RowBox[{
      RowBox[{"Dynamic", "[", "fileName", "]"}], ",", "Medium"}], "]"}]}], 
   ",", 
   RowBox[{"SaveDefinitions", "\[Rule]", "True"}], ",", 
   RowBox[{"SynchronousUpdating", "\[Rule]", "False"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Initialization", "\[Rule]", 
    RowBox[{"(", "\[IndentingNewLine]", 
     RowBox[{
      RowBox[{
       RowBox[{"calFreqP", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"x_", ",", "y_"}], "}"}], ",", "siz_"}], "]"}], ":=", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"dpc", "*", 
          RowBox[{
           RowBox[{"Norm", "[", 
            RowBox[{"{", 
             RowBox[{"y", ",", "x"}], "}"}], "]"}], "/", "siz"}]}], ",", 
         RowBox[{"90", "-", 
          RowBox[{
           RowBox[{"ArcTan", "[", 
            RowBox[{"x", ",", "y"}], "]"}], "/", "Degree"}]}]}], "}"}]}], ";",
       "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"calFreqQ", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"x_", ",", "y_"}], "}"}], ",", "siz_"}], "]"}], ":=", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"dpc", "*", 
          RowBox[{
           RowBox[{"Norm", "[", 
            RowBox[{"{", 
             RowBox[{"y", ",", "x"}], "}"}], "]"}], "/", "siz"}]}], ",", 
         RowBox[{
          RowBox[{
           RowBox[{"-", 
            RowBox[{"ArcTan", "[", 
             RowBox[{"x", ",", "y"}], "]"}]}], "/", "Degree"}], "-", "90"}]}],
         "}"}]}], ";", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"getPatch", "[", 
        RowBox[{"i_", ",", "j_"}], "]"}], ":=", 
       RowBox[{"Module", "[", 
        RowBox[{
         RowBox[{"{", "}"}], ",", 
         RowBox[{
          RowBox[{"thisInd", "=", 
           RowBox[{"allPatches", "[", 
            RowBox[{"[", 
             RowBox[{"i", ",", "j"}], "]"}], "]"}]}], ";", 
          RowBox[{"thisPatch", "=", 
           RowBox[{"ImageTake", "[", 
            RowBox[{"imgFull", ",", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"thisInd", "[", 
                RowBox[{"[", "1", "]"}], "]"}], ",", 
               RowBox[{
                RowBox[{"thisInd", "[", 
                 RowBox[{"[", "1", "]"}], "]"}], "+", "sizBlocks", "-", 
                "1"}]}], "}"}], ",", 
             RowBox[{"{", 
              RowBox[{
               RowBox[{"thisInd", "[", 
                RowBox[{"[", "2", "]"}], "]"}], ",", 
               RowBox[{
                RowBox[{"thisInd", "[", 
                 RowBox[{"[", "2", "]"}], "]"}], "+", "sizBlocks", "-", 
                "1"}]}], "}"}]}], "]"}]}]}]}], "]"}]}], ";", 
      "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"fft2D", "[", 
        RowBox[{
        "img_", ",", "hEst_", ",", "vEst_", ",", "siz_", ",", "zDom_", ",", 
         "filt_", ",", "test_"}], "]"}], ":=", 
       RowBox[{"Module", "[", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{
           RowBox[{"noH", "=", "False"}], ",", 
           RowBox[{"noV", "=", "False"}], ",", 
           RowBox[{"noD", "=", "False"}]}], "}"}], ",", "\[IndentingNewLine]", 
         RowBox[{
          RowBox[{
           RowBox[{"{", 
            RowBox[{"col", ",", "row"}], "}"}], "=", 
           RowBox[{"ImageDimensions", "@", "img"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"col", "\[NotEqual]", "row"}], ",", 
            RowBox[{
             RowBox[{"minS", "=", 
              RowBox[{"Min", "[", 
               RowBox[{"col", ",", "row"}], "]"}]}], ";", 
             RowBox[{"ImageCrop", "[", 
              RowBox[{"img", ",", "minS"}], "]"}], ";", "\[IndentingNewLine]", 
             RowBox[{"col", "=", "minS"}], ";", 
             RowBox[{"row", "=", "minS"}], ";"}]}], "]"}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"OddQ", "[", "col", "]"}], "\[Equal]", "True"}], ",", 
            RowBox[{
             RowBox[{"ImageCrop", "[", 
              RowBox[{"img", ",", 
               RowBox[{"col", "-", "1"}]}], "]"}], ";", 
             RowBox[{"col", "=", 
              RowBox[{"col", "-", "1"}]}], ";", "\[IndentingNewLine]", 
             RowBox[{"row", "=", "col"}], ";"}]}], "]"}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"padNum", "=", 
           RowBox[{
            RowBox[{"(", 
             RowBox[{"siz", "-", 
              RowBox[{"{", 
               RowBox[{"col", ",", "row"}], "}"}]}], ")"}], "/", "2"}]}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"Which", "[", 
           RowBox[{
            RowBox[{"filt", "\[Equal]", "\"\<Local\>\""}], ",", 
            RowBox[{
             RowBox[{"imOrient", "=", 
              RowBox[{"LocalAdaptiveBinarize", "[", 
               RowBox[{
                RowBox[{"ImageMultiply", "[", 
                 RowBox[{"img", ",", "win"}], "]"}], ",", 
                RowBox[{"Round", "[", 
                 RowBox[{"12", "*", 
                  RowBox[{"col", "/", "dpc"}]}], "]"}]}], "]"}]}], ";"}], ",",
             "\[IndentingNewLine]", 
            RowBox[{"filt", "\[Equal]", "\"\<Linear\>\""}], ",", 
            RowBox[{"imOrient", "=", 
             RowBox[{"ImageMultiply", "[", 
              RowBox[{"img", ",", "win"}], "]"}]}]}], "]"}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"im", "=", 
           RowBox[{"ArrayPad", "[", 
            RowBox[{
             RowBox[{"ImageData", "[", "imOrient", "]"}], ",", "padNum"}], 
            "]"}]}], ";", "\[IndentingNewLine]", 
          RowBox[{"xf", "=", 
           RowBox[{"Fourier", "[", 
            RowBox[{
             RowBox[{"im", "-", 
              RowBox[{"Mean", "[", 
               RowBox[{"Mean", "[", "im", "]"}], "]"}]}], ",", 
             RowBox[{"FourierParameters", "\[Rule]", 
              RowBox[{"{", 
               RowBox[{"1", ",", 
                RowBox[{"-", "1"}]}], "}"}]}]}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"cent1", ",", "cent2"}], "}"}], "=", 
           RowBox[{"Ceiling", "[", 
            RowBox[{
             RowBox[{"Dimensions", "[", "xf", "]"}], "/", "2"}], "]"}]}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"xfAbs", "=", 
           RowBox[{"Abs", "[", 
            RowBox[{"RotateLeft", "[", 
             RowBox[{"xf", ",", 
              RowBox[{"{", 
               RowBox[{
                RowBox[{"cent1", "+", "1"}], ",", 
                RowBox[{"cent2", "+", "1"}]}], "}"}]}], "]"}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"xfAbs", "[", 
            RowBox[{"[", 
             RowBox[{
              RowBox[{
               RowBox[{"cent1", "-", "8"}], ";;", 
               RowBox[{"cent1", "+", "8"}]}], ",", 
              RowBox[{
               RowBox[{"cent2", "-", "8"}], ";;", 
               RowBox[{"cent2", "+", "8"}]}]}], "]"}], "]"}], "=", "0"}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"handV", "=", 
           RowBox[{"Round", "[", 
            RowBox[{"vEst", "*", 
             RowBox[{"siz", "/", "dpc"}]}], "]"}]}], ";", 
          RowBox[{"handH", "=", 
           RowBox[{"Round", "[", 
            RowBox[{"hEst", "*", 
             RowBox[{"siz", "/", "dpc"}]}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"wid", "=", 
           RowBox[{"Round", "[", 
            RowBox[{"zDom", "*", 
             RowBox[{"siz", "/", "col"}]}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"lowSX", ",", "highSX", ",", "lowEX", ",", "highEX"}], 
            "}"}], "=", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"cent1", "-", "wid"}], ",", 
             RowBox[{"cent1", "+", "wid"}], ",", 
             RowBox[{"cent1", "-", "wid", "+", "handH"}], ",", 
             RowBox[{"cent1", "+", "wid", "+", "handH"}]}], "}"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"lowSY", ",", "highSY", ",", "lowEY", ",", "highEY"}], 
            "}"}], "=", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"cent2", "-", "wid", "-", "handV"}], ",", 
             RowBox[{"cent2", "+", "wid", "-", "handV"}], ",", 
             RowBox[{"cent2", "-", "wid"}], ",", 
             RowBox[{"cent2", "+", "wid"}]}], "}"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"lowSD", ",", "highSD", ",", "lowED", ",", "highED"}], 
            "}"}], "=", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"cent2", "-", "wid", "-", 
              RowBox[{"Round", "[", 
               RowBox[{"handV", "/", "2"}], "]"}]}], ",", 
             RowBox[{"cent2", "+", "wid", "-", 
              RowBox[{"Round", "[", 
               RowBox[{"handV", "/", "2"}], "]"}]}], ",", 
             RowBox[{"cent2", "-", "wid", "+", 
              RowBox[{"Round", "[", 
               RowBox[{"handH", "/", "2"}], "]"}]}], ",", 
             RowBox[{"cent2", "+", "wid", "+", 
              RowBox[{"Round", "[", 
               RowBox[{"handH", "/", "2"}], "]"}]}]}], "}"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"lowSC", ",", "highSC", ",", "lowEC", ",", "highEC"}], 
            "}"}], "=", 
           RowBox[{"{", 
            RowBox[{
             RowBox[{"cent2", "-", "wid", "-", 
              RowBox[{"Round", "[", 
               RowBox[{"handV", "/", "2"}], "]"}]}], ",", 
             RowBox[{"cent2", "+", "wid", "-", 
              RowBox[{"Round", "[", 
               RowBox[{"handV", "/", "2"}], "]"}]}], ",", 
             RowBox[{"cent2", "-", "wid", "-", 
              RowBox[{"Round", "[", 
               RowBox[{"handH", "/", "2"}], "]"}]}], ",", 
             RowBox[{"cent2", "+", "wid", "-", 
              RowBox[{"Round", "[", 
               RowBox[{"handH", "/", "2"}], "]"}]}]}], "}"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"xRegion", "=", 
           RowBox[{"xfAbs", "[", 
            RowBox[{"[", 
             RowBox[{
              RowBox[{"lowSX", ";;", "highSX"}], ",", 
              RowBox[{"lowEX", ";;", "highEX"}]}], "]"}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"yRegion", "=", 
           RowBox[{"xfAbs", "[", 
            RowBox[{"[", 
             RowBox[{
              RowBox[{"lowSY", ";;", "highSY"}], ",", 
              RowBox[{"lowEY", ";;", "highEY"}]}], "]"}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"dRegion", "=", 
           RowBox[{"xfAbs", "[", 
            RowBox[{"[", 
             RowBox[{
              RowBox[{"lowSD", ";;", "highSD"}], ",", 
              RowBox[{"lowED", ";;", "highED"}]}], "]"}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"cRegion", "=", 
           RowBox[{"xfAbs", "[", 
            RowBox[{"[", 
             RowBox[{
              RowBox[{"lowSC", ";;", "highSC"}], ",", 
              RowBox[{"lowEC", ";;", "highEC"}]}], "]"}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"maxX", "=", 
           RowBox[{"Max", "[", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{"xRegion", "-", "1"}], ")"}], "*", 
             RowBox[{"MaxDetect", "[", "xRegion", "]"}], "*", 
             RowBox[{"ArrayPad", "[", 
              RowBox[{
               RowBox[{"ConstantArray", "[", 
                RowBox[{"1", ",", 
                 RowBox[{
                  RowBox[{"Dimensions", "[", "xRegion", "]"}], "-", "2"}]}], 
                "]"}], ",", "1"}], "]"}]}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"maxX", "\[LessEqual]", "0"}], ",", 
            RowBox[{
             RowBox[{"posX", "=", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0"}], "}"}]}], ";"}], ",", 
            RowBox[{
             RowBox[{"posX", "=", 
              RowBox[{"First", "@", 
               RowBox[{"Position", "[", 
                RowBox[{"xRegion", ",", 
                 RowBox[{"maxX", "+", "1"}]}], "]"}]}]}], ";"}]}], "]"}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"maxY", "=", 
           RowBox[{"Max", "[", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{"yRegion", "-", "1"}], ")"}], "*", 
             RowBox[{"MaxDetect", "[", "yRegion", "]"}], "*", 
             RowBox[{"ArrayPad", "[", 
              RowBox[{
               RowBox[{"ConstantArray", "[", 
                RowBox[{"1", ",", 
                 RowBox[{
                  RowBox[{"Dimensions", "[", "yRegion", "]"}], "-", "2"}]}], 
                "]"}], ",", "1"}], "]"}]}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"maxY", "\[LessEqual]", "0"}], ",", 
            RowBox[{
             RowBox[{"posY", "=", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0"}], "}"}]}], ";"}], ",", 
            RowBox[{
             RowBox[{"posY", "=", 
              RowBox[{"First", "@", 
               RowBox[{"Position", "[", 
                RowBox[{"yRegion", ",", 
                 RowBox[{"maxY", "+", "1"}]}], "]"}]}]}], ";"}]}], "]"}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"maxD", "=", 
           RowBox[{"Max", "[", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{"dRegion", "-", "1"}], ")"}], "*", 
             RowBox[{"MaxDetect", "[", "dRegion", "]"}], "*", 
             RowBox[{"ArrayPad", "[", 
              RowBox[{
               RowBox[{"ConstantArray", "[", 
                RowBox[{"1", ",", 
                 RowBox[{
                  RowBox[{"Dimensions", "[", "dRegion", "]"}], "-", "2"}]}], 
                "]"}], ",", "1"}], "]"}]}], "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"maxD", "\[LessEqual]", "0"}], ",", 
            RowBox[{
             RowBox[{"posD", "=", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0"}], "}"}]}], ";"}], ",", 
            RowBox[{
             RowBox[{"posD", "=", 
              RowBox[{"First", "@", 
               RowBox[{"Position", "[", 
                RowBox[{"dRegion", ",", 
                 RowBox[{"maxD", "+", "1"}]}], "]"}]}]}], ";"}]}], "]"}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"maxC", "=", 
           RowBox[{"Max", "[", 
            RowBox[{
             RowBox[{"(", 
              RowBox[{"cRegion", "-", "1"}], ")"}], "*", 
             RowBox[{"MaxDetect", "[", "cRegion", "]"}], "*", 
             RowBox[{"ArrayPad", "[", 
              RowBox[{
               RowBox[{"ConstantArray", "[", 
                RowBox[{"1", ",", 
                 RowBox[{
                  RowBox[{"Dimensions", "[", "cRegion", "]"}], "-", "2"}]}], 
                "]"}], ",", "1"}], "]"}]}], "]"}]}], ";", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"maxC", "\[LessEqual]", "0"}], ",", 
            RowBox[{
             RowBox[{"posC", "=", 
              RowBox[{"{", 
               RowBox[{"0", ",", "0"}], "}"}]}], ";"}], ",", 
            RowBox[{
             RowBox[{"posC", "=", 
              RowBox[{"First", "@", 
               RowBox[{"Position", "[", 
                RowBox[{"cRegion", ",", 
                 RowBox[{"maxC", "+", "1"}]}], "]"}]}]}], ";"}]}], "]"}], ";",
           "\[IndentingNewLine]", 
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{"test", "\[Equal]", "True"}], ",", 
            RowBox[{
             RowBox[{"filterMask", "=", 
              RowBox[{"ConstantArray", "[", 
               RowBox[{"0", ",", 
                RowBox[{"Dimensions", "[", "xfAbs", "]"}]}], "]"}]}], ";", 
             "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"filterMask", "[", 
               RowBox[{"[", 
                RowBox[{
                 RowBox[{"lowSX", ";;", "highSX"}], ",", 
                 RowBox[{"lowEX", ";;", "highEX"}]}], "]"}], "]"}], "=", 
              "1.0"}], ";", "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"filterMask", "[", 
               RowBox[{"[", 
                RowBox[{
                 RowBox[{"lowSY", ";;", "highSY"}], ",", 
                 RowBox[{"lowEY", ";;", "highEY"}]}], "]"}], "]"}], "=", 
              "1.0"}], ";", "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"filterMask", "[", 
               RowBox[{"[", 
                RowBox[{
                 RowBox[{"lowSD", ";;", "highSD"}], ",", 
                 RowBox[{"lowED", ";;", "highED"}]}], "]"}], "]"}], "=", 
              "1.0"}], ";", "\[IndentingNewLine]", 
             RowBox[{
              RowBox[{"filterMask", "[", 
               RowBox[{"[", 
                RowBox[{
                 RowBox[{"lowSC", ";;", "highSC"}], ",", 
                 RowBox[{"lowEC", ";;", "highEC"}]}], "]"}], "]"}], "=", 
              "1.0"}], ";", 
             RowBox[{"fft2Dimage", "=", 
              RowBox[{"ColorCombine", "[", 
               RowBox[{
                RowBox[{"{", 
                 RowBox[{
                  RowBox[{"ImageAdjust", "[", 
                   RowBox[{"ColorNegate", "@", 
                    RowBox[{"Image", "[", "xfAbs", "]"}]}], "]"}], ",", 
                  RowBox[{"Image", "[", "filterMask", "]"}], ",", 
                  RowBox[{"Image", "[", "filterMask", "]"}]}], "}"}], ",", 
                "\"\<LUV\>\""}], "]"}]}], ";"}]}], "]"}], ";", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"yX", ",", "xX"}], "}"}], "=", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"lowSX", ",", "lowEX"}], "}"}], "+", "posX", "-", "1.0", 
            "-", 
            RowBox[{"{", 
             RowBox[{"cent1", ",", "cent2"}], "}"}]}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"yY", ",", "xY"}], "}"}], "=", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"lowSY", ",", "lowEY"}], "}"}], "+", "posY", "-", "1.0", 
            "-", 
            RowBox[{"{", 
             RowBox[{"cent1", ",", "cent2"}], "}"}]}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"yD", ",", "xD"}], "}"}], "=", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"lowSD", ",", "lowED"}], "}"}], "+", "posD", "-", "1.0", 
            "-", 
            RowBox[{"{", 
             RowBox[{"cent1", ",", "cent2"}], "}"}]}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"yC", ",", "xC"}], "}"}], "=", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"lowSC", ",", "lowEC"}], "}"}], "+", "posC", "-", "1.0", 
            "-", 
            RowBox[{"{", 
             RowBox[{"cent1", ",", "cent2"}], "}"}]}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"p1", "=", 
           RowBox[{"{", 
            RowBox[{"yX", ",", "xX"}], "}"}]}], ";", 
          RowBox[{"p2", "=", 
           RowBox[{
            RowBox[{"2", " ", 
             RowBox[{"{", 
              RowBox[{"yD", ",", "xD"}], "}"}]}], "-", 
            RowBox[{"{", 
             RowBox[{"yY", ",", "xY"}], "}"}]}]}], ";", 
          RowBox[{"p3", "=", 
           RowBox[{
            RowBox[{
             RowBox[{"-", "2"}], " ", 
             RowBox[{"{", 
              RowBox[{"yC", ",", "xC"}], "}"}]}], "+", 
            RowBox[{"{", 
             RowBox[{"yY", ",", "xY"}], "}"}]}]}], ";", 
          RowBox[{"p4", "=", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"yD", ",", "xD"}], "}"}], "-", 
            RowBox[{"{", 
             RowBox[{"yC", ",", "xC"}], "}"}]}]}], ";", "\[IndentingNewLine]", 
          RowBox[{"q1", "=", 
           RowBox[{"{", 
            RowBox[{"yY", ",", "xY"}], "}"}]}], ";", 
          RowBox[{"q2", "=", 
           RowBox[{
            RowBox[{"2", " ", 
             RowBox[{"{", 
              RowBox[{"yD", ",", "xD"}], "}"}]}], "-", 
            RowBox[{"{", 
             RowBox[{"yX", ",", "xX"}], "}"}]}]}], ";", 
          RowBox[{"q3", "=", 
           RowBox[{
            RowBox[{"2", " ", 
             RowBox[{"{", 
              RowBox[{"yC", ",", "xC"}], "}"}]}], "+", 
            RowBox[{"{", 
             RowBox[{"yX", ",", "xX"}], "}"}]}]}], ";", 
          RowBox[{"q4", "=", 
           RowBox[{
            RowBox[{"{", 
             RowBox[{"yC", ",", "xC"}], "}"}], "+", 
            RowBox[{"{", 
             RowBox[{"yD", ",", "xD"}], "}"}]}]}], ";", "\[IndentingNewLine]", 
          RowBox[{"allYs", "=", 
           RowBox[{
            RowBox[{
             RowBox[{"calFreqP", "[", 
              RowBox[{"#", ",", "siz"}], "]"}], "&"}], "/@", 
            RowBox[{"{", 
             RowBox[{"p1", ",", "p2", ",", "p3", ",", "p4", ",", 
              RowBox[{"Median", "[", 
               RowBox[{"{", 
                RowBox[{"p1", ",", "p2", ",", "p3"}], "}"}], "]"}], ",", 
              RowBox[{"Median", "[", 
               RowBox[{"{", 
                RowBox[{"p1", ",", "p2", ",", "p3", ",", "p4"}], "}"}], 
               "]"}]}], "}"}]}]}], ";", "\[IndentingNewLine]", 
          RowBox[{"allXs", "=", 
           RowBox[{
            RowBox[{
             RowBox[{"calFreqQ", "[", 
              RowBox[{"#", ",", "siz"}], "]"}], "&"}], "/@", 
            RowBox[{"{", 
             RowBox[{"q1", ",", "q2", ",", "q3", ",", "q4", ",", 
              RowBox[{"Median", "[", 
               RowBox[{"{", 
                RowBox[{"q1", ",", "q2", ",", "q3"}], "}"}], "]"}], ",", 
              RowBox[{"Median", "[", 
               RowBox[{"{", 
                RowBox[{"q1", ",", "q2", ",", "q3", ",", "q4"}], "}"}], 
               "]"}]}], "}"}]}]}], ";", "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"countY", ",", "argY"}], "}"}], "=", 
           RowBox[{"Transpose", "[", "allYs", "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{
           RowBox[{"{", 
            RowBox[{"countX", ",", "argX"}], "}"}], "=", 
           RowBox[{"Transpose", "[", "allXs", "]"}]}], ";", 
          "\[IndentingNewLine]", 
          RowBox[{"{", 
           RowBox[{"countX", ",", "countY", ",", "argX", ",", "argY"}], 
           "}"}]}]}], "\[IndentingNewLine]", "]"}]}], ";", 
      "\[IndentingNewLine]", 
      RowBox[{"disp", "=", "\"\<please load an x-ray file\>\""}], ";", 
      RowBox[{"fileMess", "=", "\"\<\>\""}], ";"}], ")"}]}]}], "]"}]], "Input"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`calc$$ = False, $CellContext`dpi$$ = 
    600, $CellContext`fftSize$$ = 512, $CellContext`meanH$$ = 
    10., $CellContext`meanV$$ = 12., $CellContext`newFile$$ = 
    False, $CellContext`orient$$ = "Linear", $CellContext`overlap$$ = 
    4, $CellContext`sizeSquares$$ = Rational[1, 2], Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`newFile$$], False, "load x-ray file"}, {
      True, False}}, {{
       Hold[$CellContext`meanH$$], 10., "horizontal\nmean"}}, {{
       Hold[$CellContext`meanV$$], 12., "vertical\nmean"}}, {{
       Hold[$CellContext`orient$$], "Linear", "Filter"}, {
      "Local", "Linear"}}, {{
       Hold[$CellContext`calc$$], False, ""}, 
      Dynamic[Button["Calculate", $CellContext`calc$$ = True]& ]}, {
      Hold[
       Row[{
         Manipulate`Place[1], 
         Spacer[20], 
         Manipulate`Place[2], 
         Spacer[20], 
         Manipulate`Place[3], 
         Spacer[20], 
         Manipulate`Place[4], 
         Spacer[52], 
         Manipulate`Place[5]}]], Manipulate`Dump`ThisIsNotAControl}, {{
       Hold[$CellContext`sizeSquares$$], 
       Rational[1, 2], "block\nsize (cm)"}, {1, 
       Rational[3, 4], 
       Rational[1, 2], 
       Rational[2, 5], 
       Rational[1, 3]}}, {{
       Hold[$CellContext`overlap$$], 4, "overlap"}, {2, 3, 4, 6, 8}}, {{
       Hold[$CellContext`fftSize$$], 512, "FFT size"}, {512, 1024}}, {{
       Hold[$CellContext`dpi$$], 600, "DPI"}}, {
      Hold[
       Row[{
         Manipulate`Place[6], 
         Spacer[10], 
         Manipulate`Place[7], 
         Spacer[10], 
         Manipulate`Place[8], 
         Spacer[10], 
         Manipulate`Place[9]}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {600., {161.634033203125, 167.365966796875}}, 
    Typeset`update$$ = 0, Typeset`initDone$$, Typeset`skipInitDone$$ = 
    False, $CellContext`newFile$965$$ = False, $CellContext`orient$966$$ = 
    False, $CellContext`sizeSquares$967$$ = 0, $CellContext`overlap$968$$ = 
    0, $CellContext`fftSize$969$$ = False}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`calc$$ = False, $CellContext`dpi$$ = 
        600, $CellContext`fftSize$$ = 512, $CellContext`meanH$$ = 
        10., $CellContext`meanV$$ = 12., $CellContext`newFile$$ = 
        False, $CellContext`orient$$ = "Linear", $CellContext`overlap$$ = 
        4, $CellContext`sizeSquares$$ = Rational[1, 2]}, 
      "ControllerVariables" :> {
        Hold[$CellContext`newFile$$, $CellContext`newFile$965$$, False], 
        Hold[$CellContext`orient$$, $CellContext`orient$966$$, False], 
        Hold[$CellContext`sizeSquares$$, $CellContext`sizeSquares$967$$, 0], 
        Hold[$CellContext`overlap$$, $CellContext`overlap$968$$, 0], 
        Hold[$CellContext`fftSize$$, $CellContext`fftSize$969$$, False]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, 
      "Body" :> (
       If[$CellContext`newFile$$ == 
         True, $CellContext`fName = SystemDialogInput["FileOpen", 
            NotebookDirectory[], WindowTitle -> 
            "Open an x-ray in .tif format"]; 
         If[FileExtension[$CellContext`fName] == 
           "tif", $CellContext`imgFull = 
            Import[$CellContext`fName]; $CellContext`disp = 
            ImageResize[$CellContext`imgFull, {300}]; $CellContext`fileName = 
            FileBaseName[$CellContext`fName]; $CellContext`fileMess = 
            ""; $CellContext`newFile$$ = False]; Null]; 
       If[$CellContext`fName == $Canceled, $CellContext`newFile$$ = 
         False]; $CellContext`var = $CellContext`calc$$; If[
         And[$CellContext`var == True, ImageQ[$CellContext`imgFull] == 
          True], $CellContext`dpc = $CellContext`dpi$$/2.54; $CellContext`suf = 
          StringJoin[$CellContext`orient$$, "(", 
            ToString[
             If[$CellContext`sizeSquares$$ < 1, 
              N[$CellContext`sizeSquares$$], $CellContext`sizeSquares$$]], 
            "-", 
            ToString[
             If[
              IntegerQ[$CellContext`overlap$$], $CellContext`overlap$$, 
              N[$CellContext`overlap$$]]]]; {$CellContext`w, $CellContext`h} = 
          ImageDimensions[$CellContext`imgFull]; $CellContext`sizBlocks = 
          Floor[$CellContext`sizeSquares$$ $CellContext`dpc]; \
$CellContext`setW = Drop[
            Round[
             Range[
             1, $CellContext`w, \
$CellContext`sizBlocks/$CellContext`overlap$$]], 
            Floor[-$CellContext`overlap$$]]; $CellContext`setH = Drop[
            Round[
             Range[
             1, $CellContext`h, \
$CellContext`sizBlocks/$CellContext`overlap$$]], 
            Floor[-$CellContext`overlap$$]]; $CellContext`allPatches = 
          Outer[List, $CellContext`setH, $CellContext`setW]; \
{$CellContext`imgRows, $CellContext`imgCols, $CellContext`imgPair} = 
          Dimensions[$CellContext`allPatches]; $CellContext`win = Image[
            Array[
            HannWindow[#] HannWindow[#2]& , {
             Part[$CellContext`setW, $CellContext`overlap$$ + 1] - 
              Part[$CellContext`setW, 1], 
              Part[$CellContext`setH, $CellContext`overlap$$ + 1] - 
              Part[$CellContext`setH, 1]}, {{(-1)/2, 1/
               2}}]]; $CellContext`allThreads = Flatten[
            Table[$CellContext`kk = $CellContext`ii; $CellContext`fft2D[
               $CellContext`getPatch[$CellContext`ii, $CellContext`jj], \
$CellContext`meanV$$, $CellContext`meanH$$, $CellContext`fftSize$$, 
               2, $CellContext`orient$$, False], {$CellContext`ii, 
              1, $CellContext`imgRows, 1}, {$CellContext`jj, 
              1, $CellContext`imgCols, 1}], 1]; 
         Do[$CellContext`allH = 
            Part[$CellContext`allThreads, All, 
              1, $CellContext`i]; $CellContext`allV = 
            Part[$CellContext`allThreads, All, 
              2, $CellContext`i]; $CellContext`allAngH = Mod[
              Part[$CellContext`allThreads, All, 3, $CellContext`i], 
              360]; $CellContext`allAngV = 
            Part[$CellContext`allThreads, All, 
              4, $CellContext`i]; $CellContext`matV = Partition[
              N[
              Round[100 $CellContext`allV]/
               100], $CellContext`imgCols]; $CellContext`angV = Partition[
              N[
              Round[100 $CellContext`allAngV]/
               100], $CellContext`imgCols]; $CellContext`matH = Partition[
              N[
              Round[100 $CellContext`allH]/
               100], $CellContext`imgCols]; $CellContext`angH = Partition[
              N[
              Round[100 $CellContext`allAngH]/
               100], $CellContext`imgCols]; $CellContext`fileOut = 
            StringJoin[
              NotebookDirectory[], "threadCount", $CellContext`fileName, 
              "Calc", 
              ToString[$CellContext`i], $CellContext`suf, ").m"]; 
           Save[$CellContext`fileOut, {$CellContext`fileName, \
$CellContext`matH, $CellContext`angH, $CellContext`matV, $CellContext`angV}]; 
           Null, {$CellContext`i, 6}]; $CellContext`fileMess = 
          StringJoin[
           "Weave map data written to file:\n", $CellContext`fileOut]; \
$CellContext`calc$$ = False, $CellContext`calc$$ = False]; Column[{
          GraphicsRow[{$CellContext`disp, 
            ProgressIndicator[
             Dynamic[$CellContext`kk/$CellContext`imgRows]]}, ImageSize -> 
           600], $CellContext`fileMess}]), 
      "Specifications" :> {{{$CellContext`newFile$$, False, 
          "load x-ray file"}, {True, False}, ControlPlacement -> 
         1}, {{$CellContext`meanH$$, 10., "horizontal\nmean"}, ControlType -> 
         InputField, FieldSize -> 5, ControlPlacement -> 
         2}, {{$CellContext`meanV$$, 12., "vertical\nmean"}, ControlType -> 
         InputField, FieldSize -> 5, ControlPlacement -> 
         3}, {{$CellContext`orient$$, "Linear", "Filter"}, {
         "Local", "Linear"}, ControlPlacement -> 
         4}, {{$CellContext`calc$$, False, ""}, 
         Dynamic[Button["Calculate", $CellContext`calc$$ = True]& ], 
         ControlPlacement -> 5}, 
        Row[{
          Manipulate`Place[1], 
          Spacer[20], 
          Manipulate`Place[2], 
          Spacer[20], 
          Manipulate`Place[3], 
          Spacer[20], 
          Manipulate`Place[4], 
          Spacer[52], 
          Manipulate`Place[5]}], {{$CellContext`sizeSquares$$, 
          Rational[1, 2], "block\nsize (cm)"}, {1, 
          Rational[3, 4], 
          Rational[1, 2], 
          Rational[2, 5], 
          Rational[1, 3]}, ControlPlacement -> 
         6}, {{$CellContext`overlap$$, 4, "overlap"}, {2, 3, 4, 6, 8}, 
         ControlPlacement -> 7}, {{$CellContext`fftSize$$, 512, "FFT size"}, {
         512, 1024}, ControlPlacement -> 
         8}, {{$CellContext`dpi$$, 600, "DPI"}, ControlType -> InputField, 
         FieldSize -> 5, ControlPlacement -> 9}, 
        Row[{
          Manipulate`Place[6], 
          Spacer[10], 
          Manipulate`Place[7], 
          Spacer[10], 
          Manipulate`Place[8], 
          Spacer[10], 
          Manipulate`Place[9]}]}, "Options" :> {FrameLabel -> Style[
          Dynamic[$CellContext`fileName], Medium], SynchronousUpdating -> 
        False}, "DefaultOptions" :> {}],
     ImageSizeCache->{645., {239., 244.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({{$CellContext`disp = 
         "please load an x-ray file", $CellContext`fileMess = 
         "", $CellContext`var = False, $CellContext`fft2D[
           Pattern[$CellContext`img, 
            Blank[]], 
           Pattern[$CellContext`hEst, 
            Blank[]], 
           Pattern[$CellContext`vEst, 
            Blank[]], 
           Pattern[$CellContext`siz, 
            Blank[]], 
           Pattern[$CellContext`zDom, 
            Blank[]], 
           Pattern[$CellContext`filt, 
            Blank[]], 
           Pattern[$CellContext`test, 
            Blank[]]] := 
         Module[{$CellContext`noH = False, $CellContext`noV = 
            False, $CellContext`noD = 
            False}, {$CellContext`col, $CellContext`row} = 
            ImageDimensions[$CellContext`img]; 
           If[$CellContext`col != $CellContext`row, $CellContext`minS = 
              Min[$CellContext`col, $CellContext`row]; 
             ImageCrop[$CellContext`img, $CellContext`minS]; $CellContext`col = \
$CellContext`minS; $CellContext`row = $CellContext`minS; Null]; 
           If[OddQ[$CellContext`col] == True, 
             ImageCrop[$CellContext`img, $CellContext`col - 
               1]; $CellContext`col = $CellContext`col - 
               1; $CellContext`row = $CellContext`col; 
             Null]; $CellContext`padNum = ($CellContext`siz - \
{$CellContext`col, $CellContext`row})/2; 
           Which[$CellContext`filt == 
             "Local", $CellContext`imOrient = LocalAdaptiveBinarize[
                ImageMultiply[$CellContext`img, $CellContext`win], 
                Round[12 ($CellContext`col/$CellContext`dpc)]]; 
             Null, $CellContext`filt == "Linear", $CellContext`imOrient = 
             ImageMultiply[$CellContext`img, $CellContext`win]]; \
$CellContext`im = ArrayPad[
              
              ImageData[$CellContext`imOrient], $CellContext`padNum]; \
$CellContext`xf = Fourier[$CellContext`im - Mean[
               Mean[$CellContext`im]], 
              FourierParameters -> {
               1, -1}]; {$CellContext`cent1, $CellContext`cent2} = 
            Ceiling[Dimensions[$CellContext`xf]/2]; $CellContext`xfAbs = Abs[
              
              RotateLeft[$CellContext`xf, {$CellContext`cent1 + 
                1, $CellContext`cent2 + 1}]]; Part[$CellContext`xfAbs, 
              Span[$CellContext`cent1 - 8, $CellContext`cent1 + 8], 
              Span[$CellContext`cent2 - 8, $CellContext`cent2 + 8]] = 
            0; $CellContext`handV = 
            Round[$CellContext`vEst ($CellContext`siz/$CellContext`dpc)]; \
$CellContext`handH = 
            Round[$CellContext`hEst ($CellContext`siz/$CellContext`dpc)]; \
$CellContext`wid = 
            Round[$CellContext`zDom ($CellContext`siz/$CellContext`col)]; \
{$CellContext`lowSX, $CellContext`highSX, $CellContext`lowEX, \
$CellContext`highEX} = {$CellContext`cent1 - $CellContext`wid, \
$CellContext`cent1 + $CellContext`wid, $CellContext`cent1 - $CellContext`wid + \
$CellContext`handH, $CellContext`cent1 + $CellContext`wid + \
$CellContext`handH}; {$CellContext`lowSY, $CellContext`highSY, \
$CellContext`lowEY, $CellContext`highEY} = {$CellContext`cent2 - \
$CellContext`wid - $CellContext`handV, $CellContext`cent2 + $CellContext`wid - \
$CellContext`handV, $CellContext`cent2 - $CellContext`wid, $CellContext`cent2 + \
$CellContext`wid}; {$CellContext`lowSD, $CellContext`highSD, \
$CellContext`lowED, $CellContext`highED} = {$CellContext`cent2 - \
$CellContext`wid - 
              Round[$CellContext`handV/
               2], $CellContext`cent2 + $CellContext`wid - 
              Round[$CellContext`handV/
               2], $CellContext`cent2 - $CellContext`wid + 
              Round[$CellContext`handH/
                2], $CellContext`cent2 + $CellContext`wid + 
              Round[$CellContext`handH/
                2]}; {$CellContext`lowSC, $CellContext`highSC, \
$CellContext`lowEC, $CellContext`highEC} = {$CellContext`cent2 - \
$CellContext`wid - 
              Round[$CellContext`handV/
               2], $CellContext`cent2 + $CellContext`wid - 
              Round[$CellContext`handV/
               2], $CellContext`cent2 - $CellContext`wid - 
              Round[$CellContext`handH/
               2], $CellContext`cent2 + $CellContext`wid - 
              Round[$CellContext`handH/2]}; $CellContext`xRegion = 
            Part[$CellContext`xfAbs, 
              Span[$CellContext`lowSX, $CellContext`highSX], 
              
              Span[$CellContext`lowEX, $CellContext`highEX]]; \
$CellContext`yRegion = Part[$CellContext`xfAbs, 
              Span[$CellContext`lowSY, $CellContext`highSY], 
              
              Span[$CellContext`lowEY, $CellContext`highEY]]; \
$CellContext`dRegion = Part[$CellContext`xfAbs, 
              Span[$CellContext`lowSD, $CellContext`highSD], 
              
              Span[$CellContext`lowED, $CellContext`highED]]; \
$CellContext`cRegion = Part[$CellContext`xfAbs, 
              Span[$CellContext`lowSC, $CellContext`highSC], 
              
              Span[$CellContext`lowEC, $CellContext`highEC]]; \
$CellContext`maxX = 
            Max[($CellContext`xRegion - 1) MaxDetect[$CellContext`xRegion] 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`xRegion] - 2], 1]]; 
           If[$CellContext`maxX <= 0, $CellContext`posX = {0, 0}; 
             Null, $CellContext`posX = First[
                Position[$CellContext`xRegion, $CellContext`maxX + 1]]; 
             Null]; $CellContext`maxY = 
            Max[($CellContext`yRegion - 1) MaxDetect[$CellContext`yRegion] 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`yRegion] - 2], 1]]; 
           If[$CellContext`maxY <= 0, $CellContext`posY = {0, 0}; 
             Null, $CellContext`posY = First[
                Position[$CellContext`yRegion, $CellContext`maxY + 1]]; 
             Null]; $CellContext`maxD = 
            Max[($CellContext`dRegion - 1) MaxDetect[$CellContext`dRegion] 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`dRegion] - 2], 1]]; 
           If[$CellContext`maxD <= 0, $CellContext`posD = {0, 0}; 
             Null, $CellContext`posD = First[
                Position[$CellContext`dRegion, $CellContext`maxD + 1]]; 
             Null]; $CellContext`maxC = 
            Max[($CellContext`cRegion - 1) MaxDetect[$CellContext`cRegion] 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`cRegion] - 2], 1]]; 
           If[$CellContext`maxC <= 0, $CellContext`posC = {0, 0}; 
             Null, $CellContext`posC = First[
                Position[$CellContext`cRegion, $CellContext`maxC + 1]]; Null]; 
           If[$CellContext`test == 
             True, $CellContext`filterMask = ConstantArray[0, 
                Dimensions[$CellContext`xfAbs]]; Part[$CellContext`filterMask, 
                Span[$CellContext`lowSX, $CellContext`highSX], 
                Span[$CellContext`lowEX, $CellContext`highEX]] = 1.; 
             Part[$CellContext`filterMask, 
                Span[$CellContext`lowSY, $CellContext`highSY], 
                Span[$CellContext`lowEY, $CellContext`highEY]] = 1.; 
             Part[$CellContext`filterMask, 
                Span[$CellContext`lowSD, $CellContext`highSD], 
                Span[$CellContext`lowED, $CellContext`highED]] = 1.; 
             Part[$CellContext`filterMask, 
                Span[$CellContext`lowSC, $CellContext`highSC], 
                Span[$CellContext`lowEC, $CellContext`highEC]] = 
              1.; $CellContext`fft2Dimage = ColorCombine[{
                 ImageAdjust[
                  ColorNegate[
                   Image[$CellContext`xfAbs]]], 
                 Image[$CellContext`filterMask], 
                 Image[$CellContext`filterMask]}, "LUV"]; 
             Null]; {$CellContext`yX, $CellContext`xX} = {$CellContext`lowSX, \
$CellContext`lowEX} + $CellContext`posX - 
             1. - {$CellContext`cent1, $CellContext`cent2}; {$CellContext`yY, \
$CellContext`xY} = {$CellContext`lowSY, $CellContext`lowEY} + \
$CellContext`posY - 
             1. - {$CellContext`cent1, $CellContext`cent2}; {$CellContext`yD, \
$CellContext`xD} = {$CellContext`lowSD, $CellContext`lowED} + \
$CellContext`posD - 
             1. - {$CellContext`cent1, $CellContext`cent2}; {$CellContext`yC, \
$CellContext`xC} = {$CellContext`lowSC, $CellContext`lowEC} + \
$CellContext`posC - 
             1. - {$CellContext`cent1, $CellContext`cent2}; $CellContext`p1 = \
{$CellContext`yX, $CellContext`xX}; $CellContext`p2 = 
            2 {$CellContext`yD, $CellContext`xD} - {$CellContext`yY, \
$CellContext`xY}; $CellContext`p3 = (-2) {$CellContext`yC, $CellContext`xC} + \
{$CellContext`yY, $CellContext`xY}; $CellContext`p4 = {$CellContext`yD, \
$CellContext`xD} - {$CellContext`yC, $CellContext`xC}; $CellContext`q1 = \
{$CellContext`yY, $CellContext`xY}; $CellContext`q2 = 
            2 {$CellContext`yD, $CellContext`xD} - {$CellContext`yX, \
$CellContext`xX}; $CellContext`q3 = 
            2 {$CellContext`yC, $CellContext`xC} + {$CellContext`yX, \
$CellContext`xX}; $CellContext`q4 = {$CellContext`yC, $CellContext`xC} + \
{$CellContext`yD, $CellContext`xD}; $CellContext`allYs = 
            
            Map[$CellContext`calFreqP[#, $CellContext`siz]& , \
{$CellContext`p1, $CellContext`p2, $CellContext`p3, $CellContext`p4, 
               Median[{$CellContext`p1, $CellContext`p2, $CellContext`p3}], 
               
               Median[{$CellContext`p1, $CellContext`p2, $CellContext`p3, \
$CellContext`p4}]}]; $CellContext`allXs = 
            Map[$CellContext`calFreqQ[#, $CellContext`siz]& , \
{$CellContext`q1, $CellContext`q2, $CellContext`q3, $CellContext`q4, 
               Median[{$CellContext`q1, $CellContext`q2, $CellContext`q3}], 
               
               Median[{$CellContext`q1, $CellContext`q2, $CellContext`q3, \
$CellContext`q4}]}]; {$CellContext`countY, $CellContext`argY} = 
            Transpose[$CellContext`allYs]; {$CellContext`countX, \
$CellContext`argX} = 
            Transpose[$CellContext`allXs]; {$CellContext`countX, \
$CellContext`countY, $CellContext`argX, $CellContext`argY}], \
$CellContext`calFreqP[{
            Pattern[$CellContext`x, 
             Blank[]], 
            Pattern[$CellContext`y, 
             Blank[]]}, 
           Pattern[$CellContext`siz, 
            Blank[]]] := {$CellContext`dpc (
            Norm[{$CellContext`y, $CellContext`x}]/$CellContext`siz), 90 - 
           ArcTan[$CellContext`x, $CellContext`y]/
           Degree}, $CellContext`calFreqQ[{
            Pattern[$CellContext`x, 
             Blank[]], 
            Pattern[$CellContext`y, 
             Blank[]]}, 
           Pattern[$CellContext`siz, 
            Blank[]]] := {$CellContext`dpc (
            Norm[{$CellContext`y, $CellContext`x}]/$CellContext`siz), -
            ArcTan[$CellContext`x, $CellContext`y]/Degree - 
           90}, $CellContext`getPatch[
           Pattern[$CellContext`i, 
            Blank[]], 
           Pattern[$CellContext`j, 
            Blank[]]] := 
         Module[{}, $CellContext`thisInd = 
            Part[$CellContext`allPatches, $CellContext`i, $CellContext`j]; \
$CellContext`thisPatch = ImageTake[$CellContext`imgFull, {
               Part[$CellContext`thisInd, 1], 
               Part[$CellContext`thisInd, 1] + $CellContext`sizBlocks - 1}, {
               Part[$CellContext`thisInd, 2], 
               Part[$CellContext`thisInd, 2] + $CellContext`sizBlocks - 1}]]}; 
       Null}; Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output"]
}, {2}]]
},
WindowSize->{1082, 901},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
ShowCellBracket->Automatic,
TrackCellChangeTimes->False,
FrontEndVersion->"10.4 for Mac OS X x86 (32-bit, 64-bit Kernel) (April 11, \
2016)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[1464, 33, 92, 1, 38, "Text"],
Cell[1559, 36, 1005, 20, 258, "Text"],
Cell[CellGroupData[{
Cell[2589, 60, 35348, 897, 1780, "Input"],
Cell[37940, 959, 21731, 429, 500, "Output"]
}, {2}]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature XVOx1CJD@uDnjVzzoe2C6d87 *)
