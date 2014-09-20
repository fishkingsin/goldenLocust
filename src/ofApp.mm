#include "ofApp.h"
static float const markerWidth = 1188;
static float const markerHeight = 897;
//--------------------------------------------------------------
void ofApp::setup(){
    ofDisableArbTex(); // we need GL_TEXTURE_2D for our models coords.
    model.loadModel("goldenlocust.obj", true);
    modelTexture.loadImage("goldenlocust.png");
    ofxQCAR * qcar = ofxQCAR::getInstance();
    qcar->addTarget("HongKongMAp.xml", "HongKongMAp.xml");
    qcar->autoFocusOn();
    qcar->setCameraPixelsFlag(true);
    qcar->setup();

    sequesce.loadSequence("explosion");

    timeDiff = 0;
    soundPlayer.loadSound("explosion.wav");
    soundPlayer.setMultiPlay(true);
}

//--------------------------------------------------------------
void ofApp::update(){
    ofxQCAR * qcar = ofxQCAR::getInstance();
    qcar->update();
    if(qcar->hasFoundMarker()) {
        float dt = 1.0f / ofGetFrameRate();
        for(int i = 0; i < locusts.size() ; i++)
        {
            locusts[i]->update(dt);
        }
        float diff = ofGetElapsedTimeMillis() -timeDiff;
        if (diff>1500) {
            if(locusts.size()<MAX_LOCUST)
            {
                Locust * locust = new Locust();
                locust->setup(ofVec3f(ofRandom(-markerWidth*0.5,markerWidth*0.5) , ofRandom(markerHeight*2,markerHeight*4)),
                              ofVec3f(ofRandom(-markerWidth*0.5,markerWidth*0.5) , ofRandom(-markerHeight*0.5,markerHeight*0.5)),
                              &model,
                              &modelTexture.getTextureReference(),
                              &sequesce);
                locusts.push_back(locust);
            }
            timeDiff = ofGetElapsedTimeMillis();
        }
    }
    else
    {
        timeDiff = ofGetElapsedTimeMillis();
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    ofxQCAR * qcar = ofxQCAR::getInstance();
    qcar->draw();
    
    bool bPressed;
    bPressed = touchPoint.x >= 0 && touchPoint.y >= 0;
    
    if(qcar->hasFoundMarker()) {
        
        ofDisableDepthTest();
        ofEnableBlendMode(OF_BLENDMODE_ALPHA);
        ofSetLineWidth(3);
#if DEBUG
        bool bInside = false;
        if(bPressed) {
            vector<ofPoint> markerPoly;
            markerPoly.push_back(qcar->getMarkerCorner((ofxQCAR_MarkerCorner)0));
            markerPoly.push_back(qcar->getMarkerCorner((ofxQCAR_MarkerCorner)1));
            markerPoly.push_back(qcar->getMarkerCorner((ofxQCAR_MarkerCorner)2));
            markerPoly.push_back(qcar->getMarkerCorner((ofxQCAR_MarkerCorner)3));
            bInside = ofInsidePoly(touchPoint, markerPoly);
        }
        
        ofSetColor(ofColor(255, 0, 255, bInside ? 150 : 50));
        qcar->drawMarkerRect();
        
        ofSetColor(ofColor::yellow);
        qcar->drawMarkerBounds();
        ofSetColor(ofColor::cyan);
        qcar->drawMarkerCenter();
        qcar->drawMarkerCorners();
#endif
        ofSetColor(ofColor::white);
        ofSetLineWidth(1);
        
        ofEnableDepthTest();
        ofEnableNormalizedTexCoords();
        
        qcar->begin();
        glShadeModel(GL_SMOOTH);
        ofEnableSeparateSpecularLight();
        light.enable();
        for(int i = 0; i < locusts.size() ; i++)
        {
            ofPushStyle();
            if(ofDist(markerPoint.x,markerPoint.y,locusts[i]->getPos().x,locusts[i]->getPos().y)<locusts[i]->minRadius)
            {
                ofSetColor(255,0,0);
            }
            else{
                ofSetColor(ofColor::white);
            }
            locusts[i]->draw();
            ofPopStyle();
        }
        light.disable();
        ofDisableLighting();
        ofDisableSeparateSpecularLight();
        
        qcar->end();
        
        ofDisableNormalizedTexCoords();
        
        qcar->begin();
#if DEBUG
        ofNoFill();
        ofSetColor(255, 0, 0, 200);
        ofSetLineWidth(6);
        float radius = 20;
        ofPushMatrix();
        ofTranslate(markerPoint.x, markerPoint.y);
        ofCircle(0, 0, radius);
        ofLine(-radius, 0, radius, 0);
        ofLine(0, -radius, 0, radius);
        ofPopMatrix();
        ofFill();
        ofSetColor(255);
#endif
        ofSetLineWidth(1);
        qcar->end();
    }
    
    ofDisableDepthTest();
#if DEBUG
    /**
     *  access to camera pixels.
     */
    int cameraW = qcar->getCameraWidth();
    int cameraH = qcar->getCameraHeight();
    unsigned char * cameraPixels = qcar->getCameraPixels();
    if(cameraW > 0 && cameraH > 0 && cameraPixels != NULL) {
        if(cameraImage.isAllocated() == false ) {
            cameraImage.allocate(cameraW, cameraH, OF_IMAGE_GRAYSCALE);
        }
        cameraImage.setFromPixels(cameraPixels, cameraW, cameraH, OF_IMAGE_GRAYSCALE);
        if(qcar->getOrientation() == OFX_QCAR_ORIENTATION_PORTRAIT) {
            cameraImage.rotate90(1);
        } else if(qcar->getOrientation() == OFX_QCAR_ORIENTATION_LANDSCAPE) {
            cameraImage.mirror(true, true);
        }
        
        cameraW = cameraImage.getWidth() * 0.5;
        cameraH = cameraImage.getHeight() * 0.5;
        int cameraX = 0;
        int cameraY = ofGetHeight() - cameraH;
        cameraImage.draw(cameraX, cameraY, cameraW, cameraH);
        
        ofPushStyle();
        ofSetColor(ofColor::white);
        ofNoFill();
        ofSetLineWidth(3);
        ofRect(cameraX, cameraY, cameraW, cameraH);
        ofPopStyle();
    }
#endif
    for(int i = 0; i < locusts.size() ; i++)
    {
        
        locusts[i]->drawExplosion(qcar);
    }

}

//--------------------------------------------------------------
void ofApp::exit(){
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touchPoint.set(touch.x, touch.y);
    markerPoint = ofxQCAR::getInstance()->screenPointToMarkerPoint(ofVec2f(touch.x, touch.y));
    for(int i = 0; i < locusts.size() ; i++)
    {
        if(ofDist(markerPoint.x,markerPoint.y,locusts[i]->getPos().x,locusts[i]->getPos().y)<locusts[i]->minRadius)
        {
            if(locusts[i]->isDrawingModel())
            {
                locusts[i]->destoried();
                soundPlayer.play();
                timeDiff = ofGetElapsedTimeMillis();
            }
        }

    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    touchPoint.set(touch.x, touch.y);
    markerPoint = ofxQCAR::getInstance()->screenPointToMarkerPoint(ofVec2f(touch.x, touch.y));
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    touchPoint.set(-1, -1);
    markerPoint = ofxQCAR::getInstance()->screenPointToMarkerPoint(ofVec2f(touch.x, touch.y));
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
}
