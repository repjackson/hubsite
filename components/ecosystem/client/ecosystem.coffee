Template.ecosystem.onCreated ->
    @autorun -> Meteor.subscribe('ecosystem', selected_tags.array())
 
Template.ecosystem.onRendered ->
    $('#ecosystem_slider').layerSlider
        autoStart: true
    selected_tags.clear()


Template.ecosystem.helpers
    ecosystem_item: -> Docs.find {
        tags: $in: ['ecosystem']
        }


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
            tags: ['ecosystem']
        FlowRouter.go "/edit/#{id}"
