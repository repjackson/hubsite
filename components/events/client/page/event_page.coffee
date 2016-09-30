Template.event_page.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'doc', FlowRouter.getParam('doc_id')

Template.event_page.helpers
    event: -> Docs.findOne FlowRouter.getParam('doc_id')

    event_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    attending: -> if @attendee_ids and Meteor.userId() in @attendee_ids then true else false

    can_edit: -> Meteor.userId()

    day: -> moment(@start_datetime).format("dddd, MMMM Do");
    start_time: -> moment(@start_datetime).format("h:mm a")
    end_time: -> moment(@end_datetime).format("h:mm a")


    # event_calendar_link: ->
    #     link = 
    #     "http://www.google.com/calendar/event?
    #         action=TEMPLATE
    #         &text=#{@name.text}
    #         &dates=#{@start.local}/#{@end.local}
    #         &details=#{@description.text}
    #         &location=#{@venue.name}
    #         &trp=false
    #         &sprop=
    #         &sprop=name:
    #         target='_blank' rel='nofollow'"
    #     new_link = encodeURI(link)

    
Template.event_page.events

    'click .edit_event': ->
        FlowRouter.go "/event/edit/#{@_id}"

    'click #pull_url': ->
        Meteor.call 'pull_url', @_id

    # 'click #reload': ->
    #     swal {
    #         title: 'Reload event?'
    #         text: 'This will delete and redownload event from Eventbrite.'
    #         type: 'warning'
    #         animation: false
    #         showCancelButton: true
    #         closeOnConfirm: true
    #         cancelButtonText: 'No'
    #         confirmButtonText: 'Yes'
    #         confirmButtonColor: '#da5347'
    #     }, ->
    #         event = Events.findOne FlowRouter.getParam('doc_id')
    #         doc_id = event.id
    #         Events.remove event._id, ->
    #             Meteor.call 'add_event', doc_id, (err, id)->
    #                 console.log 'new event id', id
    #                 FlowRouter.go "/event/view/#{id}" 
    
    'keydown #add_event_url': (e,t)->
        if e.which is 13
            url = $('#add_event_url').val()
            Docs.update @_id,
                $set: url: url
