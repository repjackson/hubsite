@Events = new Meteor.Collection 'events'


Meteor.methods
    join_event: (id)->
        check(arguments, [Match.Any])
        Docs.update id, 
            $addToSet: attendee_ids: Meteor.userId()    
            
    leave_event: (id)->
        check(arguments, [Match.Any])
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

