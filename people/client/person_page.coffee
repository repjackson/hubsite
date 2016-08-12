Template.person_page.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_people_tags.array())
    # @autorun -> Meteor.subscribe('me')

Template.person_page.helpers
    person: -> People.findOne FlowRouter.getParam('person_id')

    can_edit: -> Meteor.userId()


Template.person_page.events
    'click .tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()

    # 'click .converseWithUser': ->
    #     intersection = _.intersection @tags, Meteor.user().tags
    #     Meteor.call 'create_conversation', intersection, @_id, (err, res)->
    #         FlowRouter.go '/conversations'
    #         selectedConversationTags.clear()
    #         selectedConversationTags.push(tag) for tag in intersection
