function [ output_args ] = Table2TeX( varargin )
% Table2TeX 
% Converts Table to TeX.
% Input arguments are outputfilename,TableData, TitleData, Formatting of TableData
%   
switch nargin
    case 3
        outputFileName = varargin(1);
        tableData = varargin(2);
        noCols = length(tableData(1,:));
        noRows = length(tableData{noCols}(:));
        titleData = varargin{3};
        formatString = cell(repmat({'%s'},1,noCols));
        tableCaption = 'Table caption';
        tableLabel = 'tab : Table label';
    case 4
        outputFileName = varargin(1);
        tableData = varargin{2};
        noCols = length(tableData(1,:));
        noRows = length(tableData(:,1));
        titleData = varargin{3};
        formatString = varargin(4);
        tableCaption = 'Table caption';
        tableLabel = 'tab : Table label';
    case 5
        outputFileName = varargin(1);
        tableData = varargin(2);
        noCols = length(tableData(1,:));
        noRows = length(tableData{noCols}(:));
        titleData = varargin{3};
        formatString = varargin(4);
        tableCaption = varargin(5);
        tableLabel = 'tab : Table label';
    case 6
        outputFileName = varargin(1);
        tableData = varargin(2);
        noCols = length(tableData(1,:));
        noRows = length(tableData{noCols}(:));
        titleData = varargin{3};
        formatString = varargin(4);
        tableCaption = varargin(5);
        tableLabel = varargin(6);
    otherwise 
        display('Unexpected inputs')
end


mainDir = pwd;

%%
row = 1;
col = 1;
if (length(formatString{1}) ~= length(tableData(1,:)))
    display('Error in format string length')
    return;
end

display(fullfile([mainDir filesep char(outputFileName) '.tex']))

FID = fopen([mainDir filesep char(outputFileName) '.tex'], 'w');

fprintf(FID,'\\begin{table}\n');
fprintf(FID,'\\centering \n');
fprintf(FID, '%s' ,['\caption {' tableCaption '} \label{tab:' tableLabel '}' ]); 
fprintf(FID,'\n');
fprintf(FID, '%s' ,['\begin{tabular}{|' repmat('c',1,noCols) '|} \hline']);
fprintf(FID,'\n');

col=1;
fprintf(FID, '%s', titleData{col});
for col=2:noCols
    fprintf(FID, '%s', ['& ' titleData{col}]);
end

fprintf(FID, '\\\\ \\hline \n');

for row=1:noRows
    col=1;
%    if(iscell( tableData{col}(row,:) ))
%    fprintf(FID, formatString{1}{col}, tableData{col}{row,:});
%    else
    fprintf(FID, formatString{1}{col}, tableData{row,col});
%    end
    for col=2:noCols
%        if(iscell( tableData{col}(row,:) ))
%            fprintf(FID, ['&' formatString{1}{col}], tableData{col}{row,:});
%        else
            fprintf(FID, ['&' formatString{1}{col}], tableData{row,col});            
%        end
    end
    fprintf(FID, ' \\\\ \n');
end

fprintf(FID, '\\hline \n');

fprintf(FID, '\\end{tabular}\n');
fprintf(FID, '\\end{table}\n');
fclose(FID);

end

