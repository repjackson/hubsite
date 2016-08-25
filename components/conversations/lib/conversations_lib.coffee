@Conversation_tags = new Meteor.Collection 'conversation_tags'
@Conversations = new Meteor.Collection 'conversations'

Conversations.helpers
    participants: ->
        participant_array = []
        for id in @participant_ids
            participant_array.push(Meteor.users.findOne(id)?.username)
        participant_array


FlowRouter.route '/conversations', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'conversation_cloud'
        main: 'conversations'

FlowRouter.route '/conversation/:conversation_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'conversation_page'



Meteor.methods
    create_conversation: (tags=[])->
        Conversations.insert
            tags: tags
            author_id: Meteor.userId()
            participant_ids: [Meteor.userId()]

    close_conversation: (id)->
        Conversations.remove id
        Messages.remove conversation_id: id

    join_conversation: (id)->
        Conversations.update id,
            $addToSet:
                participant_ids: Meteor.userId()

    leave_conversation: (id)->
        Conversations.update id,
            $pull:
                participant_ids: Meteor.userId()
