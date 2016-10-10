Template.card_view.events
    'click .item_tag': ->
        if @valueOf() in selected_tags.array() then selected_tags.remove @valueOf() else selected_tags.push @valueOf()