
% Menggambar plot bar 
% Input berupa arrCount berupa array berukuran 256, plotTitle berupa judul
% untuk plot
% Output plotBar berupa plot bar
function resultPlot = plotBar(arrCount,plotTitle)
    arr256 = 0:255;
    resultPlot = bar(arr256,arrCount);
    resultPlot = title(plotTitle);
end
