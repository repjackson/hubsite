@Conversation_tags = new Meteor.Collection 'conversation_tags'
@Messages = new Meteor.Collection 'messages'
@Conversations = new Meteor.Collection 'conversations'
@Docs = new Meteor.Collection 'docs'
@Tags = new Meteor.Collection 'tags'

    
Docs.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return

# Docs.after.update ((userId, doc, fieldNames, modifier, options) ->
#     doc.tagCount = doc.tags.length
# ), fetchPrevious: true

Messages.helpers
    author: -> Meteor.users.findOne @author_id
    recipient: -> Meteor.users.findOne @recipient_id
    when: -> moment(@timestamp).fromNow()

Docs.helpers
    author: -> Meteor.users.findOne @author_id
    when: -> moment(@timestamp).fromNow()


Conversations.helpers
    participants: ->
        participantArray = []
        for id in @participantIds
            participantArray.push(Meteor.users.findOne(id)?.username)
        participantArray


Meteor.methods
    delete_doc: (id)->
        Docs.remove id

    # update_name: (name)->
    #     Meteor.users.update Meteor.userId(),
    #         $set: "profile.name": name

    # send_message: (body, recipientId) ->
    #     Messages.insert
    #         timestamp: Date.now()
    #         authorId: Meteor.userId()
    #         body: body
    #         recipientId: recipientId

    # add_message: (text, conversationId) ->
    #     Messages.insert
    #         timestamp: Date.now()
    #         authorId: Meteor.userId()
    #         text: text
    #         conversationId: conversationId



