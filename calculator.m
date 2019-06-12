function varargout = calculator(varargin)
% CALCULATOR MATLAB code for calculator.fig
%      CALCULATOR, by itself, creates a new CALCULATOR or raises the existing
%      singleton*.
%
%      H = CALCULATOR returns the handle to a new CALCULATOR or the handle to
%      the existing singleton*.
%
%      CALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALCULATOR.M with the given input arguments.
%
%      CALCULATOR('Property','Value',...) creates a new CALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calculator

% Last Modified by GUIDE v2.5 28-May-2019 23:43:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calculator_OpeningFcn, ...
                   'gui_OutputFcn',  @calculator_OutputFcn, ...
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


% --- Executes just before calculator is made visible.
function calculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calculator (see VARARGIN)

% Choose default command line output for calculator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% ha=axes('units','normalized','pos',[0 0 1 1]);
% 
%  uistack(ha,'down');
% 
%  ii=imread('beihang.png');
% 
% %设置程序的背景图为beijing1.jpg
% 
%  image(ii);
% 
%  colormap gray
% 
%  set(ha,'handlevisibility','off','visible','off');
% UIWAIT makes calculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




%--------------------工具函数区域---------------------------

%--------------------工具函数区域---------------------------

%--------------------工具函数区域---------------------------
%log函数计算??消除 log(0)的bug
function [back] =Log(x)
    if(x==0)
        back = 99;
    else
        back = log2(x);
    end


%后向概率计算
function [x_y] = Forword_probability(x,y_x)
    w = size(y_x,2);
    l = size(y_x,1);
    x_y = zeros(l,w);
    for n =1:w
        down = 0;
        for m = 1:l
            down = down+ x(m)*y_x(m,n);
        end
        for m = 1:l
            up =x(m)*y_x(m,n);
            x_y(m,n) = up/down;
        end
    end



%自信息量计算
function [sum] = Self_information(x)
    sum = zeros(1,size(x,1));
    for i = 1:length(x)
        sum(i) = ( -round(10* log2(x(i)))/10);
    end


%平均自信息量/信息熵计算
function [sum] =Information_entropy(x)
    sum = 0;
    for i = 1:length(x)
        sum = sum - x(i)*Log(x(i));
    end


%X-Y 条件信息熵/信道疑义度计算
function [sum] =Doubtful_degree(x,y_x)
    x_y = Forword_probability(x,y_x);
    w = size(y_x,2);
    l = size(y_x,1);
    sum = 0;
    for n =1:w
        for m = 1:l
            sum = sum -y_x(m,n)*x(m)*Log(x_y(m,n));
        end
    end


%Y-X 条件信息熵计算
function [sum] =Y_X_conditiona_entropy(x,y_x)
    w = size(y_x,2);
    l = size(y_x,1);
    sum = 0;
    for n =1:w
        for m = 1:l
            sum = sum -y_x(m,n)*x(m)*Log(y_x(m,n));
        end
    end


%Y-X 联合信息熵计算
function [sum] =Joint_entropy(x,y_x)
    w = size(y_x,2);
    l = size(y_x,1);
    sum = 0;
    for n =1:w
        for m = 1:l
            sum = sum -y_x(m,n)*x(m)*Log(y_x(m,n)*x(m));
        end
    end

    
function [output] =limit(input)
     flag = 100;
     output =zeros(size(input));
     if(size(input,1)==1)
            for m =1:size(input,1)
                output(m) =  ( round(flag*(input(m)))/flag);
            end
     else
          for m =1:size(input,1)
               for n =1:size(input,2)
                output(m,n) =  ( round(flag*(input(m,n)))/flag);
               end
          end
     end
    

%平均互信息量 / 原始信源信息熵- 信道疑义度计算
function [sum] =Average_Mutual_Information(x,y_x)
    sum = Information_entropy(x) - Doubtful_degree(x,y_x);


    
    

    

%--------------------工具函数区域---------------------------

%--------------------工具函数区域---------------------------

%--------------------工具函数区域---------------------------



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
X_temp = get(handles.edit1,'String');
P_temp =get(handles.edit2,'String');
X = eval(X_temp);
P = eval(P_temp);
y_x =P;
Y =  X*P;

%--------------------计算区-----------------------------
% disp('X自信息量')
SI=  Self_information(X);
% disp('X信息熵)
IE = Information_entropy(X);
% disp('后验概率')
FP = Forword_probability(X,y_x);
% disp('疑义度)
DD = Doubtful_degree(X,y_x);
% disp('Y|X条件熵)
CE = Y_X_conditiona_entropy(X,y_x);
% disp('联合熵)
JE = Joint_entropy(X,y_x);
% disp('平均互信息量')
AMI = Average_Mutual_Information(X,y_x);
%--------------------计算区----------------------------


%--------------------文本输出-----------------------------

% set(handles.text5,'string',sprintf('%.2f',X),'FontSize',12);
% set(handles.text6,'string',sprintf('%.2f',P),'FontSize',12);

set(handles.edit3,'string',[mat2str(SI)],'FontSize',12);
set(handles.edit4,'string',[num2str(IE),' | ',num2str(Information_entropy(Y))],'FontSize',12);
set(handles.edit5,'string',[mat2str(limit(FP))],'FontSize',12);
set(handles.edit6,'string',[num2str(limit(DD), '%.2f')],'FontSize',12);
set(handles.edit7,'string',[num2str(CE)],'FontSize',12);
set(handles.edit8,'string',[num2str(JE)],'FontSize',12);
set(handles.edit9,'string',[num2str(AMI)],'FontSize',12);
%--------------------文本输出-----------------------------



%--------------------维拉图-----------------------------
cla reset;
axes(handles.axes1);
axis([0 21 0 21]);
length1 =AMI+DD;
length2 =AMI+CE;
sumlength  = length2+length1-AMI;
%归一化
length1 = length1/sumlength*21;
length2=  length2/sumlength*21;
rectangle('position',[1 13 length1 5],'facecolor','r','Curvature',0.3,'LineWidth',2);
%H(X)绘制
text(1,19,'|<');
text(length1/2,19,'H(x)');
text(length1,19,'>|');
%H(X|Y)绘制
text(1,11,'|');
text((20-length2)/2,11,'H(X|Y)');
text(21-length2,11,'|');
%I(X,Y)绘制
text(21-length2,11,'|');
text((21-length2+length1)/2,11,'I(X|Y)');
text(length1+1,11,'|');
%H(Y|X)绘制
text(21-(21-length1)/2,11,'H(Y|X)');
text(20.5,11,'|');
%H(Y)绘制
text(21-length2,3,'|');
text(20-length2/2,3,'H(Y)');
text(20.5,3,'|');
%H(X,Y)绘制
text(1,1,'|');
text(21/2,1,'H(X,Y)');
text(20.5,1,'|');

rectangle('position',[21-length2 4 length2 5], 'facecolor','[0.019 0.376 0.31]','Curvature',0.3,'LineWidth',2);
grid on;

%--------------------维拉图-----------------------------
