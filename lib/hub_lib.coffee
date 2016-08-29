@Docs = new Meteor.Collection 'docs'
@Tags = new Meteor.Collection 'tags'

    
Docs.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    # doc.tag = []
    return

Docs.after.update ((userId, doc, fieldNames, modifier, options) ->
    doc.tag_count = doc.tags?.length
), fetchPrevious: true


Docs.helpers
    author: -> Meteor.users.findOne @author_id
    when: -> moment(@timestamp).fromNow()

# Docs.helpers          
#     attendees: ->
#         if not @attendee_ids then return
#         else
#             attendee_array = []
#             for id in @attendee_ids
#                 attendee_array.push(Meteor.users.findOne(id)?.username)
#             participantArray

            



Meteor.methods
    delete_doc: (id)->
        Docs.remove id