@People_tags = new Meteor.Collection 'people_tags'




Meteor.methods
    add_person: ()->
        Docs.insert {}

    delete_person: (id)->
        Docs.remove id

    remove_person_tag: (tag, doc_id)->
        Docs.update doc_id,
            $pull: tag

    add_person_tag: (tag, doc_id)->
        Docs.update doc_id,
            $addToSet: tags: tag
    
            
            
            
FlowRouter.route '/people', action: (params) ->
    BlazeLayout.render 'layout',
        nav: 'nav'
        cloud: 'people_cloud'
        main: 'people'

FlowRouter.route '/person/edit/:person_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_person'

FlowRouter.route '/person/view/:person_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'person_page'

