function f = eed(f, timeStep, nosteps, verbose, W, m, K, cm)
% Edge Enhancing Diffusion 
% f: The input image.
% timeStep: Time step size for the diffusion process.
% nosteps: Number of diffusion iterations to perform.
% verbose: A flag indicating whether to display intermediate results.
% W: A parameter sigma used for the Gaussian Kernel.
% m ,K, cm: A parameter used to calculate eigenvalue lambda 1.

if verbose
    figure(verbose);
    subplot(1, 2, 1);
    imshow(f);
    title('Original Image');
    drawnow;
end
% Initialize Dimensions
[n, m] = size(f);
%nosteps=n*m;

for iter = 1:nosteps %Diffusion Loop

   % g=gD(f,0.001,0,0); % Apply this for Catte et al model
   % gx=gD(f,1,1,0);
   % gy=gD(f,1,0,1);
   
   %Gradient Calculation
    gx=gD(f, W, 1, 0);
    gy=gD(f, W, 0, 1);
    g = gx+gy* 1i;
    gu = g * 1i;
   
   % Initialization of Matrices
    d11 = zeros(n, m);
    d12 = zeros(n, m);
    d22 = zeros(n, m);
    
  % EED diffusion Tensor Calculation
    for j = 1:n
        for k = 1:m           
            g1 = [real(g(j,k)); imag(g(j,k))];
            g2 = [real(gu(j,k)); imag(gu(j,k))];
            
            v1 = g1 / norm(g1);
            v2 = g2 / norm(g1);
            
            s = norm(g1)^2;
            lambda1 = 1 - exp(-cm ./ (s/K).^m);
            lambda2 = 1;
            
            d = [v1, v2] * diag([lambda1, lambda2]) * [v1'; v2'];

            d11(j,k) = d(1,1);
            d12(j,k) = d(1,2);
            d22(j,k) = d(2,2);
            
        end
    end
    % With  Weickert standard explicit scheme
     % f=f+stepsize*snldStep(f,c,W,ip);

 % Diffusion Step
    div_flux = tnldStep(f, d11, d12, d22, 1);
    f = f + timeStep * div_flux;
    
% Display Updated Image 
    if verbose
        figure(verbose);
        subplot(1,2,2);
        imshow(f);
        title('Edge Enhancing Diffusion');
        drawnow;
    end
end