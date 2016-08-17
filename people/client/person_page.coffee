Template.person_page.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_people_tags.array())

Template.person_page.helpers
    person: -> Docs.findOne FlowRouter.getParam('person_id')


Template.person_page.events
    'click .tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()

