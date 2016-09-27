@Events = new Meteor.Collection 'events'
@Event_tags = new Meteor.Collection 'event_tags'


Meteor.methods
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
        # cloud: 'event_cloud'
        main: 'events'

FlowRouter.route '/event/edit/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_event'

FlowRouter.route '/event/view/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'event_page'

