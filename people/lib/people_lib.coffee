@People_tags = new Meteor.Collection 'people_tags'
@People = new Meteor.Collection 'people'


People.helpers
    attendees: ->
        if @attendee_ids?.length > 0
            attendeeArray = []
            for id in @attendee_ids
                attendeeArray.push(Meteor.users.findOne(id))
            return attendeeArray
        else return
    
    author: -> Meteor.users.findOne @author_id

People.before.insert (userId, doc)->
    doc.timestamp = Date.now()
    doc.author_id = Meteor.userId()
    attendee_ids = []
    return

# People.after.update ((userId, doc, fieldNames, modifier, options) ->
#     doc.tagCount = doc.tags.length
# ), fetchPrevious: true


Meteor.methods
    add_person: ()->
        People.insert {}

    delete_person: (id)->
        People.remove id

    remove_person_tag: (tag, doc_id)->
        People.update doc_id,
            $pull: tag

    add_person_tag: (tag, doc_id)->
        People.update doc_id,
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

