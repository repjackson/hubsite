Template.favorite.helpers
    favorite_count: -> Template.parentData(0).favorite_count
    
    favorite_item_class: -> if Template.parentData(0).favoriters and Meteor.userId() in Template.parentData(0).favoriters then 'red' else 'outline'
    
Template.favorite.events
    'click .favorite_item': -> 
        # console.log Template.parentData(0)
        Meteor.call 'favorite', Template.parentData(0)
