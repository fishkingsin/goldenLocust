//
//  Locust.h
//  goldenLocust
//
//  Created by Kong king sin on 19/9/14.
//
//
#pragma once

#include "ofMain.h"
#include "ofxAssimpModelLoader.h"
#include "ofxAnimatableFloat.h"
#include "ofxAnimatableOfPoint.h"
#include "ofxImageSequence.h"
#include "ofxQCAR.h"
class Locust
{
public:
    Locust();
    void setup(ofVec3f _pos ,ofVec3f _target,  ofxAssimpModelLoader* _model , ofTexture * _texture ,ofxImageSequence *_sequence);
    void setup(ofxAssimpModelLoader* _model , ofTexture * _texture ,ofxImageSequence *_sequence);
    void update(float dt);
    void draw();
    ofVec3f getPos();
    bool isDrawingModel();
    void destoried();
    void drawExplosion(ofxQCAR *qcar);
    float minRadius;
private:
    
    bool bSetup;
    ofVec3f start;
    ofVec3f target;
    ofVec3f dir;
    int stepToTarget;
    ofxAssimpModelLoader *model;
    ofTexture *texture;

    float angle;
    float bounce;
    ofxAnimatableOfPoint	 moveAnim;
    ofxAnimatableFloat explosionTimeline;
    ofxImageSequence *sequence;
    bool drawModel;
    
};
