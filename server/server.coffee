Conversations.allow
    update: (userId, doc, fieldNames, modifier) -> doc.authorId is Meteor.userId()
    remove: (userId, doc)-> doc.authorId is userId

Docs.allow
    insert: (userId, doc) -> doc.author_id is userId
    # update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    update: (userId, doc) -> 
        console.log doc
        console.log userId
        doc.author_id is userId
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')

Meteor.startup ->
    reCAPTCHA.config privatekey: Meteor.settings.recaptcha_private
    return

#SERVER
Cloudinary.config
    cloud_name: 'facet'
    api_key: Meteor.settings.cloudinary_key
    api_secret: Meteor.settings.cloudinary_secret




Meteor.publish 'usernames', ->
    check(arguments, [Match.Any])
    Meteor.users.find {},
        fields:
            username: 1


Meteor.publish 'sent_messages', ->
    check(arguments, [Match.Any])
    Messages.find
        authorId: @userId


Meteor.publish 'conversationMessages', (conversationId) ->
    check(arguments, [Match.Any])
    Messages.find
        conversationId: conversationId


Meteor.publish 'eventMessages', (eventId) ->
    check(arguments, [Match.Any])
    Messages.find
        eventId: eventId

Meteor.publish 'received_messages', ->
    check(arguments, [Match.Any])
    Messages.find
        recipientId: @userId




Meteor.publish 'conversations', (selectedtags)->
    check(arguments, [Match.Any])
    self = @
    match = {}
    if selectedtags and selectedtags.length > 0 then match.tags = $all: selectedtags

    Conversations.find match,
        fields:
            tags: 1
            authorId: 1
            participantIds: 1



Meteor.publish 'docs', (selected_tags, filter)->
    check(arguments, [Match.Any])

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = filter

    Docs.find match

Meteor.publish 'doc', (id)->
    check(arguments, [Match.Any])
    Docs.find id


Meteor.publish 'featured_docs', (filter)->
    check(arguments, [Match.Any])
    match = {}
    match.featured = true
    match.type = filter
    
    Docs.find match, limit: 3


Meteor.publish 'tags', (selected_tags, filter)->
    check(arguments, [Match.Any])
    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = filter

    cloud = Docs.aggregate [
        { $match: match }
        { $project: "tags": 1 }
        { $unwind: "$tags" }
        { $group: _id: "$tags", count: $sum: 1 }
        { $match: _id: $nin: selected_tags }
        { $sort: count: -1, _id: 1 }
        { $limit: 20 }
        { $project: _id: 0, name: '$_id', count: 1 }
        ]

    cloud.forEach (tag, i) ->
        self.added 'tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.methods 
    formSubmissionMethod: (formData, captchaData) ->
        verifyCaptchaResponse = reCAPTCHA.verifyCaptcha(@connection.clientAddress, captchaData)
        if !verifyCaptchaResponse.success
            console.log 'reCAPTCHA check failed!', verifyCaptchaResponse
            throw new (Meteor.Error)(422, 'reCAPTCHA Failed: ' + verifyCaptchaResponse.error)
        else
            console.log 'reCAPTCHA verification passed!'
        #do stuff with your formData
        true
        
        
AccountsMeld.configure
    askBeforeMeld: false
    # meldDBCallback: meldDBCallback
    # serviceAddedCallback: serviceAddedCallback
    
