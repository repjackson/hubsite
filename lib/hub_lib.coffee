@Docs = new Meteor.Collection 'docs'
@Tags = new Meteor.Collection 'tags'

    
Docs.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = userId
    doc.order = 100
    doc.points = 0
    doc.up_voters = []
    doc.down_voters = []

    # doc.tag = []
    return

Docs.after.update ((userId, doc, fieldNames, modifier, options) ->
    doc.tag_count = doc.tags?.length
    # console.log doc.tag_count
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
        
        
@Components = [
    'blog'
    'events'
    'user_blurb'
    ]