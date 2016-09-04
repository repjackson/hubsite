Template.view_slider.events

Template.edit_slides.onCreated -> @autorun -> Meteor.subscribe('slides')


Template.edit_slides.helpers
    slides: -> Docs.find()
    
    
Template.edit_slides.events
    'click #add_slide':->
        Docs.insert
            type: 'slide'

Template.edit_slide.onCreated -> 
    @autorun -> Meteor.subscribe('doc', FlowRouter.getParam('doc_id'))

Template.edit_slide.helpers
    slide: -> Docs.find FlowRouter.getParam('doc_id')



# Template.edit_slide.events
    