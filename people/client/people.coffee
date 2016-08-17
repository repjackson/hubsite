@selected_people_tags = new ReactiveArray []


Template.people.onCreated ->
    @autorun -> Meteor.subscribe('docs', selected_people_tags.array(), 'person')

Template.people.helpers
    people: -> Docs.find()




Template.person_card.helpers
    tag_class: -> if @valueOf() in selected_people_tags.array() then 'red' else 'basic'

    matchedtags: -> _.intersection @tags, Meteor.user().tags
 

Template.person_card.events
    'click .person_tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()
