@Event_tags = new Meteor.Collection 'event_tags'


# Docs.helpers
#     attendees: ->
#         if @attendee_ids?.length > 0
#             attendeeArray = []
#             for id in @attendee_ids
#                 attendeeArray.push(Meteor.users.findOne(id))
#             return attendeeArray
#         else return
    
#     author: -> Meteor.users.findOne @author_id



Meteor.methods
    add_event: ()->
        Docs.insert
            attendee_ids: []

    delete_event: (id)->
        Docs.remove id

    remove_event_tag: (tag, doc_id)->
        Docs.update doc_id,
            $pull: tag

    add_event_tag: (tag, doc_id)->
        Docs.update doc_id,
            $addToSet: tags: tag
    
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

FlowRouter.route '/events/edit/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_event'

FlowRouter.route '/events/view/:event_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'event_page'

