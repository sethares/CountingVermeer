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
NotebookDataLength[      8187,        246]
NotebookOptionsPosition[      8697,        239]
NotebookOutlinePosition[      9121,        258]
CellTagsIndexPosition[      9078,        255]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell[BoxData[{
 RowBox[{
  RowBox[{"opts", "=", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"FontFamily", "\[Rule]", "\"\<Times\>\""}], ",", 
     RowBox[{"FontSize", "\[Rule]", "16"}], ",", "Black", ",", 
     RowBox[{"TextJustification", "\[Rule]", "1"}]}], "}"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{"Grid", "[", 
  RowBox[{
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Button", "[", 
        RowBox[{"\"\<Look at X-rays\>\"", ",", 
         RowBox[{"NotebookOpen", "[", 
          RowBox[{
           RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
           "\"\<zoomIn.cdf\>\""}], "]"}]}], "]"}], ",", 
       RowBox[{"TextCell", "[", 
        RowBox[{
        "\"\<Zoom in and make a preliminary thread count. Save interesting \
patches for later analysis.\>\"", ",", "opts"}], "]"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Button", "[", 
        RowBox[{"\"\<Manual Thread Count\>\"", ",", 
         RowBox[{"NotebookOpen", "[", 
          RowBox[{
           RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
           "\"\<threadMarker.cdf\>\""}], "]"}]}], "]"}], ",", 
       RowBox[{"TextCell", "[", 
        RowBox[{
        "\"\<Do a careful manual thread marking and counting. Gather \
statistics on the weave.\>\"", ",", "opts"}], "]"}]}], "}"}], ",", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Button", "[", 
        RowBox[{"\"\<Calculate Weave Map\>\"", ",", 
         RowBox[{"NotebookOpen", "[", 
          RowBox[{
           RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
           "\"\<countThreads.cdf\>\""}], "]"}]}], "]"}], ",", 
       RowBox[{"TextCell", "[", 
        RowBox[{
        "\"\<Use the manual thread count to initialize the automated \
calculation of the weave map.\>\"", ",", "opts"}], "]"}]}], "}"}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{
       RowBox[{"Button", "[", 
        RowBox[{"\"\<Display Weave Maps\>\"", ",", 
         RowBox[{"NotebookOpen", "[", 
          RowBox[{
           RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
           "\"\<displayWeaveMaps.cdf\>\""}], "]"}]}], "]"}], ",", 
       RowBox[{"TextCell", "[", 
        RowBox[{
        "\"\<Look at thread count and angle maps across the complete Vermeer \
x-rays.\>\"", ",", "opts"}], "]"}]}], "}"}], ",", 
     RowBox[{"{", "\[IndentingNewLine]", 
      RowBox[{
       RowBox[{"Button", "[", 
        RowBox[{"\"\<Align Weave Maps\>\"", ",", 
         RowBox[{"NotebookOpen", "[", 
          RowBox[{
           RowBox[{"NotebookDirectory", "[", "]"}], "<>", 
           "\"\<align.cdf\>\""}], "]"}]}], "]"}], ",", 
       RowBox[{"TextCell", "[", 
        RowBox[{
        "\"\<Examine pairs of weave maps for matches.\>\"", ",", "opts"}], 
        "]"}]}], "}"}]}], "}"}], ",", 
   RowBox[{"Background", "\[Rule]", 
    RowBox[{"RGBColor", "[", 
     RowBox[{"0.9", ",", "0.9", ",", "0.9"}], "]"}]}]}], "]"}]}], "Input"],

Cell[BoxData[
 TagBox[GridBox[{
    {
     ButtonBox["\<\"Look at X-rays\"\>",
      Appearance->Automatic,
      ButtonFunction:>NotebookOpen[
        StringJoin[
         NotebookDirectory[], "zoomIn.cdf"]],
      Evaluator->Automatic,
      Method->"Preemptive"], 
     InterpretationBox[Cell["\<\
Zoom in and make a preliminary thread count. Save interesting patches for \
later analysis.\
\>",
       TextJustification->1,
       LineColor->GrayLevel[0],
       FrontFaceColor->GrayLevel[0],
       BackFaceColor->GrayLevel[0],
       GraphicsColor->GrayLevel[0],
       FontFamily->"Times",
       FontSize->16,
       FontColor->GrayLevel[0]],
      TextCell[
      "Zoom in and make a preliminary thread count. Save interesting patches \
for later analysis.", {FontFamily -> "Times", FontSize -> 16, 
        GrayLevel[0], TextJustification -> 1}]]},
    {
     ButtonBox["\<\"Manual Thread Count\"\>",
      Appearance->Automatic,
      ButtonFunction:>NotebookOpen[
        StringJoin[
         NotebookDirectory[], "threadMarker.cdf"]],
      Evaluator->Automatic,
      Method->"Preemptive"], 
     InterpretationBox[Cell["\<\
Do a careful manual thread marking and counting. Gather statistics on the \
weave.\
\>",
       TextJustification->1,
       LineColor->GrayLevel[0],
       FrontFaceColor->GrayLevel[0],
       BackFaceColor->GrayLevel[0],
       GraphicsColor->GrayLevel[0],
       FontFamily->"Times",
       FontSize->16,
       FontColor->GrayLevel[0]],
      TextCell[
      "Do a careful manual thread marking and counting. Gather statistics on \
the weave.", {FontFamily -> "Times", FontSize -> 16, 
        GrayLevel[0], TextJustification -> 1}]]},
    {
     ButtonBox["\<\"Calculate Weave Map\"\>",
      Appearance->Automatic,
      ButtonFunction:>NotebookOpen[
        StringJoin[
         NotebookDirectory[], "countThreads.cdf"]],
      Evaluator->Automatic,
      Method->"Preemptive"], 
     InterpretationBox[Cell["\<\
Use the manual thread count to initialize the automated calculation of the \
weave map.\
\>",
       TextJustification->1,
       LineColor->GrayLevel[0],
       FrontFaceColor->GrayLevel[0],
       BackFaceColor->GrayLevel[0],
       GraphicsColor->GrayLevel[0],
       FontFamily->"Times",
       FontSize->16,
       FontColor->GrayLevel[0]],
      TextCell[
      "Use the manual thread count to initialize the automated calculation of \
the weave map.", {FontFamily -> "Times", FontSize -> 16, 
        GrayLevel[0], TextJustification -> 1}]]},
    {
     ButtonBox["\<\"Display Weave Maps\"\>",
      Appearance->Automatic,
      ButtonFunction:>NotebookOpen[
        StringJoin[
         NotebookDirectory[], "displayWeaveMaps.cdf"]],
      Evaluator->Automatic,
      Method->"Preemptive"], 
     InterpretationBox[Cell["\<\
Look at thread count and angle maps across the complete Vermeer x-rays.\
\>",
       TextJustification->1,
       LineColor->GrayLevel[0],
       FrontFaceColor->GrayLevel[0],
       BackFaceColor->GrayLevel[0],
       GraphicsColor->GrayLevel[0],
       FontFamily->"Times",
       FontSize->16,
       FontColor->GrayLevel[0]],
      TextCell[
      "Look at thread count and angle maps across the complete Vermeer \
x-rays.", {FontFamily -> "Times", FontSize -> 16, 
        GrayLevel[0], TextJustification -> 1}]]},
    {
     ButtonBox["\<\"Align Weave Maps\"\>",
      Appearance->Automatic,
      ButtonFunction:>NotebookOpen[
        StringJoin[
         NotebookDirectory[], "align.cdf"]],
      Evaluator->Automatic,
      Method->"Preemptive"], 
     InterpretationBox[Cell["Examine pairs of weave maps for matches.",
       TextJustification->1,
       LineColor->GrayLevel[0],
       FrontFaceColor->GrayLevel[0],
       BackFaceColor->GrayLevel[0],
       GraphicsColor->GrayLevel[0],
       FontFamily->"Times",
       FontSize->16,
       FontColor->GrayLevel[0]],
      TextCell[
      "Examine pairs of weave maps for matches.", {
       FontFamily -> "Times", FontSize -> 16, 
        GrayLevel[0], TextJustification -> 1}]]}
   },
   AutoDelete->False,
   GridBoxBackground->{"Columns" -> {{
        RGBColor[0.9, 0.9, 0.9]}}},
   GridBoxItemSize->{"Columns" -> {{Automatic}}, "Rows" -> {{Automatic}}}],
  "Grid"]], "Output"]
}, {2}]]
},
WindowSize->{890, 222},
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
Cell[CellGroupData[{
Cell[1486, 35, 2958, 76, 267, "Input"],
Cell[4447, 113, 4237, 123, 173, "Output"]
}, {2}]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature CVOboDbpPgcqUU4evvKxhq2t *)
