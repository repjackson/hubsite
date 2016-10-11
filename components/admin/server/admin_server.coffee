


Meteor.publish 'hub_users', ->
    match = {}

    Meteor.users.find match
    # Docs.find match,
    #     fields:
    #         tags: 1
    #         attendee_ids: 1
    #         host_id: 1
    #         date_array: 1
    #         date: 1


# Meteor.publish 'all_docs', (selected_tags=[])->
Meteor.publish 'all_docs',->

    self = @
    match = {}
    # if selected_tags.length > 0 then match.tags = $all: selected_tags

    Docs.find match,
        limit: 20
        
