@Post_tags = new Meteor.Collection 'post_tags'

Meteor.methods
    add_post: ()->
        Docs.insert
            type: 'post'
            tags: []

    delete_post: (id)->
        Docs.remove id

    remove_post_tag: (tag, doc_id)->
        Docs.update doc_id,
            $pull: tag

    add_post_tag: (tag, doc_id)->
        Docs.update doc_id,
            $addToSet: tags: tag