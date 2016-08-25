Template.user_blurb.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_people_tags.array(), Session.get('published_mode'), Session.get('checkedin_mode'))

Template.user_blurb.helpers
    person: -> Meteor.users.findOne @id
