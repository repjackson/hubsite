@Peopletags = new Meteor.Collection 'people_tags'
@Conversationtags = new Meteor.Collection 'conversation_tags'
@Messages = new Meteor.Collection 'messages'
@Conversations = new Meteor.Collection 'conversations'
@Events = new Meteor.Collection 'events'
@Eventtags = new Meteor.Collection 'event_tags'
@Docs = new Meteor.Collection 'docs'

Docs.before.insert (userId, doc)->
    doc.up_voters = [userId]
    doc.down_voters = []
    doc.timestamp = Date.now()
    doc.authorId = Meteor.userId()
    doc.username = Meteor.user().username
    doc.points = 1
    return

Docs.after.update ((userId, doc, fieldNames, modifier, options) ->
    doc.tagCount = doc.tags.length
), fetchPrevious: true

Messages.helpers
    author: -> Meteor.users.findOne @authorId
    recipient: -> Meteor.users.findOne @recipientId
    when: -> moment(@timestamp).fromNow()

Docs.helpers
    author: -> Meteor.users.findOne @authorId
    when: -> moment(@timestamp).fromNow()


Conversations.helpers
    participants: ->
        participantArray = []
        for id in @participantIds
            participantArray.push(Meteor.users.findOne(id)?.username)
        participantArray

Events.helpers
    attendees: ->
        attendeeArray = []
        for id in @attendeeIds
            attendeeArray.push(Meteor.users.findOne(id)?.username)
        attendeeArray


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

    create_event: (tags)->
        Events.insert
            tags: tags
            hostId: Meteor.userId()
            attendeeIds: [Meteor.userId()]

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



    add_event_message: (text, eventId)->
        Messages.insert
            timestamp: Date.now()
            authorId: Meteor.userId()
            text: text
            eventId: eventId

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

    join_event: (id)->
        Events.update id,
            $addToSet:
                attendeeIds: Meteor.userId()

    leave_event: (id)->
        Events.update id,
            $pull:
                attendeeIds: Meteor.userId()

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


AccountsTemplates.configure
    defaultLayout: 'layout'
    defaultLayoutRegions:
        nav: 'nav'
    defaultContentRegion: 'main'
    showForgotPasswordLink: true
    overrideLoginErrors: true
    enablePasswordChange: true

    # sendVerificationEmail: true
    # enforceEmailVerification: true
    #confirmPassword: true
    #continuousValidation: false
    #displayFormLabels: true
    #forbidClientAccountCreation: true
    #formValidationFeedback: true
    #homeRoutePath: '/'
    #showAddRemoveServices: false
    #showPlaceholders: true

    negativeValidation: true
    positiveValidation: true
    negativeFeedback: false
    positiveFeedback: true

    # Privacy Policy and Terms of Use
    #privacyUrl: 'privacy'
    #termsUrl: 'terms-of-use'

pwd = AccountsTemplates.removeField('password')
AccountsTemplates.removeField 'email'
AccountsTemplates.addFields [
    {
        _id: 'username'
        type: 'text'
        displayName: 'username'
        required: true
        minLength: 3
    }
    # {
    #     _id: 'email'
    #     type: 'email'
    #     required: false
    #     displayName: 'email'
    #     re: /.+@(.+){2,}\.(.+){2,}/
    #     errStr: 'Invalid email'
    # }
    # {
    #     _id: 'username_and_email'
    #     type: 'text'
    #     required: false
    #     displayName: 'Login'
    # }
    pwd
]

AccountsTemplates.configureRoute 'changePwd'
AccountsTemplates.configureRoute 'forgotPwd'
AccountsTemplates.configureRoute 'resetPwd'
AccountsTemplates.configureRoute 'signIn'
AccountsTemplates.configureRoute 'signUp'
AccountsTemplates.configureRoute 'verifyEmail'


FlowRouter.route '/', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        # cloud: 'cloud'
        main: 'home'

FlowRouter.route '/profile', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'profile'

FlowRouter.route '/messages', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'messagePage'

FlowRouter.route '/conversations', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'conversation_cloud'
        main: 'conversations'

FlowRouter.route '/events', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'event_cloud'
        main: 'events'

FlowRouter.route '/wins', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        main: 'wins_challenges'

# FlowRouter.route '/editConversation/:docId', action: (params) ->
#     BlazeLayout.render 'layout',
#         main: 'conversation'
