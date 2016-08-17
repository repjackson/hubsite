Template.organizations.onCreated ->
    @autorun -> Meteor.subscribe('organizations', selected_organization_tags.array())


Template.organizations.helpers
    organizations: -> Docs.find {}


Template.organization.helpers
    organization_tag_class: -> if @valueOf() in selected_organization_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId() is @author_id

    organization_messages: -> Messages.find organization_id: @_id

    snippet: -> @description.substr(1, 100)

Template.organization.events
    'click .organization_tag': ->
        if @valueOf() in selected_organization_tags.array() then selected_organization_tags.remove @valueOf() else selected_organization_tags.push @valueOf()


    'keydown .add_message': (e,t)->
        e.prorganizationDefault
        if e.which is 13
            text = t.find('.add_message').value.trim()
            if text.length > 0
                Meteor.call 'add_organization_message', text, @_id, (err,res)->
                    t.find('.add_message').value = ''

            
    'click .edit_organization': ->
        FlowRouter.go "/organizations/edit/#{@_id}"
