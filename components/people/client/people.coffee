Template.people.onCreated ->
    @autorun -> Meteor.subscribe('people', selected_people_tags.array(), Session.get('published_mode'), Session.get('checkedin_mode'))
    @autorun -> Meteor.subscribe('people', selected_people_tags.array(), Session.get('published_mode'))

Template.people.helpers
    people: -> Meteor.users.find()

Template.people.onRendered ->
    $('#people_slider').layerSlider
        autoStart: true
        # firstLayer: 2
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'
    



Template.person_card.helpers
    tag_class: -> if @valueOf() in selected_people_tags.array() then 'red' else 'basic'

    matchedtags: -> _.intersection @tags, Meteor.user().tags
 

Template.person_card.events
    'click .doc_tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()

    'click #check_in': ->
        Meteor.users.update @_id,
            $set: checked_in: true

    'click #check_out': ->
        Meteor.users.update @_id,
            $set: checked_in: false
