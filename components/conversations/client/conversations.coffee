Template.conversations.onCreated ->
    @autorun -> Meteor.subscribe('docs', selected_conversation_tags.array(), 'conversation')

Template.conversations.helpers
    conversations: -> Docs.find()


# Single

Template.conversation_card.onCreated ->
    @autorun -> Meteor.subscribe('conversation_messages', Template.currentData()._id)
    @autorun -> Meteor.subscribe('people_list', Template.currentData()._id)

Template.conversation_card.helpers
    conversation_messages: -> Messages.find({conversation_id: @_id})

    participants: ->
        participant_array = []
        for participant in @participant_ids?
            participant_object = Meteor.users.findOne participant
            participant_array.push participant_object
        return participant_array



Template.conversation_card.helpers
    conversation_tag_class: -> if @valueOf() in selected_conversation_tags.array() then 'red' else 'basic'

