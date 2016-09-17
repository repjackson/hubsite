Template.event_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'event', FlowRouter.getParam('event_id')

Template.event_page.helpers
    event: -> Events.findOne FlowRouter.getParam('event_id')

    event_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId()

    day: -> moment(@start.local).format("dddd, MMMM Do");
    start_time: -> moment(@start.local).format("h:mm a")
    end_time: -> moment(@end.local).format("h:mm a")

    
Template.event_page.events
    'click .event_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()

    'click .edit_event': ->
        FlowRouter.go "/event/edit/#{@_id}"

    'click #make_featured': ->
        Events.update FlowRouter.getParam('event_id'),
            $set: featured: true

    'click #make_unfeatured': ->
        Events.update FlowRouter.getParam('event_id'),
            $set: featured: false

    'click #delete': ->
        swal {
            title: 'Delete event?'
            text: 'It will still be on Eventbrite.'
            type: 'warning'
            animation: false
            showCancelButton: true
            closeOnConfirm: true
            cancelButtonText: 'No'
            confirmButtonText: 'Yes'
            confirmButtonColor: '#da5347'
        }, ->
            event = Events.findOne FlowRouter.getParam('event_id')
            Events.remove event._id, ->
                FlowRouter.go "/events"

    'click #reload': ->
        swal {
            title: 'Reload event?'
            text: 'This will delete and redownload event from Eventbrite.'
            type: 'warning'
            animation: false
            showCancelButton: true
            closeOnConfirm: true
            cancelButtonText: 'No'
            confirmButtonText: 'Yes'
            confirmButtonColor: '#da5347'
        }, ->
            event = Events.findOne FlowRouter.getParam('event_id')
            event_id = event.id
            Events.remove event._id, ->
                Meteor.call 'add_event', event_id, (err, _id)->
                    console.log _id
                    FlowRouter.go "/event/view/#{_id}" 