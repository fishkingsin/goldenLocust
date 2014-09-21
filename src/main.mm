#include "ofMain.h"
#include "ofApp.h"
#include "ofAppiOSWindow.h"

int main(){
#if DEBUG
    bool bUseNative = true;
#else
    bool bUseNative = false;
#endif
	ofAppiOSWindow * window = new ofAppiOSWindow();
    window->enableDepthBuffer();
    window->enableRetina();
    window->enableRendererES2();

    if (bUseNative){

        ofSetupOpenGL(ofPtr<ofAppBaseWindow>(window), 1024,768, OF_FULLSCREEN);
        window->startAppWithDelegate("MainAppDelegate");
    }
    else{
        ofSetupOpenGL(window, 1024, 768, OF_FULLSCREEN);    // setup the GL context
        ofRunApp(new ofApp());                            // run app.

        
    }

    
    

}
