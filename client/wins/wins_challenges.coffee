Template.wins_challenges.onCreated ->
    @autorun -> Meteor.subscribe 'usernames'
    @autorun -> Meteor.subscribe('wins')

Template.wins_challenges.helpers
    wins: -> Docs.find( tags: $all: ['impact hub', 'boulder', 'win'] )
    challenges: -> Docs.find( tags: $all: ['impact hub', 'boulder', 'challenge'] )
    isAuthor: -> @authorId is Meteor.userId()
    vote_upButtonClass: ->
        if not Meteor.userId() then 'disabled basic'
        else if Meteor.userId() in @up_voters then 'green'
        else 'basic'

Template.wins_challenges.events
    'keydown #add_win': (e,t)->
        e.preventDefault
        switch e.which
            when 13
                text = t.find('#add_win').value.trim()
                if text.length > 0
                    Meteor.call 'add_win', text, (err,res)->
                        t.find('#add_win').value = ''

    'keydown #add_challenge': (e,t)->
        e.preventDefault
        switch e.which
            when 13
                text = t.find('#add_challenge').value.trim()
                if text.length > 0
                    Meteor.call 'add_challenge', text, (err,res)->
                        t.find('#add_challenge').value = ''

    'click .delete_doc': ->
        Meteor.call 'delete_doc', @_id

    'click .vote_up': -> if Meteor.userId() then Meteor.call 'vote_up', @_id
