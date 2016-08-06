Template.events.onCreated ->
    @autorun -> Meteor.subscribe('events', selected_event_tags.array())

Template.events.helpers
    events: -> Docs.find()

Template.events.events
    'click #add_event': ->
        Meteor.call 'add_event', (err, id)->
            if err then console.error err
            else FlowRouter.go "/events/edit/#{id}"



# Single
Template.event.onCreated ->
    @autorun -> Meteor.subscribe('eventMessages', Template.currentData()._id)
    @autorun -> Meteor.subscribe('usernames')

Template.event.helpers
    tagClass: ->
        if @valueOf() in selected_event_tags.array() then 'secondary' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    isHost: -> @author_id is Meteor.userId()

    eventMessages: -> Messages.find eventId: @_id



Template.event.events
    'click .tag': ->
        if @valueOf() in selected_event_tags.array() then selected_event_tags.remove @valueOf() else selected_event_tags.push @valueOf()

    'click .join_event': ->
        Meteor.call 'join_event', @_id

    'click .leave_event': ->
        Meteor.call 'leave_event', @_id


    'keydown .addMessage': (e,t)->
        e.preventDefault
        switch e.which
            when 13
                text = t.find('.addMessage').value.trim()
                if text.length > 0
                    Meteor.call 'add_event_message', text, @_id, (err,res)->
                        t.find('.addMessage').value = ''

    'click .cancelEvent': ->
        if confirm 'Cancel event?'
            Events.remove @_id