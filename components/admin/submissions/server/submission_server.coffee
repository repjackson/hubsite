Meteor.publish 'submissions', ->
    match = {}
    match.type = 'submission'
    
    
    Docs.find match