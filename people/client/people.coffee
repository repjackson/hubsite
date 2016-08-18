Template.people.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_people_tags.array())

Template.people.helpers
    people: -> Meteor.users.find()




Template.person_card.helpers
    tag_class: -> if @valueOf() in selected_people_tags.array() then 'red' else 'basic'

    matchedtags: -> _.intersection @tags, Meteor.user().tags
 

Template.person_card.events
    'click .doc_tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()
