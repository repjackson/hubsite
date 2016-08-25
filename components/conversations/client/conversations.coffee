Template.conversations.onCreated ->
    @autorun -> Meteor.subscribe('conversations', selected_conversation_tags.array())

Template.conversations.helpers
    conversations: -> Conversations.find()


# Single
Template.conversation.onCreated ->
    @autorun -> Meteor.subscribe('conversation_messages', Template.currentData()._id)
    @autorun -> Meteor.subscribe('usernames')

Template.conversation.helpers
    tagClass: -> if @valueOf() in selected_conversation_tags.array() then 'secondary' else 'basic'

    in_conversation: -> if Meteor.userId() in @participant_ids then true else false

    conversation_messages: -> Messages.find({conversation_id: @_id})

Template.conversation.events
    'click .tag': -> if @valueOf() in selected_conversation_tags.array() then selected_conversation_tags.remove @valueOf() else selected_conversation_tags.push @valueOf()

    'click .join_conversation': -> Meteor.call 'join_conversation', @_id
    'click .leave_conversation': -> Meteor.call 'leave_conversation', @_id

    'keydown .add_message': (e,t)->
        e.preventDefault
        if e.which is 13
            text = t.find('.add_message').value.trim()
            if text.length > 0
                Meteor.call 'add_message', text, @_id, (err,res)->
                    t.find('.add_message').value = ''

    'click .close_conversation': ->
        if confirm 'Close conversation?'
            Meteor.call 'close_conversation', @_id
