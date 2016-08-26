@Conversation_tags = new Meteor.Collection 'conversation_tags'



FlowRouter.route '/conversations', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'conversation_cloud'
        main: 'conversations'

FlowRouter.route '/conversation/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'conversation_page'



Meteor.methods
    create_conversation: (tags=[])->
        check(arguments, [Match.Any])
        Docs.insert
            tags: tags
            author_id: Meteor.userId()
            participant_ids: [Meteor.userId()]

    close_conversation: (id)->
        check(arguments, [Match.Any])
        Docs.remove id
        Messages.remove conversation_id: id

    join_conversation: (id)->
        check(arguments, [Match.Any])
        Docs.update id,
            $addToSet:
                participant_ids: Meteor.userId()

    leave_conversation: (id)->
        check(arguments, [Match.Any])
        Docs.update id,
            $pull:
                participant_ids: Meteor.userId()
