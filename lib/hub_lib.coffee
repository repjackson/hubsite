@Peopletags = new Meteor.Collection 'people_tags'
@Conversationtags = new Meteor.Collection 'conversation_tags'
@Messages = new Meteor.Collection 'messages'
@Conversations = new Meteor.Collection 'conversations'
@Events = new Meteor.Collection 'events'
@Eventtags = new Meteor.Collection 'event_tags'
@Docs = new Meteor.Collection 'docs'

Docs.before.insert (userId, doc)->
    # doc.up_voters = [userId]
    # doc.down_voters = []
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    # doc.username = Meteor.user().username
    # doc.points = 1
    return

Docs.after.update ((userId, doc, fieldNames, modifier, options) ->
    doc.tagCount = doc.tags.length
), fetchPrevious: true

Messages.helpers
    author: -> Meteor.users.findOne @authorId
    recipient: -> Meteor.users.findOne @recipientId
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

    vote_up: (id)->
        doc = Docs.findOne id
        if Meteor.userId() in doc.up_voters #undo upvote
            Docs.update id,
                $pull: up_voters: Meteor.userId()
                $inc: points: -1
            Meteor.users.update doc.authorId, $inc: points: -1

        else if Meteor.userId() in doc.down_voters #switch downvote to upvote
            Docs.update id,
                $pull: down_voters: Meteor.userId()
                $addToSet: up_voters: Meteor.userId()
                $inc: points: 2
            Meteor.users.update doc.authorId, $inc: points: 2

        else #clean upvote
            Docs.update id,
                $addToSet: up_voters: Meteor.userId()
                $inc: points: 1
            Meteor.users.update doc.authorId, $inc: points: 1
        # Meteor.call 'generatePersonalCloud', Meteor.userId()


    create_conversation: (tags, otherUserId)->
        existingConversation = Conversations.findOne tags: tags
        if existingConversation then return
        else
            Conversations.insert
                tags: tags
                authorId: Meteor.userId()
                participantIds: [Meteor.userId(), otherUserId]

    add_win: (body)->
        Docs.insert
            tags: ['impact hub', 'boulder', 'win']
            body: body
            authorId: Meteor.userId()


    add_challenge: (body)->
        Docs.insert
            tags: ['impact hub', 'boulder', 'challenge']
            body: body
            authorId: Meteor.userId()


    closeConversation: (id)->
        Conversations.remove id
        Messages.remove conversationId: id

    joinConversation: (id)->
        Conversations.update id,
            $addToSet:
                participantIds: Meteor.userId()

    leaveConversation: (id)->
        Conversations.update id,
            $pull:
                participantIds: Meteor.userId()

    removetag: (tag)->
        Meteor.users.update Meteor.userId(),
            $pull: tags: tag

    addtag: (tag)->
        Meteor.users.update Meteor.userId(),
            $addToSet: tags: tag

    update_username: (username)->
        existing_user = Meteor.users.findOne username:username
        if existing_user then throw new Meteor.Error 500, 'username exists'
        else
            Meteor.users.update Meteor.userId(),
                $set: username: username

    send_message: (body, recipientId) ->
        Messages.insert
            timestamp: Date.now()
            authorId: Meteor.userId()
            body: body
            recipientId: recipientId

    add_message: (text, conversationId) ->
        Messages.insert
            timestamp: Date.now()
            authorId: Meteor.userId()
            text: text
            conversationId: conversationId



