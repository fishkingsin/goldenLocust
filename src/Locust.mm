//
//  Locust.cpp
//  goldenLocust
//
//  Created by Kong king sin on 19/9/14.
//
//

#include "Locust.h"
Locust::Locust()
{
    bSetup = false;
    model = NULL;
    texture = NULL;
    drawModel = true;
}
void Locust::setup(ofVec3f _pos ,ofVec3f _target,  ofxAssimpModelLoader* _model , ofTexture * _texture, ofxImageSequence *_sequence){
    start = _pos;
    target = _target;
    moveAnim.setPosition(start);
    setup(_model,_texture, _sequence);
}
void Locust::setup(ofxAssimpModelLoader *_model , ofTexture *_texture, ofxImageSequence *_sequence)
{
    model = _model;
    texture = _texture;
    sequence = _sequence;
    bSetup = true;
    angle = atan2(target.x-moveAnim.getCurrentPosition().x, target.y-moveAnim.getCurrentPosition().y) * 180 / PI;
    bounce = 0;
    minRadius = 200;
    
    moveAnim.setRepeatType(PLAY_ONCE);
	moveAnim.setCurve(EASE_IN_EASE_OUT);
    stepToTarget = ofRandom(20, 50);
    dir = (target-start)/stepToTarget;
    
}
void Locust::update(float dt)
{
    if(!bSetup)
        return;
    
    if(drawModel)
    {
        moveAnim.update( dt );
        
        float duration  = ofRandomf()*0.5;
        bounce = 50 * sin(moveAnim.getPercentDone()*PI);
        if(ofDist(moveAnim.getCurrentPosition().x,moveAnim.getCurrentPosition().y,target.x,target.y)>10)
        {
            if ( !moveAnim.isOrWillBeAnimating() ){
                ofVec3f pos = moveAnim.getCurrentPosition()+dir;
                moveAnim.setDuration(duration);
                moveAnim.animateToAfterDelay( pos, 0.5);
                angle = atan2(target.x-moveAnim.getCurrentPosition().x, target.y-moveAnim.getCurrentPosition().y) * 180 / PI;
                
            }
            
        }
    }
    else{
        explosionTimeline.update(dt);
    }
    if(explosionTimeline.isOrWillBeAnimating())
    {
        drawModel = false;
    }
    else if(drawModel==false){
        drawModel = true;
        moveAnim.setPosition(start);
        
        
    }
}
void Locust::draw()
{
    if(!bSetup)
        return;
#if DEBUG
    ofPushStyle();
    ofNoFill();
    ofSetColor(255, 255, 0, 200);
    ofSetLineWidth(6);
    ofPushMatrix();
    ofCircle(start.x, start.y, minRadius);
    ofLine(-minRadius, 0, minRadius, 0);
    ofLine(0, -minRadius, 0, minRadius);
    ofPopMatrix();
    ofPopStyle();
    
    
    
    ofPushStyle();
    ofNoFill();
    ofSetColor(255, 255, 100, 200);
    ofSetLineWidth(6);
    ofPushMatrix();
    ofCircle(target.x, target.y, minRadius);
    ofLine(-minRadius, 0, minRadius, 0);
    ofLine(0, -minRadius, 0, minRadius);
    ofPopMatrix();
    ofPopStyle();
#endif
    ofPushMatrix();
    ofTranslate(moveAnim.getCurrentPosition().x,moveAnim.getCurrentPosition().y,bounce);
#if DEBUG
    ofPushStyle();
    ofNoFill();
    ofSetColor(255, 0, 100, 200);
    ofSetLineWidth(6);
    ofPushMatrix();
    ofCircle(0, 0, minRadius);
    ofLine(-minRadius, 0, minRadius, 0);
    ofLine(0, -minRadius, 0, minRadius);
    ofPopMatrix();
    ofPopStyle();
    
#endif
    ofRotate(angle, 0, 0, 1);
    if(drawModel)
    {
        texture->bind();
        model->drawFaces();
        texture->unbind();
    }
    ofPopMatrix();
    
    
    
}
void Locust::drawExplosion(ofxQCAR *qcar)
{
    if(!drawModel)
    {
        ofPushStyle();
        ofSetColor(ofColor::white);
        ofPushMatrix();
        ofVec2f screenPoint = qcar->point3DToScreen2D(moveAnim.getCurrentPosition());
        ofTranslate(screenPoint);
        
        ofTexture *tex = sequence->getFrameAtPercent(explosionTimeline.getPercentDone());
        tex->draw(-tex->getWidth()*0.5,-tex->getHeight()*0.5);
        ofPopMatrix();
        ofPopStyle();
    }
}
bool Locust::isDrawingModel()
{
    return drawModel;
}
ofVec3f Locust::getPos()
{
    return moveAnim.getCurrentPosition();
}
void Locust::destoried()
{
    //set play animation
    //set model disappear
    drawModel = false;
    explosionTimeline.reset(0);
    explosionTimeline.setDuration(2);
    explosionTimeline.animateTo(1);
    explosionTimeline.setRepeatType(PLAY_ONCE);
    explosionTimeline.setCurve(LINEAR);
}