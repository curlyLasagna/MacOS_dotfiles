$pdf_mode = 1;
$pdflatex = 'lualatex -shell-escape -file-line-error %O %S --interaction=nonstopmode -gg -synctex=1';
$out_dir = "out";
$pdf_previewer = 'open';
$clean_ext = 'pdfsync synctex.gz'
