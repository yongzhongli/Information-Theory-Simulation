function varargout = DistortionlessSourceEncode(varargin)
% DISTORTIONLESSSOURCEENCODE MATLAB code for DistortionlessSourceEncode.fig
%      DISTORTIONLESSSOURCEENCODE, by itself, creates a new DISTORTIONLESSSOURCEENCODE or raises the existing
%      singleton*.
%
%      H = DISTORTIONLESSSOURCEENCODE returns the handle to a new DISTORTIONLESSSOURCEENCODE or the handle to
%      the existing singleton*.
%
%      DISTORTIONLESSSOURCEENCODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISTORTIONLESSSOURCEENCODE.M with the given input arguments.
%
%      DISTORTIONLESSSOURCEENCODE('Property','Value',...) creates a new DISTORTIONLESSSOURCEENCODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DistortionlessSourceEncode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DistortionlessSourceEncode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DistortionlessSourceEncode

% Last Modified by GUIDE v2.5 28-May-2019 15:32:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DistortionlessSourceEncode_OpeningFcn, ...
                   'gui_OutputFcn',  @DistortionlessSourceEncode_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DistortionlessSourceEncode is made visible.
function DistortionlessSourceEncode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DistortionlessSourceEncode (see VARARGIN)

% Choose preset command line output for DistortionlessSourceEncode
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

InitializeGUI(hObject, handles, false);

% UIWAIT makes DistortionlessSourceEncode wait for user response (see UIRESUME)
% uiwait(handles.DistortionlessSourceEncode);


% --- Outputs from this function are returned to the command line.
function varargout = DistortionlessSourceEncode_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get preset command line output from handles structure
varargout{1} = handles.output;

function InitializeGUI(hObject, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end
clc;
set(handles.CodeProb, 'data', cell(1, 1))
set(handles.SNCode, 'data', cell(1, 1))
set(handles.HFMCode, 'data', cell(1, 1))
set(handles.FNCode, 'data', cell(1, 1))
set(handles.Prob,'String', '');
set(handles.Symbol,'String', '');
set(handles.SNLen,'string', '');
set(handles.SNEta,'string', '');
set(handles.HFMLen,'string', '');
set(handles.HFMEta,'string', '');
set(handles.FNLen,'string', '');
set(handles.FNEta,'string', '');
set(handles.RHuffman,'string', 'r');

% Update handles structure
guidata(hObject, handles);


function Symbol_Callback(hObject, eventdata, handles)
% hObject    handle to Symbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Symbol as text
%        str2double(get(hObject,'String')) returns contents of Symbol as a double


% --- Executes during object creation, after setting all properties.
function Symbol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Symbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Prob_Callback(hObject, eventdata, handles)
% hObject    handle to Prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Prob as text
%        str2double(get(hObject,'String')) returns contents of Prob as a double


% --- Executes during object creation, after setting all properties.
function Prob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Prob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddSymbol.
function AddSymbol_Callback(hObject, eventdata, handles)
% hObject    handle to AddSymbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.CodeProb,'data');
len = size(tableData, 1);
Prob = str2double(get(handles.Prob,'String'));
if (~isnan(Prob))
% ≈–∂œ ‰»ÎŒ™ ˝◊÷
    if((Prob <= 1) && (Prob > 0))
        if(len < 1)
            tableData{len + 1, 1} = Prob;
        elseif(isempty(tableData{len, 1}))
            tableData{len, 1} = Prob;
        else
            tableData{len + 1, 1} = Prob;
        end
        probData = cell2mat(tableData);
        sortData = sort(probData, 'descend');
        for i = 1 : size(tableData, 1)
            tableData{i, 1} = sortData(i, 1);
        end
        set(handles.CodeProb,'data',tableData);
    else
        errdig = errordlg('«Î ‰»Î’˝»∑µƒ∏≈¬ £∫(0, 1]','Warning', 'modal');
        strdig = findobj(errdig, 'tag', 'MessageBox');
        set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
    end
else
    errdig = errordlg('«Î ‰»Î ˝◊÷£°','Warning', 'modal');
    strdig = findobj(errdig, 'tag', 'MessageBox');
    set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
end

% --- Executes on button press in DeleteSymbol.
function DeleteSymbol_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteSymbol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tableData = get(handles.CodeProb,'data');
len = size(tableData, 1);
Num = str2double(get(handles.Symbol,'String'));
if (~isnan(Num))
% ≈–∂œ ‰»ÎŒ™ ˝◊÷
    if((Num <= len) && (Num > 0))
        for i = 1 : (len - 1)
            if(i >= Num)
                tableData{i, 1} = tableData{i + 1, 1};
            end
        end
        tableData = tableData(1 : len - 1, 1);
        set(handles.CodeProb,'data',tableData);
    else
        errdig = errordlg('«Î ‰»Î’˝»∑µƒ–Ú∫≈£°','Warning', 'modal');
        strdig = findobj(errdig, 'tag', 'MessageBox');
        set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
    end
else
    errdig = errordlg('«Î ‰»Î–Ú∫≈£°','Warning', 'modal');
    strdig = findobj(errdig, 'tag', 'MessageBox');
    set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
end


function SNLen_Callback(hObject, eventdata, handles)
% hObject    handle to SNLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNLen as text
%        str2double(get(hObject,'String')) returns contents of SNLen as a double


% --- Executes during object creation, after setting all properties.
function SNLen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HFMLen_Callback(hObject, eventdata, handles)
% hObject    handle to HFMLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HFMLen as text
%        str2double(get(hObject,'String')) returns contents of HFMLen as a double


% --- Executes during object creation, after setting all properties.
function HFMLen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HFMLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FNLen_Callback(hObject, eventdata, handles)
% hObject    handle to FNLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FNLen as text
%        str2double(get(hObject,'String')) returns contents of FNLen as a double


% --- Executes during object creation, after setting all properties.
function FNLen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FNLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SNEta_Callback(hObject, eventdata, handles)
% hObject    handle to SNEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SNEta as text
%        str2double(get(hObject,'String')) returns contents of SNEta as a double


% --- Executes during object creation, after setting all properties.
function SNEta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HFMEta_Callback(hObject, eventdata, handles)
% hObject    handle to HFMEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HFMEta as text
%        str2double(get(hObject,'String')) returns contents of HFMEta as a double


% --- Executes during object creation, after setting all properties.
function HFMEta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HFMEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FNEta_Callback(hObject, eventdata, handles)
% hObject    handle to FNEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FNEta as text
%        str2double(get(hObject,'String')) returns contents of FNEta as a double


% --- Executes during object creation, after setting all properties.
function FNEta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FNEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
probData = get(handles.CodeProb,'data');
Prob = cell2mat(probData);
Prob = reshape(Prob, 1, size(Prob, 1));
r = str2double(get(handles.RHuffman,'String'));

if( (abs(sum(Prob) - 1) <= 1e-12) && (isempty(find(Prob < 0, 1))) )
% ∏≈¬ ºÏ≤È
    if(~isnan(r) && (r == int32(r)) && (r ~= 1))
        [SNCode, SNLen, SNEta] = ShannonEncode(Prob);
        set(handles.SNCode,'data',SNCode);
        set(handles.SNLen,'string',num2str(SNLen, '%.2f'));
        set(handles.SNEta,'string',strcat(num2str(SNEta * 100, '%.1f'), '%'));
        [HFMCode, HFMLen, HFMEta] = HuffmanEncode(Prob, r);
        set(handles.HFMCode,'data',HFMCode);
        set(handles.HFMLen,'string',num2str(HFMLen, '%.2f'));
        set(handles.HFMEta,'string',strcat(num2str(HFMEta * 100, '%.1f'), '%'));
        [FNCode, FNLen, FNEta] = FanoEncode(Prob);
        set(handles.FNCode,'data',FNCode);
        set(handles.FNLen,'string',num2str(FNLen, '%.2f'));
        set(handles.FNEta,'string',strcat(num2str(FNEta * 100, '%.1f'), '%'));
    else
        warndig = warndlg('r ‰»Î”–ŒÛ£¨ƒ¨»œ2‘™ªÙ∑Ú¬¸±‡¬Î','Warning');
        strdig = findobj(warndig, 'tag', 'MessageBox');
        set(strdig,'FontSize',10, 'FontName','Œ¢»Ì—≈∫⁄');
        
        r = 2;
        [SNCode, SNLen, SNEta] = ShannonEncode(Prob);
        set(handles.SNCode,'data',SNCode);
        set(handles.SNLen,'string',num2str(SNLen, '%.2f'));
        set(handles.SNEta,'string',strcat(num2str(SNEta * 100, '%.1f'), '%'));
        [HFMCode, HFMLen, HFMEta] = HuffmanEncode(Prob, r);
        set(handles.HFMCode,'data',HFMCode);
        set(handles.HFMLen,'string',num2str(HFMLen, '%.2f'));
        set(handles.HFMEta,'string',strcat(num2str(HFMEta * 100, '%.1f'), '%'));
        [FNCode, FNLen, FNEta] = FanoEncode(Prob);
        set(handles.FNCode,'data',FNCode);
        set(handles.FNLen,'string',num2str(FNLen, '%.2f'));
        set(handles.FNEta,'string',strcat(num2str(FNEta * 100, '%.1f'), '%'));
    end
else
    errdig = errordlg('∏≈¬  ‰»Î”–ŒÛ£°«ÎºÏ≤È°£','Warning', 'modal');
    strdig = findobj(errdig, 'tag', 'MessageBox');
    set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
end

% --- Executes on button press in Preset.
function Preset_Callback(hObject, eventdata, handles)
% hObject    handle to Preset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Prob = [0.2, 0.19, 0.18, 0.17, 0.15, 0.10, 0.01];
tableData = cell(length(Prob), 1);
for i = 1 : length(Prob)
    tableData{i, 1} = Prob(i);
end
set(handles.CodeProb,'data',tableData);


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InitializeGUI(hObject, handles, false);


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes during object creation, after setting all properties.
function CodeProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNCode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes during object creation, after setting all properties.
function DistortionlessSourceEncode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNEta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


% --- Executes during object creation, after setting all properties.
function SNCode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SNCode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function HFMCode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HFMCode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function FNCode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FNCode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function RHuffman_Callback(hObject, eventdata, handles)
% hObject    handle to RHuffman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RHuffman as text
%        str2double(get(hObject,'String')) returns contents of RHuffman as a double


% --- Executes during object creation, after setting all properties.
function RHuffman_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RHuffman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Huffman.
function Huffman_Callback(hObject, eventdata, handles)
% hObject    handle to Huffman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
probData = get(handles.CodeProb,'data');
Prob = cell2mat(probData);
Prob = reshape(Prob, 1, size(Prob, 1));
r = str2double(get(handles.RHuffman,'String'));
if( (abs(sum(Prob) - 1) <= 1e-12) && (isempty(find(Prob < 0, 1))) )
% ∏≈¬ ºÏ≤È
    if(~isnan(r) && (r == int32(r)) && (r ~= 1))
        open('Huffman.fig');
        h = guihandles;
        
        set(h.HFM, 'string', strcat(num2str(r), '‘™ªÙ∑Ú¬¸±‡¬Îπ˝≥Ã'));
        setappdata(0, 'Prob', Prob);        % ¥´÷µ
        setappdata(0, 'RHuffman', r);
        setappdata(0, 'NumHuffman', NaN);
        setappdata(0, 'Temp', false);
        
        [HFMCode, HFMLen, HFMEta] = HuffmanEncode(Prob, r);
        set(handles.HFMCode,'data',HFMCode);
        set(handles.HFMLen,'string',num2str(HFMLen, '%.2f'));
        set(handles.HFMEta,'string',strcat(num2str(HFMEta * 100, '%.1f'), '%'));
    else
        warndig = warndlg('r ‰»Î”–ŒÛ£¨ƒ¨»œ∂˛‘™ªÙ∑Ú¬¸±‡¬Î°£','Warning');
        strdig = findobj(warndig, 'tag', 'MessageBox');
        set(strdig,'FontSize',10, 'FontName','Œ¢»Ì—≈∫⁄');
        
        r = 2;
        open('Huffman.fig');
        h = guihandles;
        
        set(h.HFM, 'string', strcat(num2str(r), '‘™ªÙ∑Ú¬¸±‡¬Îπ˝≥Ã'));
        setappdata(0, 'Prob', Prob);        % ¥´÷µ
        setappdata(0, 'RHuffman', r);
        setappdata(0, 'NumHuffman', NaN);
        
        [HFMCode, HFMLen, HFMEta] = HuffmanEncode(Prob, r);
        set(handles.HFMCode,'data',HFMCode);
        set(handles.HFMLen,'string',num2str(HFMLen, '%.2f'));
        set(handles.HFMEta,'string',strcat(num2str(HFMEta * 100, '%.1f'), '%'));
    end
else
    errdig = errordlg('∏≈¬  ‰»Î”–ŒÛ£°«ÎºÏ≤È°£','Warning', 'modal');
    strdig = findobj(errdig, 'tag', 'MessageBox');
    set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
end


% --- Executes on button press in Fano.
function Fano_Callback(hObject, eventdata, handles)
% hObject    handle to Fano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
probData = get(handles.CodeProb,'data');
Prob = cell2mat(probData);
Prob = reshape(Prob, 1, size(Prob, 1));

if( (abs(sum(Prob) - 1) <= 1e-12) && (isempty(find(Prob < 0, 1))) )
% ∏≈¬ ºÏ≤È
    open('Fano.fig');
    h = guihandles;

    set(h.FN, 'string', '∑—≈µ±‡¬Îπ˝≥Ã');
    setappdata(0, 'Prob', Prob);        % ¥´÷µ
    setappdata(0, 'NumFano', NaN);

    [FNCode, FNLen, FNEta] = FanoEncode(Prob);
    set(handles.FNCode,'data',FNCode);
    set(handles.FNLen,'string',num2str(FNLen, '%.2f'));
    set(handles.FNEta,'string',strcat(num2str(FNEta * 100, '%.1f'), '%'));
else
    errdig = errordlg('∏≈¬  ‰»Î”–ŒÛ£°«ÎºÏ≤È°£','Warning', 'modal');
    strdig = findobj(errdig, 'tag', 'MessageBox');
    set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
end


% --- Executes on button press in Shannon.
function Shannon_Callback(hObject, eventdata, handles)
% hObject    handle to Shannon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
probData = get(handles.CodeProb,'data');
Prob = cell2mat(probData);
Prob = reshape(Prob, 1, size(Prob, 1));

if( (abs(sum(Prob) - 1) <= 1e-12) && (isempty(find(Prob < 0, 1))) )
% ∏≈¬ ºÏ≤È
    [SNCode, SNLen, SNEta] = ShannonEncode(Prob);
    set(handles.SNCode,'data',SNCode);
    set(handles.SNLen,'string',num2str(SNLen, '%.2f'));
    set(handles.SNEta,'string',strcat(num2str(SNEta * 100, '%.1f'), '%'));
else
    errdig = errordlg('∏≈¬  ‰»Î”–ŒÛ£°«ÎºÏ≤È°£','Warning', 'modal');
    strdig = findobj(errdig, 'tag', 'MessageBox');
    set(strdig,'FontSize',12, 'FontName','Œ¢»Ì—≈∫⁄');
end
