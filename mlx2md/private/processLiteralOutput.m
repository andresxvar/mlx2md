function [str, idxLiteral, idx_matlabcode] = processLiteralOutput(str)
% Modified from Copyright 2020 The MathWorks, Inc. 

%% MATLAB Code
% Latex: 
% \begin{matlabcode}(code)\end{matlabcode}
% \begin{verbatim}(code)\end{verbatim}
% \begin{lstlisting}(code)\end{lstlisting}
%
% Markdown
% ```matlab:MATLAB Code
% （code）
%```
%% Literal Outputs
% Latex: 
% \begin{matlaboutput}(output)\end{matlaboutput}
%
% Markdown
% ```text:Output
%  (output)
% ```
% Note: Other outputs (matlabsymbolicoutout, matlabtableoutput)
% will be processed in processDocumentOutput.m

idx_lstlisting = startsWith(str,"\begin{lstlisting}");
idx_verbatim = startsWith(str,"\begin{verbatim}");
idx_matlabcode = startsWith(str,"\begin{matlabcode}");

latexExpression = '\$[^$]*\$';
haslatex = contains(str,regexpPattern(latexExpression));
idx_matlaboutput = startsWith(str,"\begin{matlaboutput}") & ~haslatex;
idx_matlaboutputWithLatex = startsWith(str,"\begin{matlaboutput}") & haslatex;

idxLiteral = idx_lstlisting | idx_verbatim | idx_matlabcode | idx_matlaboutput;

str(idx_lstlisting) = newline + "```matlab:Code(Display)" + extractBetween(str(idx_lstlisting),...
    "\begin{lstlisting}","\end{lstlisting}") + "```" + newline;
str(idx_verbatim) = newline + "```matlab:Code(Display)" + extractBetween(str(idx_verbatim),...
    "\begin{verbatim}","\end{verbatim}") + "```" + newline;
str(idx_matlabcode) = "```matlab:Code" + extractBetween(str(idx_matlabcode),...
    "\begin{matlabcode}","\end{matlabcode}") + "```" + newline;
str(idx_matlaboutput) = "```text:Output" + extractBetween(str(idx_matlaboutput),...
    "\begin{matlaboutput}","\end{matlaboutput}") + "```" + newline;

str(idx_matlaboutputWithLatex) = extractBetween(str(idx_matlaboutputWithLatex),...
    "\begin{matlaboutput}"+newline,"\end{matlaboutput}");

