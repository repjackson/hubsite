Template.card_view.events
    'click .eco_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()
        
Template.card_view.helpers
    eco_tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    eco_tags: ->
        _.without(@tags, 'ecosystem') 
