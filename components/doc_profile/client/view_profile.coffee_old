Template.view_profile.onCreated ->
    @autorun -> Meteor.subscribe('view_profile', FlowRouter.getParam('doc_id'))
    # console.log 'fired'
    

Template.view_profile.helpers
    profile_doc: -> 
        doc_id = FlowRouter.getParam('doc_id') 
        
        # console.log doc_id
        Docs.findOne doc_id
    
    can_edit: -> FlowRouter.getParam('user_id') is Meteor.userId()


Template.view_profile.events
    'click .tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()

