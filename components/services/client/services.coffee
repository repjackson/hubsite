@selected_tags = new ReactiveArray []


Template.services.onCreated ->
    @autorun -> Meteor.subscribe('services', selected_tags.array())

Template.services.helpers
    services: ->  Docs.find {}


Template.service.helpers
    service_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    can_edit: -> @author_id is Meteor.userId()

    service_messages: -> Messages.find service_id: @_id


Template.service.events
    'click .service_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()


    'keydown .addMessage': (e,t)->
        e.preventDefault
        if e.which is 13
            text = t.find('.addMessage').value.trim()
            if text.length > 0
                Meteor.call 'add_event_message', text, @_id, (err,res)->
                    t.find('.addMessage').value = ''

    'click .edit_service': ->
        FlowRouter.go "/services/edit/#{@_id}"


Template.services.events
    'click #add_service': ->
        Meteor.call 'add_service', (err, id)->
            FlowRouter.go "/account/services/edit/#{id}"