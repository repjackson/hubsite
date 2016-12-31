@selected_people_tags = new ReactiveArray []

Template.people.onCreated ->
    # @autorun -> Meteor.subscribe('people', selected_people_tags.array(), Session.get('published_mode'), Session.get('checkedin_mode'))
    @autorun -> 
        Meteor.subscribe('member_profiles', selected_people_tags.array())

        
Template.people.helpers
    member_profiles: -> 
        
        # member_profile = 
        #     Docs.findOne
        #         author_id: Meteor.userId()
        #         type: 'member_profile'
        
        # console.log member_profile._id
        
        
        Docs.find()
            # _id: $ne: member_profile_id


Template.people.onRendered ->
    $('#people_slider').layerSlider
        autoStart: true
        # firstLayer: 2
        # skin: 'borderlesslight'
        # skinsPath: '/static/layerslider/skins/'
    


Template.profile_card.helpers
    tag_class: -> if @valueOf() in selected_people_tags.array() then 'red' else 'basic'

    matchedtags: -> _.intersection @tags, Meteor.user().tags
 
    card_tags: -> @tags[0..5]
    

Template.profile_card.events
    'click .person_tag': ->
        if @valueOf() in selected_people_tags.array() then selected_people_tags.remove @valueOf() else selected_people_tags.push @valueOf()

    'click #check_in': ->
        Meteor.users.update @_id,
            $set: checked_in: true

    'click #check_out': ->
        Meteor.users.update @_id,
            $set: checked_in: false
