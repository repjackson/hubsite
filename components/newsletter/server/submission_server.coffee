Meteor.publish 'newsletter_sign_up_list', ->
    match = {}
    match.type = 'newsletter_sign_up_list'
    
    
    Docs.find match