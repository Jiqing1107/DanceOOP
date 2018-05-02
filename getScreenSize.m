% get screen size

function screensize = getScreenSize()
%With .Net:
% NET.addAssembly('System.Windows.Forms');
% rect = System.Windows.Forms.Screen.PrimaryScreen.Bounds;
% screensize = [rect.Width rect.Height];
% screensize = get(0,'ScreenSize');
% screensize = screensize(3:4);

%screensizes = get(0,'MonitorPositions');
%screensize = screensizes(1, 3:4);

%With java:
ge = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment;
gd = ge.getDefaultScreenDevice;
screensize = [gd.getDisplayMode.getWidth gd.getDisplayMode.getHeight]

end