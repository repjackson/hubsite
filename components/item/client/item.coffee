Template.item.events
    'click .doc_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()
        
Template.item.helpers
    tag_class: -> if @valueOf() in selected_tags.array() then 'red' else 'basic'

    # eco_tags: ->
    #     _.without(@tags, 'ecosystem') 
