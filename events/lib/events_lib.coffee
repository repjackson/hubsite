@Event_tags = new Meteor.Collection 'event_tags'
@Events = new Meteor.Collection 'events'


Events.helpers
    attendees: ->
        if @attendee_ids.length > 0
            attendeeArray = []
            for id in @attendee_ids
                attendeeArray.push(Meteor.users.findOne(id))
            return attendeeArray
        else return
    
    author: -> Meteor.users.findOne @author_id

Events.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    attendee_ids = []
    return

# Events.after.update ((userId, doc, fieldNames, modifier, options) ->
#     doc.tagCount = doc.tags.length
# ), fetchPrevious: true


Meteor.methods
    add_event: ()->
        Events.insert {}

    delete_event: (id)->
        Events.remove id

    remove_event_tag: (tag, doc_id)->
        Events.update doc_id,
            $pull: tag

    add_event_tag: (tag, doc_id)->
        Events.update doc_id,
            $addToSet: tags: tag
    
    join_event: (id)->
        Events.update id, 
            $addToSet: attendee_ids: Meteor.userId()    
            
    leave_event: (id)->
        Events.update id, 
            $pull: attendee_ids: Meteor.userId()