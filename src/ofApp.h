#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxAssimpModelLoader.h"
#include "ofxQCAR.h"
#include "Locust.h"
#include "ofxImageSequence.h"
#include "ofxQCAR.h"
#define MAX_LOCUST  50

class ofApp : public ofxiOSApp {
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    ofxAssimpModelLoader model;
    ofImage modelTexture;
    
    ofVec2f touchPoint;
    ofVec2f markerPoint;
    ofImage cameraImage;
    vector<Locust*> locusts;
    ofxImageSequence sequesce;
    ofLight light;
    float timeDiff;
    ofxiOSSoundPlayer soundPlayer;
    
    ofShader shader;

};


