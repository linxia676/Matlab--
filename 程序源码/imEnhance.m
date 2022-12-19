function varargout = imEnhance(varargin)
% IMENHANCE MATLAB code for imEnhance.fig
%      IMENHANCE, by itself, creates a new IMENHANCE or raises the existing
%      singleton*.
%
%      H = IMENHANCE returns the handle to a new IMENHANCE or the handle to
%      the existing singleton*.
%
%      IMENHANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMENHANCE.M with the given input arguments.
%
%      IMENHANCE('Property','Value',...) creates a new IMENHANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imEnhance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imEnhance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imEnhance

% Last Modified by GUIDE v2.5 18-Dec-2022 16:54:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imEnhance_OpeningFcn, ...
                   'gui_OutputFcn',  @imEnhance_OutputFcn, ...
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


% --- Executes just before imEnhance is made visible.
function imEnhance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imEnhance (see VARARGIN)

axes(handles.axes6);%获取轴区域句柄
x = -2 : 1 / 400 : 2;
y = abs(x .^ (2/3)) + (0.99 * (3.3 - x .^ 2) .^ (1/2)) .* sin(4 * pi * x);
plot(x, y, 'r');

% Choose default command line output for imEnhance
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imEnhance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imEnhance_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 声明要用到的全局变量
global Image_Original;
global Image_Gray;
global Latest_Image;

[filename,pathname]=uigetfile('*.*','打开图像'); 
filepath=[pathname filename];
Image_Original=imread(filepath); 

if size(Image_Original, 3)>2    % 判断是否为彩色图像
	Image_Gray = rgb2gray(Image_Original);  % 将彩色图像转换为灰度图像
else
	Image_Gray = Image_Original;
end
Latest_Image = Image_Gray;  % 保存最新图像，用于图片保存功能

axes(handles.axes1);%获取轴区域句柄
imshow(Image_Original);
title('原图像', 'Fontsize', 12);
axes(handles.axes2);%获取轴区域句柄
imhist(Latest_Image); 
title('图像直方图', 'Fontsize', 12);
axes(handles.axes3);%获取轴区域句柄
imshow(Image_Gray); 
title('灰度图', 'Fontsize', 12);
axes(handles.axes4);%获取轴区域句柄
imshow(Image_Gray);
title('灰度图', 'Fontsize', 12);
axes(handles.axes5);%获取轴区域句柄
imshow(Image_Gray);
title('灰度图', 'Fontsize', 12);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Latest_Image;
imwrite(Latest_Image,'result.jpg'); %默认保存在当前文件夹中

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_Original;%声明全局变量
global Image_Gray;
global Latest_Image;

if get(handles.radiobutton1,'value')
    radio_button = 1;
elseif get(handles.radiobutton2,'value')
    radio_button = 2;
elseif get(handles.radiobutton3,'value')
    radio_button = 3;
elseif get(handles.radiobutton5,'value')
    radio_button = 5;
elseif get(handles.radiobutton6,'value')
    radio_button = 6;
elseif get(handles.radiobutton7,'value')
    radio_button = 7;
end
switch (radio_button)
    case 1  % 灰度图像取反
        Inverse_Image = imcomplement(Image_Gray);
        Latest_Image = Inverse_Image;   % 保存最新图像，用于图片保存功能
        axes(handles.axes3);    % 获取轴区域句柄
        imshow(Inverse_Image);
        title('灰度图取反图像');
    case 2  % 彩色图像取反
        Color_Image(:,:,1)=255-Image_Original(:,:,1);
        Color_Image(:,:,2)=255-Image_Original(:,:,2);
        Color_Image(:,:,3)=255-Image_Original(:,:,3);
        Latest_Image = Color_Image;%保存最新图像，用于图片保存功能
        axes(handles.axes3);    % 获取轴区域句柄
        imshow(Color_Image);
        title('彩色图取反图像');
    case 3  % 直方图均衡化
        Histeq_Image = histeq(Image_Gray,16);
        axes(handles.axes3);    % 获取轴区域句柄
        imshow(Histeq_Image);
        Latest_Image = Histeq_Image;%保存最新图像，用于图片保存功能
        title('灰度图直方图均衡化');
        
%     case 4  % 直方图
%         axes(handles.axes3);%获取轴区域句柄
%         imhist(Latest_Image); 
%         title('图像直方图');
        
    case 5  % sobel算子锐化图像 
        Sobel_Image = edge(Image_Gray,'sobel'); %sobel算子锐化
        axes(handles.axes3);%获取轴区域句柄
        imshow(Sobel_Image);
        Latest_Image = Sobel_Image;%保存最新图像，用于图片保存功能
        title('sobel算子锐化灰度图像');
        
    case 6  % prewitt算子锐化图像
        Prewitt_Image = edge(Image_Gray,'prewitt'); %roberts算子锐化
        axes(handles.axes3);%获取轴区域句柄
        imshow(Prewitt_Image);
        Latest_Image = Prewitt_Image;%保存最新图像，用于图片保存功能
        title('prewitt算子锐化灰度图像');
        
    case 7  % roberts算子锐化图像
        Roberts_Image = edge(Image_Gray,'roberts'); %roberts算子锐化
        axes(handles.axes3);%获取轴区域句柄
        imshow(Roberts_Image);
        Latest_Image = Roberts_Image;%保存最新图像，用于图片保存功能
        title('roberts算子锐化灰度图像');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_Original;%再次声明全局变量
global Image_Gray;
global Latest_Image;
global noise_enable;
global Noise_Image;

if get(handles.radiobutton8,'value')
    radio_button = 1;
elseif get(handles.radiobutton9,'value')
    radio_button = 2;
elseif get(handles.radiobutton10,'value')
    radio_button = 3;
elseif get(handles.radiobutton11,'value')
    radio_button = 4;
end
switch radio_button
    case 1  % 高斯噪声
         Gaussian_Mean= str2num(get(handles.edit1,'String'));%均值
         Gaussian_Var= str2num(get(handles.edit2,'String'));%方差
         if(noise_enable == 1)%是否连续加入噪声
              Gaussian_Image = imnoise(Latest_Image,'gaussian',Gaussian_Mean,Gaussian_Var);%加入高斯噪声
         else%灰度图加入一次噪声
              Gaussian_Image = imnoise(Image_Gray,'gaussian',Gaussian_Mean,Gaussian_Var);%加入高斯噪声
         end
         Latest_Image = Gaussian_Image;%保存最新图像，用于图片保存功能
         axes(handles.axes4);%获取轴区域句柄
         imshow(Gaussian_Image);
         title('高斯噪声');
    case 2  % 椒盐噪声
         Salt_Density = str2num(get(handles.edit3,'String'));%均值
         if(noise_enable == 1)%是否连续加入噪声
            Salt_Image = imnoise(Latest_Image,'salt & pepper',Salt_Density);%加入椒盐噪声
         else
             Salt_Image = imnoise(Image_Gray,'salt & pepper',Salt_Density);%加入椒盐噪声
         end
         Latest_Image = Salt_Image;%保存最新图像，用于图片保存功能
         axes(handles.axes4);%获取轴区域句柄
         imshow(Salt_Image);
         title('椒盐噪声');
    case 3  % 泊松噪声
        Poisson_Probability= str2num(get(handles.edit4,'String'));%方差
         if(noise_enable == 1)%是否连续加入噪声
              Poisson_Image = imnoise(Latest_Image,'poisson');%加入泊松噪声
         else%灰度图加入一次噪声
              Poisson_Image = imnoise(Image_Gray,'poisson');%加入泊松噪声
         end
         Latest_Image = Poisson_Image;%保存最新图像，用于图片保存功能
         axes(handles.axes4);%获取轴区域句柄
         imshow(Poisson_Image);
         title('泊松噪声');
         
    case 4%乘性噪声
         Multiplicative_Var= str2num(get(handles.edit5,'String'));%方差
         if(noise_enable == 1)%是否连续加入噪声
             Multiplicative_Image = imnoise(Latest_Image,'speckle',Multiplicative_Var);%加入乘性噪声
         else
             Multiplicative_Image = imnoise(Image_Gray,'speckle',Multiplicative_Var);%加入乘性噪声
         end
         Latest_Image = Multiplicative_Image;%保存最新图像，用于图片保存功能
         axes(handles.axes4);%获取轴区域句柄
         imshow(Multiplicative_Image);
         title('乘性噪声');
end
Noise_Image = Latest_Image;

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noise_enable;
noise_enable = 0;
if ( get(hObject,'Value') )
    noise_enable = 1;
else
    noise_enable = 0;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox1



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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Image_Original;%再次声明全局变量
global Image_Gray;
global Latest_Image;
global filter_enable;
global Noise_Image;

if get(handles.radiobutton12,'value')
    radio_button = 1;
elseif get(handles.radiobutton13,'value')
    radio_button = 2;
elseif get(handles.radiobutton14,'value')
    radio_button = 3;
end

switch radio_button
    case 1  % 中值滤波
         Median_Num = str2num(get(handles.edit6,'String'));%中值模版大小
         if(filter_enable == 1)%是否连续加入噪声
              Median_Image = medfilt2(Latest_Image, [Median_Num Median_Num]);
         else%灰度图加入一次噪声
              Median_Image = medfilt2(Noise_Image, [Median_Num Median_Num]);
         end
         Latest_Image = Median_Image;%保存最新图像，用于图片保存功能
         axes(handles.axes5);%获取轴区域句柄
         imshow(Median_Image);
         title('中值滤波');
     case 2 % 均值滤波
         Medfilt_Num = str2num(get(handles.edit7,'String'));
         H = fspecial('average',[Medfilt_Num Medfilt_Num]);
         if(filter_enable == 1)%是否连续加入噪声
              Medfilt_Image = uint8(filter2(H, Latest_Image));
         else%灰度图加入一次噪声
              Medfilt_Image = uint8(filter2(H, Noise_Image));
         end
         Latest_Image = Medfilt_Image;%保存最新图像，用于图片保存功能
         axes(handles.axes5);%获取轴区域句柄
         imshow(Medfilt_Image);
         title('均值滤波');
       case 3   % 维纳滤波
         Wiener_Num = str2num(get(handles.edit8,'String'));
         if(filter_enable == 1)%是否连续加入噪声
              Wiener_Image = wiener2(Latest_Image, [Wiener_Num Wiener_Num]);
         else % 灰度图加入一次噪声
              Wiener_Image = wiener2(Noise_Image, [Wiener_Num Wiener_Num]);
         end
         Latest_Image = Wiener_Image;   % 保存最新图像，用于图片保存功能
         axes(handles.axes5);%获取轴区域句柄
         imshow(Wiener_Image);
         title('维纳滤波');
end

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global filter_enable;
filter_enable = 0;
if ( get(hObject,'Value') )
    filter_enable = 1;
else
    filter_enable = 0;
end


function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_Original;%声明全局变量
global Image_Gray;
global Latest_Image;
axes(handles.axes2);%获取轴区域句柄
imhist(Latest_Image); 
title('图像直方图');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_Gray;
global Latest_Image;
Latest_Image = Image_Gray;
axes(handles.axes2);%获取轴区域句柄
imhist(Latest_Image); 
title('图像直方图', 'Fontsize', 12);
axes(handles.axes3);%获取轴区域句柄
imshow(Image_Gray); 
title('灰度图', 'Fontsize', 12);
axes(handles.axes4);%获取轴区域句柄
imshow(Image_Gray);
axes(handles.axes5);%获取轴区域句柄
imshow(Image_Gray);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T = get(handles.slider1, 'value');
set(handles.text14, 'String', num2str(uint8(T)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Latest_Image;
global Image_Gray;

if get(handles.radiobutton18,'value') %人工选取阈值
    d0 = get(handles.slider1, 'value');
    Latest_Image = im2bw(Image_Gray, d0 / 255);
elseif get(handles.radiobutton19,'value') % Ostu法
    T = graythresh(Image_Gray);
    Latest_Image = im2bw(Image_Gray, T);
end
axes(handles.axes3);%获取轴区域句柄
imshow(Latest_Image);
title('人工选取阈值', 'Fontsize', 12);


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image_Original;%声明全局变量
global colour_enable;
global Latest_Image;
global Image_Gray;
angle = int16(get(handles.slider2, 'value'));
set(handles.text15, 'String', ['角度为',num2str(angle), '°']);
if (colour_enable == 1)
    Latest_Image = imrotate(Image_Original, angle, 'bicubic', 'loose');
else
    Latest_Image = imrotate(Image_Gray, angle, 'bicubic', 'loose');
end

axes(handles.axes4);%获取轴区域句柄
imshow(Latest_Image);
title('旋转后的图像', 'Fontsize', 12);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global colour_enable;
colour_enable = 0;
if ( get(hObject,'Value') )
    colour_enable = 1;
else
    colour_enable = 0;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes6);%获取轴区域句柄
a = get(handles.slider3 , 'Value');
if a < 11 % 参数小于11则显示爱心曲线
    x = -2 : 1 / 400 : 2;
    y = abs(x .^ (2/3)) + (0.99 * (3.3 - x .^ 2) .^ (1/2)) .* sin(a * pi * x);
    plot(x, y, 'r');
else % 参数大于11则显示三维爱心
    axes(handles.axes6);
    f=@(x,y,z)(x.^2+ (9./4).*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9./80).*y.^2.*z.^3;
    [x,y,z]=meshgrid(linspace(-3,3));
    val=f(x,y,z);
    [p,v]=isosurface(x,y,z,val,0);
    patch('faces',p,'vertices',v,'facevertexcdata',jet(size(v,1)),'facecolor','w','edgecolor','flat');
    view(3);grid on;axis equal;
    set(handles.text16, 'String', 'Designed by Hao_XL');
end


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
