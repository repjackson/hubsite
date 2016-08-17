Meteor.methods
    add_event: ()->
        Docs.insert
            type: 'event'
            attendee_ids: []


    join_event: (id)->
        Docs.update id, 
            $addToSet: attendee_ids: Meteor.userId()    
            
    leave_event: (id)->
        Docs.update id, 
            $pull: attendee_ids: Meteor.userId()
            
            
            
# Events

FlowRouter.route '/events', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'event_cloud'
        main: 'events'

FlowRouter.route '/events/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_event'

FlowRouter.route '/events/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'event_page'

