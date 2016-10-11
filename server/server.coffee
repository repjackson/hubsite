# { request } = require "meteor/froatsnook:request"

Docs.allow
    insert: (userId, doc) -> doc.author_id is userId
    update: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')
    remove: (userId, doc) -> doc.author_id is userId or Roles.userIsInRole(userId, 'admin')

# Meteor.startup ->
#     reCAPTCHA.config privatekey: Meteor.settings.recaptcha_private
#     return

#SERVER
Cloudinary.config
    cloud_name: 'facet'
    api_key: Meteor.settings.cloudinary_key
    api_secret: Meteor.settings.cloudinary_secret




Meteor.publish 'usernames', ->
    Meteor.users.find {},
        fields:
            username: 1




Meteor.publish 'docs', (selected_tags, filter)->

    self = @
    match = {}
    if selected_tags.length > 0 then match.tags = $all: selected_tags
    match.type = filter

    Docs.find match,
        limit: 20
        

Meteor.publish 'doc', (id)->
    Docs.find id


Meteor.publish 'featured_docs', (filter)->
    match = {}
    match.featured = true
    match.type = filter
    
    Docs.find match, limit: 3


Meteor.publish 'tags', (selected_tags, filter)->
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

    # console.log 'filter: ', filter
    # console.log 'cloud: ', cloud

    cloud.forEach (tag, i) ->
        self.added 'tags', Random.id(),
            name: tag.name
            count: tag.count
            index: i

    self.ready()


Meteor.methods 
    # formSubmissionMethod: (formData, captchaData) ->
    #     verifyCaptchaResponse = reCAPTCHA.verifyCaptcha(@connection.clientAddress, captchaData)
    #     if !verifyCaptchaResponse.success
    #         console.log 'reCAPTCHA check failed!', verifyCaptchaResponse
    #         throw new (Meteor.Error)(422, 'reCAPTCHA Failed: ' + verifyCaptchaResponse.error)
    #     else
    #         console.log 'reCAPTCHA verification passed!'
    #     #do stuff with your formData
    #     true
        
    # download_image: (image_url) ->
    #     #https://atmospherejs.com/froatsnook/request
    #     result = request.getSync(image_url, encoding: null)
    #     console.log 'server typeof', typeof result
    #     image = 'data:image/png;base64,' + new Buffer(result.body).toString('base64')
    #     return result



AccountsMeld.configure
    askBeforeMeld: false
    # meldDBCallback: meldDBCallback
    # serviceAddedCallback: serviceAddedCallback
    

serviceAddedCallback = (user_id, service_name) ->
    if service_name == 'linkedin'
        user = Meteor.users.findOne(user_id)
        link = user.services[service_name].publicProfileUrl
        if link
            Meteor.users.update user_id, $set: 'profile.linkedin': link
        if user.profile.position.length is 0
            headline = user.services['linkedin'].headline
            Meteor.users.update user_id, $set: 'profile.position': headline
    if service_name == 'facebook'
        user = Meteor.users.findOne(user_id)
        link = user.services[service_name].link
        if link
            Meteor.users.update user_id, $set: 'profile.facebook': link
        if user.profile.name.length is 0
            name = user.services['facebook'].name
            Meteor.users.update user_id, $set: 'profile.name': name
    if service_name == 'google'
        user = Meteor.users.findOne(user_id)
        picture = user.services['google'].picture
        Meteor.users.update user_id, $set: 'profile.google_image': picture
        if user.profile.name.length is 0
            name = user.services['google'].name
            Meteor.users.update user_id, $set: 'profile.name': name
    if service_name == 'twitter'
        user = Meteor.users.findOne(user_id)
        screen_name = user.services[service_name].screenName
        if screen_name
            Meteor.users.update user_id, $set: 'profile.twitter': "https://twitter.com/#{screen_name}"
    return

AccountsMeld.configure serviceAddedCallback: serviceAddedCallback
