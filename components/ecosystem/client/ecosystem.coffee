Template.ecosystem.onCreated ->
    @autorun -> Meteor.subscribe('ecosystem', selected_tags.array())
 
Template.ecosystem.onRendered ->
    $('#ecosystem_slider').layerSlider
        autoStart: true


Template.ecosystem.helpers
    items: -> 
        Docs.find {},
            sort: points: -1
            


Template.ecosystem.helpers
    ecosystem_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId() is @author_id


Template.ecosystem.events
    'click .ecosystem_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()
            
    'click .edit': ->
        FlowRouter.go "/edit/#{@_id}"

    'click #add_ecosystem_item': ->
        id = Docs.insert 
            type: 'ecosystem'
        FlowRouter.go "/edit/#{id}"
