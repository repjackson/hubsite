@selected_people_tags = new ReactiveArray []

Template.people_cloud.onCreated ->
    @autorun -> Meteor.subscribe('people_tags', selected_people_tags.array())

Template.people_cloud.helpers
    people_tags: ->
        people_count = People.find().count()
        if 0 < people_count < 3 then People_tags.find { count: $lt: people_count } else People_tags.find()
        # People_tags.find()
#

    people_tag_class: ->
        button_class = switch
            when @index <= 5 then 'big'
            when @index <= 10 then 'large'
            when @index <= 15 then ''
            when @index <= 20 then 'small'
            when @index <= 25 then 'tiny'
        return button_class

    selected_people_tags: -> selected_people_tags.list()

    can_add: -> Meteor.userId()
    
Template.people_cloud.events
    'click .select_tag': -> selected_people_tags.push @name
    'click .unselect_tag': -> selected_people_tags.remove @valueOf()
    'click #clear_tags': -> selected_people_tags.clear()
    
    'click #add_person': ->
        Meteor.call 'add_person', (err, person_id)->
            FlowRouter.go "/person/edit/#{person_id}"