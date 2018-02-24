img = noiseImgGeneration(getScreenSize());
fullscreen(img, 1);
hframe = handle(frame_java, 'CallbackProperties');
set(hframe, 'KeyPressedCallback', @callback_hframe);
get(hframe)
% closescreen();