@Event_tags = new Meteor.Collection 'event_tags'



Docs.helpers
    attendees: ->
        if @attendee_ids
            attendeeArray = []
            for id in @attendee_ids
                attendeeArray.push(Meteor.users.findOne(id)?.profile.name)
            attendeeArray
        else return




Meteor.methods
    add_event: ()->
        Docs.insert
            type: 'event'
            tags: []

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