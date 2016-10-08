Template.page.onCreated ->
    @autorun => Meteor.subscribe('page', @data.page)




Template.page.helpers
    page: -> 
        Docs.findOne {}