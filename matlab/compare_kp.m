% Compare Forrest's Matlab-based implementation vs my C++ code:

% clear all; close all;

rayfile = '/shared/users/asousa/WIPP/3dWIPP/outputs/one_ray.ray';
c_path = '/shared/users/asousa/WIPP/3dWIPP/damping/';
c_outfile = '/shared/users/asousa/WIPP/3dWIPP/outputs/c_damping.ray';
c_mode = 1;  % 0 = ngo, 1 = Foust
mat_path = pwd;
AE_level = [1 3];
Kp = [0, 4, 8];


% Run Matlab version:

% ray_pwr_matlab = damp_single('rayfile',rayfile,'DEBUGGING', 'True','steplength',0.1);


% % Run C++ version:
% disp('Compiling C version...');
% cd(c_path);
% system('make');


% for (aa = 1:length(AE_level))
%     for (kk = 1:length(Kp))
%         c_outfile = sprintf('/shared/users/asousa/WIPP/3dWIPP/outputs/c_damping_kp%d_ae%d.ray',Kp(kk),AE_level(aa));
%         c_cmd = sprintf('bin/damping -i %s -o %s -a %d -k %d -m %d',rayfile, c_outfile, AE_level(aa), Kp(kk), c_mode);

%         system(c_cmd);
%     end
% end

cd(mat_path);

% Load c results:

% cdata = readrayoutput(c_outfile);

figure(1);
hold on;

% mags = zeros(length(cdata{1}.time),length(Kp)*length(AE_level));
for (aa = 1:length(AE_level))
    for (kk = 1:length(Kp))
        c_outfile = sprintf('/shared/users/asousa/WIPP/3dWIPP/outputs/c_damping_kp%d_ae%d.ray',Kp(kk),AE_level(aa));
        cdata = readrayoutput(c_outfile);
        % mags(:, kk) = cdata{1}.damping;
        plot(cdata{1}.time, cdata{1}.damping, 'color',rand(1,3),'lineWidth',3);
        text(cdata{1}.time(end), cdata{1}.damping(end),sprintf('Kp= %d, Ae= %d',Kp(kk), AE_level(aa)));
    end;
end
grid on;
xlabel('Time (sec)');
ylabel('Relative power');
ylim([0 1]);