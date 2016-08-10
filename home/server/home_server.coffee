Meteor.publish 'featured_events', ->
    match = {}
    match.type = 'event'

    Docs.find match, limit: 3
    # Docs.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1


Meteor.publish 'featured_posts', ->
    match = {}
    match.type = 'post'

    Docs.find match, limit: 3
    # Docs.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1

Meteor.publish 'rockstar_members', ->
    match = {}
    # match.rockstar_member = true

    Meteor.users.find match, limit: 3
    # Docs.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1

