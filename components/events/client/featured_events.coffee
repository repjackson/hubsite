Template.featured_events.onCreated ->
    self = @
    self.autorun ->
        self.subscribe 'featured_events'


Template.featured_events.helpers
    featured_events: -> 
        Events.find 
            featured: true

Template.featured_event.helpers
    day: -> moment(@start_date).format("dddd, MMMM Do")
    start_time: -> moment(@start_date).format("h:mm a")
    end_time: -> moment(@end_date).format("h:mm a")


Template.featured_events.events
    'click .featured_event_title': ->
        FlowRouter.go "/events/#{@_id}"

