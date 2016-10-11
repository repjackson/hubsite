Template.ecosystem.onCreated ->
    @autorun -> Meteor.subscribe('ecosystem', selected_eco_tags.array())
 
Template.ecosystem.onRendered ->
    $('#ecosystem_slider').layerSlider
        autoStart: true
    selected_eco_tags.clear()


Template.ecosystem.helpers
    ecosystem_items: -> Docs.find {}


Template.ecosystem.helpers
    ecosystem_tag_class: -> if @valueOf() in selected_eco_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId() is @author_id


Template.ecosystem.events
    'click .ecosystem_tag': ->
        if @valueOf() in selected_eco_tags.array() then selected_eco_tags.remove @valueOf() else selected_eco_tags.push @valueOf()
            
    'click .edit': ->
        FlowRouter.go "/edit/#{@_id}"

