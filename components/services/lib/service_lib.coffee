@Service_tags = new Meteor.Collection 'service_tags'
@Services = new Meteor.Collection 'services'

Services.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    return



Meteor.methods
    add_service: ()->
        Services.insert
            tags: []

    delete_service: (id)->
        Services.remove id

    remove_service_tag: (tag, doc_id)->
        Services.update doc_id,
            $pull: tag

    add_service_tag: (tag, doc_id)->
        Services.update doc_id,
            $addToSet: tags: tag