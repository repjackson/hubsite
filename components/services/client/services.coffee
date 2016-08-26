@selected_tags = new ReactiveArray []


Template.services.onCreated ->
    @autorun -> Meteor.subscribe('docs', selected_tags.array(), 'service')

Template.services.helpers
    services: ->  Docs.find {}


Template.service.helpers
    can_edit: -> @author_id is Meteor.userId()

    service_messages: -> Messages.find service_id: @_id

    service_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'


Template.service.events
    'click .service_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()


    'click .edit_service': ->
        FlowRouter.go "/service/edit/#{@_id}"


Template.services.events
    'click #add_service': ->
        id = Docs.insert 
            type: 'service'
            tags: ['service', Meteor.user().profile.name.toLowerCase()]
        FlowRouter.go "/service/edit/#{id}"
            
            

