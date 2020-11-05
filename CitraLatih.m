function varargout = CitraLatih(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CitraLatih_OpeningFcn, ...
                   'gui_OutputFcn',  @CitraLatih_OutputFcn, ...
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




function CitraLatih_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);





function varargout = CitraLatih_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function BROWSE_Callback(hObject, eventdata, handles)

image_folder = 'LATIH';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);





function Epoch_Callback(hObject, eventdata, handles)



function Epoch_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Goal_Callback(hObject, eventdata, handles)

function Goal_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton2_Callback(hObject, eventdata, handles)


image_folder = 'LATIH';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);


for n = 1:total_images
    full_name= fullfile(image_folder, filenames(n).name);
    I = imread(full_name);
    t = statxture(I,0.1);
    grayLevel(n) = t(1);
    averageContarst(n) = t(2);
    measureSmoothnes(n) = t(3);
    thirdMoment(n) = t(4);
    measureUni(n) = t(5);
    Entropy(n) = t(6);
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    sumR(n) = sum(sum(R));
    sumG(n) = sum(sum(G));
    sumB(n) = sum(sum(B));
end

%input citra 
%input 9 
input = [grayLevel;averageContarst;measureSmoothnes;thirdMoment;measureUni;Entropy;sumR;sumG;sumB];
target = zeros(1,60);
target(:,1:20)  = output(1);
target(:,21:40) = output(2);
target(:,41:60) = output(3);

net = newff(minmax(input),target,[10 3],{'logsig' 'purelin'},'trainlm');

net.trainParam.epochs = 5000 ;
net.trainParam.goal = 1e-6;
net = train(net,input,target);
output = round(sim(net,input));
save net.mat net

[m,n] = find(output==target);
akurasi = sum(m)/total_images*100;





