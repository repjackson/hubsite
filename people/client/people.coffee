Template.people.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_people_tags.array())
    # @autorun -> Meteor.subscribe('me')

Template.people.helpers
    people: -> Docs.find({ _id: $ne: Meteor.userId() })
    # people: -> Meteor.users.find()


Template.person_card.onCreated ->
    # @autorun -> Meteor.subscribe('conversationMessages', Template.currentData()._id)
    # console.log Template.currentData()
    # Meteor.subscribe 'person', @data._id


Template.person_card.helpers
    tag_class: -> if @valueOf() in selected_people_tags.array() then 'red' else 'basic'

    matchedtags: -> _.intersection @tags, Meteor.user().tags

    # conversationMessages: -> Messages.find()


Template.person_card.events
    'click .person_tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()

    # 'click .converseWithUser': ->
    #     intersection = _.intersection @tags, Meteor.user().tags
    #     Meteor.call 'create_conversation', intersection, @_id, (err, res)->
    #         FlowRouter.go '/conversations'
    #         selectedConversationTags.clear()
    #         selectedConversationTags.push(tag) for tag in intersection
