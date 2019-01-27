(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 11.3' *)

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
NotebookDataLength[     65825,       1524]
NotebookOptionsPosition[     65922,       1513]
NotebookOutlinePosition[     66362,       1533]
CellTagsIndexPosition[     66319,       1530]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[TextData[StyleBox["Calculate weave maps from canvas x-rays ", \
"Subsection"]], "Text",ExpressionUUID->"3f9eb566-443f-44fc-b5db-611bb0ef358d"],

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
function.\
\>", "Text",ExpressionUUID->"a246418d-6a0d-43b7-94bb-981494ab3e37"],

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
           RowBox[{"ColorConvert", "[", 
            RowBox[{
             RowBox[{"Import", "[", "fName", "]"}], ",", 
             "\"\<Grayscale\>\""}], "]"}]}], ";", 
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
        RowBox[{"dpires", "/", "2.54"}]}], ";", 
       RowBox[{
        RowBox[{"{", 
         RowBox[{"w", ",", "h"}], "}"}], "=", 
        RowBox[{"ImageDimensions", "[", "imgFull", "]"}]}], ";", 
       "\[IndentingNewLine]", 
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
             RowBox[{"kk", "=", "ii"}], ";", "\[IndentingNewLine]", 
             RowBox[{"newPatch", "=", 
              RowBox[{"getPatch", "[", 
               RowBox[{"ii", ",", "jj"}], "]"}]}], ";", 
             RowBox[{"tot", "=", 
              RowBox[{"Total", "[", 
               RowBox[{
                RowBox[{"ImageData", "[", "newPatch", "]"}], ",", "2"}], 
               "]"}]}], ";", "\[IndentingNewLine]", 
             RowBox[{"fft2D", "[", 
              RowBox[{
              "newPatch", ",", "meanV", ",", "meanH", ",", "fftSize", ",", 
               "2", ",", "orient", ",", "False"}], "]"}]}], ",", 
            RowBox[{"{", 
             RowBox[{"ii", ",", "1", ",", "imgRows", ",", "1"}], "}"}], ",", 
            RowBox[{"{", 
             RowBox[{"jj", ",", "1", ",", "imgCols", ",", "1"}], "}"}]}], 
           "]"}], ",", "1"}], "]"}]}], ";", "\[IndentingNewLine]", 
       RowBox[{"Do", "[", 
        RowBox[{
         RowBox[{
          RowBox[{"If", "[", 
           RowBox[{
            RowBox[{
             RowBox[{"Position", "[", 
              RowBox[{"method", ",", "i"}], "]"}], "=!=", 
             RowBox[{"{", "}"}]}], ",", "\[IndentingNewLine]", 
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
              RowBox[{"Table", "[", 
               RowBox[{
                RowBox[{
                 RowBox[{"val", "=", 
                  RowBox[{"allThreads", "[", 
                   RowBox[{"[", 
                    RowBox[{"kkk", ",", "3", ",", "i"}], "]"}], "]"}]}], ";", 
                 
                 RowBox[{"If", "[", 
                  RowBox[{
                   RowBox[{"val", "<", "Infinity"}], ",", 
                   RowBox[{"Mod", "[", 
                    RowBox[{"val", ",", "360"}], "]"}], ",", "Infinity"}], 
                  "]"}]}], ",", 
                RowBox[{"{", 
                 RowBox[{"kkk", ",", 
                  RowBox[{"Length", "[", 
                   RowBox[{"allThreads", "[", 
                    RowBox[{"[", 
                    RowBox[{"All", ",", "3", ",", "i"}], "]"}], "]"}], 
                   "]"}]}], "}"}]}], "]"}]}], ";", 
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
                   RowBox[{"100", " ", "allV"}], "]"}], "/", "100"}], "]"}], 
                ",", "imgCols"}], "]"}]}], ";", 
             RowBox[{"angV", "=", 
              RowBox[{"Partition", "[", 
               RowBox[{
                RowBox[{"N", "[", 
                 RowBox[{
                  RowBox[{"Round", "[", 
                   RowBox[{"100", " ", "allAngV"}], "]"}], "/", "100"}], 
                 "]"}], ",", "imgCols"}], "]"}]}], ";", 
             RowBox[{"matH", "=", 
              RowBox[{"Partition", "[", 
               RowBox[{
                RowBox[{"N", "[", 
                 RowBox[{
                  RowBox[{"Round", "[", 
                   RowBox[{"100", " ", "allH"}], "]"}], "/", "100"}], "]"}], 
                ",", "imgCols"}], "]"}]}], ";", 
             RowBox[{"angH", "=", 
              RowBox[{"Partition", "[", 
               RowBox[{
                RowBox[{"N", "[", 
                 RowBox[{
                  RowBox[{"Round", "[", 
                   RowBox[{"100", " ", "allAngH"}], "]"}], "/", "100"}], 
                 "]"}], ",", "imgCols"}], "]"}]}], ";", "\[IndentingNewLine]", 
             RowBox[{"suf", "=", 
              RowBox[{"orient", "<>", 
               RowBox[{"ToString", "[", "i", "]"}], "<>", "\"\<(\>\"", "<>", 
               RowBox[{"ToString", "[", 
                RowBox[{"If", "[", 
                 RowBox[{
                  RowBox[{"sizeSquares", "<", "1"}], ",", 
                  RowBox[{"N", "[", "sizeSquares", "]"}], ",", 
                  "sizeSquares"}], "]"}], "]"}], "<>", "\"\<-\>\"", "<>", 
               RowBox[{"ToString", "[", 
                RowBox[{"If", "[", 
                 RowBox[{
                  RowBox[{"IntegerQ", "[", "overlap", "]"}], ",", "overlap", 
                  ",", 
                  RowBox[{"N", "[", "overlap", "]"}]}], "]"}], "]"}], "<>", 
               "\"\<)\>\"", "<>", 
               RowBox[{"ToString", "[", "extraName", "]"}], "<>", 
               "\"\<.m\>\""}]}], ";", 
             RowBox[{"fileOut", "=", 
              RowBox[{
               RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
               "\"\<threadCount\>\"", "<>", "fileName", "<>", "suf"}]}], ";", 
             
             RowBox[{"Save", "[", 
              RowBox[{"fileOut", ",", 
               RowBox[{"{", 
                RowBox[{"matH", ",", "angH", ",", "matV", ",", "angV"}], 
                "}"}]}], "]"}], ";"}]}], "]"}], ";"}], ",", 
         RowBox[{"{", 
          RowBox[{"i", ",", "6"}], "}"}]}], "]"}], ";", "\[IndentingNewLine]", 
       RowBox[{"fileMess", "=", 
        RowBox[{"\"\<Weave map data written to file(s):\\n\>\"", "<>", 
         RowBox[{"NotebookDirectory", "[", "]"}], "<>", "\"\<threadCount\>\"",
          "<>", "fileName"}]}], ";", "\[IndentingNewLine]", 
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
          RowBox[{"newFile", ",", "False", ",", "\"\<\>\""}], "}"}], ",", 
         RowBox[{
          RowBox[{"Button", "[", 
           RowBox[{
            RowBox[{"Text", "[", "\"\<new x-ray\>\"", "]"}], ",", 
            RowBox[{"newFile", "=", "True"}]}], "]"}], "&"}]}], "}"}], "]"}], 
      ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"meanH", ",", "10.", ",", "\"\<horizontal\\nmean\>\""}], 
          "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", " ", 
         RowBox[{"FieldSize", "\[Rule]", "5"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"meanV", ",", "12.", ",", "\"\<vertical\\nmean\>\""}], 
          "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", 
         RowBox[{"FieldSize", "\[Rule]", "5"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"orient", ",", "\"\<Linear\>\"", ",", "\"\<Filter\>\""}], 
          "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"\"\<Local\>\"", ",", "\"\<Linear\>\""}], "}"}]}], "}"}], 
       "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"extraName", ",", "\"\<\>\"", ",", "\"\<label\>\""}], "}"}],
          ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", 
         RowBox[{"FieldSize", "\[Rule]", "6"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "20", "]"}], ",", 
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
           RowBox[{"3", "/", "4"}], ",", "\"\<block\\nsize (cm)\>\""}], "}"}],
          ",", 
         RowBox[{"{", 
          RowBox[{
           RowBox[{"5", "/", "4"}], ",", "1", ",", 
           RowBox[{"3", "/", "4"}], ",", 
           RowBox[{"1", "/", "2"}], ",", 
           RowBox[{"2", "/", "5"}]}], "}"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"overlap", ",", "6", ",", "\"\<overlap\>\""}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"2", ",", "3", ",", "4", ",", "6", ",", "8", ",", "10"}], 
          "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "SetterBar"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"fftSize", ",", "1024", ",", "\"\<FFT size\>\""}], "}"}], 
         ",", 
         RowBox[{"{", 
          RowBox[{"512", ",", "1024"}], "}"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"dpires", ",", "600", ",", "\"\<DPI\>\""}], "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "InputField"}], ",", 
         RowBox[{"FieldSize", "\[Rule]", "5"}]}], "}"}], "]"}], ",", 
      RowBox[{"Spacer", "[", "10", "]"}], ",", 
      RowBox[{"Control", "[", 
       RowBox[{"{", 
        RowBox[{
         RowBox[{"{", 
          RowBox[{"method", ",", 
           RowBox[{"{", 
            RowBox[{"1", ",", "2", ",", "3", ",", "4", ",", "5", ",", "6"}], 
            "}"}], ",", "\"\<method\>\""}], "}"}], ",", 
         RowBox[{"{", 
          RowBox[{"1", ",", "2", ",", "3", ",", "4", ",", "5", ",", "6"}], 
          "}"}], ",", 
         RowBox[{"ControlType", "\[Rule]", "TogglerBar"}]}], "}"}], "]"}]}], 
     "}"}], "]"}], ",", 
   RowBox[{"FrameLabel", "\[Rule]", 
    RowBox[{"Style", "[", 
     RowBox[{
      RowBox[{"Dynamic", "[", "fileName", "]"}], ",", "Medium"}], "]"}]}], 
   ",", 
   RowBox[{"SaveDefinitions", "\[Rule]", "True"}], ",", 
   RowBox[{"SynchronousUpdating", "\[Rule]", "False"}], ",", 
   "\[IndentingNewLine]", 
   RowBox[{"Initialization", "\[Rule]", 
    RowBox[{"(", 
     RowBox[{
      RowBox[{"disp", "=", "\"\<please load an x-ray file\>\""}], ";", 
      RowBox[{"fileMess", "=", "\"\<\>\""}], ";", "\[IndentingNewLine]", 
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
           "}"}]}]}], "]"}]}]}], ")"}]}]}], "]"}]], "Input",ExpressionUUID->\
"13496e47-60bb-40be-a844-253618370803"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`calc$$ = False, $CellContext`dpires$$ = 
    600, $CellContext`extraName$$ = "", $CellContext`fftSize$$ = 
    1024, $CellContext`meanH$$ = 10., $CellContext`meanV$$ = 
    12., $CellContext`method$$ = {1, 2, 3, 4, 5, 6}, $CellContext`newFile$$ = 
    False, $CellContext`orient$$ = "Linear", $CellContext`overlap$$ = 
    6, $CellContext`sizeSquares$$ = Rational[3, 4], Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`newFile$$], False, ""}, 
      Dynamic[Button[
        Text["new x-ray"], $CellContext`newFile$$ = True]& ]}, {{
       Hold[$CellContext`meanH$$], 10., "horizontal\nmean"}}, {{
       Hold[$CellContext`meanV$$], 12., "vertical\nmean"}}, {{
       Hold[$CellContext`orient$$], "Linear", "Filter"}, {
      "Local", "Linear"}}, {{
       Hold[$CellContext`extraName$$], "", "label"}}, {{
       Hold[$CellContext`calc$$], False, ""}, 
      Dynamic[Button["Calculate", $CellContext`calc$$ = True]& ]}, {
      Hold[
       Row[{
         Manipulate`Place[1], 
         Spacer[10], 
         Manipulate`Place[2], 
         Spacer[10], 
         Manipulate`Place[3], 
         Spacer[10], 
         Manipulate`Place[4], 
         Spacer[10], 
         Manipulate`Place[5], 
         Spacer[20], 
         Manipulate`Place[6]}]], Manipulate`Dump`ThisIsNotAControl}, {{
       Hold[$CellContext`sizeSquares$$], 
       Rational[3, 4], "block\nsize (cm)"}, {
       Rational[5, 4], 1, 
       Rational[3, 4], 
       Rational[1, 2], 
       Rational[2, 5]}}, {{
       Hold[$CellContext`overlap$$], 6, "overlap"}, {2, 3, 4, 6, 8, 10}}, {{
       Hold[$CellContext`fftSize$$], 1024, "FFT size"}, {512, 1024}}, {{
       Hold[$CellContext`dpires$$], 600, "DPI"}}, {{
       Hold[$CellContext`method$$], {1, 2, 3, 4, 5, 6}, "method"}, {1, 2, 3, 
      4, 5, 6}}, {
      Hold[
       Row[{
         Manipulate`Place[7], 
         Spacer[10], 
         Manipulate`Place[8], 
         Spacer[10], 
         Manipulate`Place[9], 
         Spacer[10], 
         Manipulate`Place[10], 
         Spacer[10], 
         Manipulate`Place[11]}]], Manipulate`Dump`ThisIsNotAControl}}, 
    Typeset`size$$ = {600., {162.134033203125, 167.865966796875}}, 
    Typeset`update$$ = 0, Typeset`initDone$$, Typeset`skipInitDone$$ = 
    False, $CellContext`orient$2251$$ = 
    False, $CellContext`sizeSquares$2252$$ = 0, $CellContext`overlap$2253$$ = 
    0, $CellContext`fftSize$2254$$ = False, $CellContext`method$2255$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     2, StandardForm, 
      "Variables" :> {$CellContext`calc$$ = False, $CellContext`dpires$$ = 
        600, $CellContext`extraName$$ = "", $CellContext`fftSize$$ = 
        1024, $CellContext`meanH$$ = 10., $CellContext`meanV$$ = 
        12., $CellContext`method$$ = {1, 2, 3, 4, 5, 
         6}, $CellContext`newFile$$ = False, $CellContext`orient$$ = 
        "Linear", $CellContext`overlap$$ = 6, $CellContext`sizeSquares$$ = 
        Rational[3, 4]}, "ControllerVariables" :> {
        Hold[$CellContext`orient$$, $CellContext`orient$2251$$, False], 
        Hold[$CellContext`sizeSquares$$, $CellContext`sizeSquares$2252$$, 0], 
        
        Hold[$CellContext`overlap$$, $CellContext`overlap$2253$$, 0], 
        Hold[$CellContext`fftSize$$, $CellContext`fftSize$2254$$, False], 
        Hold[$CellContext`method$$, $CellContext`method$2255$$, 0]}, 
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
           "tif", $CellContext`imgFull = ColorConvert[
              Import[$CellContext`fName], "Grayscale"]; $CellContext`disp = 
            ImageResize[$CellContext`imgFull, {300}]; $CellContext`fileName = 
            FileBaseName[$CellContext`fName]; $CellContext`fileMess = 
            ""; $CellContext`newFile$$ = False]; Null]; 
       If[$CellContext`fName == $Canceled, $CellContext`newFile$$ = 
         False]; $CellContext`var = $CellContext`calc$$; If[
         And[$CellContext`var == True, ImageQ[$CellContext`imgFull] == 
          True], $CellContext`dpc = $CellContext`dpires$$/
           2.54; {$CellContext`w, $CellContext`h} = 
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
            
            Table[$CellContext`kk = $CellContext`ii; $CellContext`newPatch = \
$CellContext`getPatch[$CellContext`ii, $CellContext`jj]; $CellContext`tot = 
              Total[
                ImageData[$CellContext`newPatch], 
                2]; $CellContext`fft2D[$CellContext`newPatch, \
$CellContext`meanV$$, $CellContext`meanH$$, $CellContext`fftSize$$, 
               2, $CellContext`orient$$, False], {$CellContext`ii, 
              1, $CellContext`imgRows, 1}, {$CellContext`jj, 
              1, $CellContext`imgCols, 1}], 1]; 
         Do[If[Position[$CellContext`method$$, $CellContext`i] =!= {}, \
$CellContext`allH = 
              Part[$CellContext`allThreads, All, 
                1, $CellContext`i]; $CellContext`allV = 
              Part[$CellContext`allThreads, All, 
                2, $CellContext`i]; $CellContext`allAngH = 
              Table[$CellContext`val = 
                 Part[$CellContext`allThreads, $CellContext`kkk, 
                   3, $CellContext`i]; If[$CellContext`val < Infinity, 
                  Mod[$CellContext`val, 360], Infinity], {$CellContext`kkk, 
                 Length[
                  
                  Part[$CellContext`allThreads, All, 
                   3, $CellContext`i]]}]; $CellContext`allAngV = 
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
                 100], $CellContext`imgCols]; $CellContext`suf = 
              StringJoin[$CellContext`orient$$, 
                ToString[$CellContext`i], "(", 
                ToString[
                 If[$CellContext`sizeSquares$$ < 1, 
                  N[$CellContext`sizeSquares$$], $CellContext`sizeSquares$$]],
                 "-", 
                ToString[
                 If[
                  IntegerQ[$CellContext`overlap$$], $CellContext`overlap$$, 
                  N[$CellContext`overlap$$]]], ")", 
                ToString[$CellContext`extraName$$], 
                ".m"]; $CellContext`fileOut = StringJoin[
                NotebookDirectory[], 
                "threadCount", $CellContext`fileName, $CellContext`suf]; 
             
             Save[$CellContext`fileOut, {$CellContext`matH, \
$CellContext`angH, $CellContext`matV, $CellContext`angV}]; Null]; 
           Null, {$CellContext`i, 6}]; $CellContext`fileMess = 
          StringJoin["Weave map data written to file(s):\n", 
            NotebookDirectory[], 
            "threadCount", $CellContext`fileName]; $CellContext`calc$$ = 
          False, $CellContext`calc$$ = False]; Column[{
          GraphicsRow[{$CellContext`disp, 
            ProgressIndicator[
             Dynamic[$CellContext`kk/$CellContext`imgRows]]}, ImageSize -> 
           600], $CellContext`fileMess}]), 
      "Specifications" :> {{{$CellContext`newFile$$, False, ""}, 
         Dynamic[Button[
           Text["new x-ray"], $CellContext`newFile$$ = True]& ], 
         ControlPlacement -> 
         1}, {{$CellContext`meanH$$, 10., "horizontal\nmean"}, ControlType -> 
         InputField, FieldSize -> 5, ControlPlacement -> 
         2}, {{$CellContext`meanV$$, 12., "vertical\nmean"}, ControlType -> 
         InputField, FieldSize -> 5, ControlPlacement -> 
         3}, {{$CellContext`orient$$, "Linear", "Filter"}, {
         "Local", "Linear"}, ControlPlacement -> 
         4}, {{$CellContext`extraName$$, "", "label"}, ControlType -> 
         InputField, FieldSize -> 6, ControlPlacement -> 
         5}, {{$CellContext`calc$$, False, ""}, 
         Dynamic[Button["Calculate", $CellContext`calc$$ = True]& ], 
         ControlPlacement -> 6}, 
        Row[{
          Manipulate`Place[1], 
          Spacer[10], 
          Manipulate`Place[2], 
          Spacer[10], 
          Manipulate`Place[3], 
          Spacer[10], 
          Manipulate`Place[4], 
          Spacer[10], 
          Manipulate`Place[5], 
          Spacer[20], 
          Manipulate`Place[6]}], {{$CellContext`sizeSquares$$, 
          Rational[3, 4], "block\nsize (cm)"}, {
          Rational[5, 4], 1, 
          Rational[3, 4], 
          Rational[1, 2], 
          Rational[2, 5]}, ControlPlacement -> 
         7}, {{$CellContext`overlap$$, 6, "overlap"}, {2, 3, 4, 6, 8, 10}, 
         ControlType -> SetterBar, ControlPlacement -> 
         8}, {{$CellContext`fftSize$$, 1024, "FFT size"}, {512, 1024}, 
         ControlPlacement -> 9}, {{$CellContext`dpires$$, 600, "DPI"}, 
         ControlType -> InputField, FieldSize -> 5, ControlPlacement -> 
         10}, {{$CellContext`method$$, {1, 2, 3, 4, 5, 6}, "method"}, {1, 2, 
         3, 4, 5, 6}, ControlType -> TogglerBar, ControlPlacement -> 11}, 
        Row[{
          Manipulate`Place[7], 
          Spacer[10], 
          Manipulate`Place[8], 
          Spacer[10], 
          Manipulate`Place[9], 
          Spacer[10], 
          Manipulate`Place[10], 
          Spacer[10], 
          Manipulate`Place[11]}]}, "Options" :> {FrameLabel -> Style[
          Dynamic[$CellContext`fileName], Medium], SynchronousUpdating -> 
        False}, "DefaultOptions" :> {}],
     ImageSizeCache->{670., {240., 246.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    Initialization:>({{$CellContext`disp = 
         "please load an x-ray file", $CellContext`fileMess = 
         "", $CellContext`var = False, $CellContext`getPatch[
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
               Part[$CellContext`thisInd, 2] + $CellContext`sizBlocks - 
               1}]], $CellContext`fft2D[
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
            Max[(($CellContext`xRegion - 1) MaxDetect[$CellContext`xRegion]) 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`xRegion] - 2], 1]]; 
           If[$CellContext`maxX <= 0, $CellContext`posX = {0, 0}; 
             Null, $CellContext`posX = First[
                Position[$CellContext`xRegion, $CellContext`maxX + 1]]; 
             Null]; $CellContext`maxY = 
            Max[(($CellContext`yRegion - 1) MaxDetect[$CellContext`yRegion]) 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`yRegion] - 2], 1]]; 
           If[$CellContext`maxY <= 0, $CellContext`posY = {0, 0}; 
             Null, $CellContext`posY = First[
                Position[$CellContext`yRegion, $CellContext`maxY + 1]]; 
             Null]; $CellContext`maxD = 
            Max[(($CellContext`dRegion - 1) MaxDetect[$CellContext`dRegion]) 
              ArrayPad[
                ConstantArray[1, Dimensions[$CellContext`dRegion] - 2], 1]]; 
           If[$CellContext`maxD <= 0, $CellContext`posD = {0, 0}; 
             Null, $CellContext`posD = First[
                Position[$CellContext`dRegion, $CellContext`maxD + 1]]; 
             Null]; $CellContext`maxC = 
            Max[(($CellContext`cRegion - 1) MaxDetect[$CellContext`cRegion]) 
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
            Norm[{$CellContext`y, $CellContext`x}]/$CellContext`siz), (-
             ArcTan[$CellContext`x, $CellContext`y])/Degree - 90}}; Null}; 
     Typeset`initDone$$ = True),
    SynchronousInitialization->True,
    UndoTrackedVariables:>{Typeset`show$$, Typeset`bookmarkMode$$},
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output",ExpressionUUID->"fa1b1d0f-\
c8ec-4a34-b3b8-35b06f3c5597"]
}, {2}]],

Cell["\<\
When you look at the 2D FFT of a weave pattern, there are often peaks on the \
x-axis and on the y-axis that correspond directly to the thread densities. \
But there are (often) two other peaks (at the 45 degree point and at the -45 \
degree) that can give information about the thread density. In total, there \
are six ways of doing things:

(1) measure the x and y locations directly (ignore the +/- 45 points)
(2) measure the x location and calculate the y value using the x-location \
plus the 45 degree location (ignore the y-location and the -45)
(3) measure the x location and calculate the y value using the x-location \
plus the -45 degree location \[NonBreakingSpace](ignore the y-location and \
the 45)
(4) measure the y location and calculate the x value using the y-location \
plus the 45 degree location \[NonBreakingSpace](ignore the x-location and the \
-45)
(5) measure the y location and calculate the x value using the y-location \
plus the -45 degree location \[NonBreakingSpace](ignore the x-location and \
the 45)
(6) measure the 45 degree and -45 degree locations and estimate both the x \
and y locations \[NonBreakingSpace](ignore both the x and y locations)

Depending on the particulars of the canvas, sometimes one of these is \
noticeably better than the others. For instance, if the y-peaks were hard to \
locate, then either (2) or (3) would be the best.\[NonBreakingSpace]\
\>", "Text",ExpressionUUID->"358f360f-bcb5-4aff-ac78-ef764fbdbf34"]
},
WindowSize->{1082, 901},
Visible->True,
ScrollingOptions->{"VerticalScrollRange"->Fit},
ShowCellBracket->Automatic,
Deployed->True,
TrackCellChangeTimes->False,
FrontEndVersion->"11.3 for Mac OS X x86 (32-bit, 64-bit Kernel) (March 5, \
2018)",
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
Cell[1464, 33, 147, 1, 41, "Text",ExpressionUUID->"3f9eb566-443f-44fc-b5db-611bb0ef358d"],
Cell[1614, 36, 992, 18, 265, "Text",ExpressionUUID->"a246418d-6a0d-43b7-94bb-981494ab3e37"],
Cell[CellGroupData[{
Cell[2631, 58, 38256, 958, 2236, "Input",ExpressionUUID->"13496e47-60bb-40be-a844-253618370803"],
Cell[40890, 1018, 23532, 465, 505, "Output",ExpressionUUID->"fa1b1d0f-c8ec-4a34-b3b8-35b06f3c5597"]
}, {2}]],
Cell[64434, 1486, 1484, 25, 311, "Text",ExpressionUUID->"358f360f-bcb5-4aff-ac78-ef764fbdbf34"]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature uU#hz8caVjAmKUz8oPU7u6aT *)
