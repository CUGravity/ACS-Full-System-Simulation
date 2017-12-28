function updateTetherProps(muxIn)
%% Need to tell MATLAB to exclude these commands from code building
coder.extrinsic('set_param');
coder.extrinsic('getSimulinkBlockHandle')
coder.extrinsic('num2str');
coder.extrinsic('cell2mat');
coder.extrinsic('strcat');

%% Extract muxed input 
numLinks = muxIn(1);
L = muxIn(2);
deltaL = muxIn(3);
AE = muxIn(4); % Specific stiffness in k=A*E/L
kd = muxIn(5); % Specific damping
if(length(muxIn) > 5)
    time = muxIn(6);
end

%% Calculate new tether link properties 
% L_total = L + deltaL;
link_k = AE / (L / numLinks); %Lumped
% stiffness of one link in the tether. Changes as tether unreels.
link_c = kd; %Discretized axial damping TBD

%% Update all model link parameters
% Find the block handles for the tethers to be updated
% rootStr = 'Main/Dynamics Configurable System1/Three Link Simscape Model';
% rootStr = 'SimMainLibrary/Extendable Tether Link'; %CHANGE WITH FILE
% teth1Str = strcat(rootStr,'/','N-link Extendable Tether'); %CHANGE WITH FILE
% teth1Hand = getSimulinkBlockHandle(teth1Str);
% 
% linkBlocks = get(teth1Hand,'Blocks');
% linkCells = linkBlocks(contains(linkBlocks,'Extendable Tether Link'));
% nLinks = length(linkCells);
% for i = 1:nLinks %Should be nLinks, but doesn't run with it. Need to fix.
%     linkNameStr = cell2mat(linkCells(i));
    linkStr = 'SimMainLibrary/Extendable Tether Link';
    linkHand = getSimulinkBlockHandle(linkStr);
    innerBlocks = get(linkHand,'Blocks');
    teleInd = contains(innerBlocks,'Telescoping');
    teleStr = cell2mat(innerBlocks(teleInd));
    teleHand = getSimulinkBlockHandle(strcat(linkStr,'/',teleStr));
%     set_param(teleHand,'PzSpringStiffness', num2str(link_k));
% end

if(deltaL ~= 0)
    fprintf('\ndeltaL = %.2f\tL = %.2t', deltaL, L);
    if(length(muxIn) > 5)
        fprintf('Time = %.7f', time);
    end
end