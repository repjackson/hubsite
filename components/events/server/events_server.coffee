Events.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')

Meteor.publish 'featured_events', ->
    Events.find {featured: true}, sort: "start.local": -1
        


# Meteor.publish 'upcoming_events', (selected_event_tags)->
#     check(arguments, [Match.Any])

#     self = @
#     match = {}
#     if selected_event_tags.length > 0 then match.tags = $all: selected_event_tags

#     today = Date.now()
#     # match.start.local = $gt: today
#     match["start.local"] = $lte: today

#     console.log 'upcoming events match', match
#     Events.find match,
#         limit: 10
#         # sort: 
#         #     start_date: 1

Meteor.publish 'selected_events', (selected_event_tags)->
    check(arguments, [Match.Any])

    self = @
    match = {}
    if selected_event_tags.length > 0 then match.tags = $all: selected_event_tags
    
    Events.find match
        # limit: 10
        # sort: 
        #     start_date: 1


# Meteor.publish 'past_events', (selected_event_tags)->
#     check(arguments, [Match.Any])

#     self = @
#     match = {}
#     if selected_event_tags.length > 0 then match.tags = $all: selected_event_tags
    
#     Events.find match,
#         limit: 10
#         # sort: 
#         #     start_date: 1




Meteor.publish 'event_tags', (selected_event_tags)->
    check(arguments, [Match.Any])
    self = @
    match = {}
    if selected_event_tags.length > 0 then match.tags = $all: selected_event_tags

    cloud = Events.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_event_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag, i) ->
        self.added 'event_tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()



Meteor.publish 'event', (event_id)->
    Events.find event_id

    
Meteor.methods
    add_event: (event_id)->
        HTTP.get "https://www.eventbriteapi.com/v3/events/#{event_id}", {
                params:
                    token: 'QLL5EULOADTSJDS74HH7'
                    expand: 'organizer,venue,logo,format,category,subcategory,ticket_classes,bookmark_info'
            }, 
            (err, res)->
                if err
                    console.error err
                else
                    event = res.data
                    existing_event = Events.findOne { id: event.id} 
                    if existing_event
                        console.log 'found duplicate', event.id
                        return
                    else
                        image_id = event.logo.id
                        image_object = HTTP.get "https://www.eventbriteapi.com/v3/media/#{image_id}", {
                            params:
                                token: 'QLL5EULOADTSJDS74HH7'
                        }
                        # console.log image_object
                        new_image_url = image_object.data.url
                        event.big_image_url = new_image_url
                        val = event.start.local
                        # console.log val
                        minute = moment(val).minute()
                        hour = moment(val).format('h')
                        date = moment(val).format('Do')
                        ampm = moment(val).format('a')
                        weekdaynum = moment(val).isoWeekday()
                        weekday = moment().isoWeekday(weekdaynum).format('dddd')
        
                        month = moment(val).format('MMMM')
                        year = moment(val).format('YYYY')
        
                        # datearray = [hour, minute, ampm, weekday, month, date, year]
                        datearray = [weekday, month, date]
                        datearray = _.map(datearray, (el)-> el.toString().toLowerCase())

                        
                        event.date_array = datearray
                        
                        tags = datearray
                      
                        tags.push event.venue.name
                        tags.push event.organizer.name
                        
                        if event.category 
                            for category_object in event.category
                                tags push category_object.name
                        
                        trimmed_tags = _.map tags, (tag) ->
                            tag.trim().toLowerCase()
                        unique_tags = _.uniq trimmed_tags
                        event.tags = unique_tags 
                        
                        new_event_id = Events.insert event
                        return new_event_id
