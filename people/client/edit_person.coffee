
Template.edit_person.onCreated ->
    @autorun -> Meteor.subscribe 'person', FlowRouter.getParam('person_id')



Template.edit_person.helpers
    person: -> Docs.findOne()

    # matchedUsersList:->
    #     users = Meteor.users.find({_id: $ne: Meteor.userId()}).fetch()
    #     userMatches = []
    #     for user in users
    #         tagIntersection = _.intersection(user.tags, Meteor.user().tags)
    #         userMatches.push
    #             matchedUser: user.username
    #             tagIntersection: tagIntersection
    #             length: tagIntersection.length
    #     sortedList = _.sortBy(userMatches, 'length').reverse()
    #     return sortedList

    # upVotedMatchCloud: ->
    #     users = Meteor.users.find({_id: $ne: Meteor.userId()}).fetch()
    #     userMatchClouds = []
    #     for user in users
    #         myUpVotedCloud = Meteor.user().upvotedCloud
    #         myUpVotedList = Meteor.user().upvotedList
    #         # console.log 'myUpVotedCloud', myUpVotedCloud
    #         otherUpVotedCloud = user.upvotedCloud
    #         otherUpVotedList = user.upvotedList
    #         # console.log 'otherCloud', otherUpVotedCloud
    #         intersection = _.intersection(myUpVotedList, otherUpVotedList)
    #         intersectionCloud = []
    #         totalCount = 0
    #         for tag in intersection
    #             myTagObject = _.findWhere myUpVotedCloud, name: tag
    #             hisTagObject = _.findWhere otherUpVotedCloud, name: tag
    #             # console.log hisTagObject.count
    #             min = Math.min(myTagObject.count, hisTagObject.count)
    #             totalCount += min
    #             intersectionCloud.push
    #                 tag: tag
    #                 min: min
    #         sortedCloud = _.sortBy(intersectionCloud, 'min').reverse()
    #         userMatchClouds.push
    #             matchedUser: user.username
    #             cloudIntersection: sortedCloud
    #             totalCount: totalCount


    #     sortedCloud = _.sortBy(userMatchClouds, 'totalCount').reverse()
    #     return sortedCloud


Template.edit_person.events
    'keydown #add_tag': (e,t)->
        e.preventDefault
        tag = $('#add_tag').val().toLowerCase().trim()
        if e.which is 13
            if tag.length > 0
                person_id = FlowRouter.getParam('person_id')
                Docs.update person_id,
                    $addToSet: tags: tag
                    , ->
                        $('#add_tag').val('')


    

    'click #remove_photo': ->
        Docs.update FlowRouter.getParam('person_id'), 
            $unset: 'person_image_url': 1
    

    'click .person_tag': ->
        tag = @valueOf()
        person_id = FlowRouter.getParam('person_id')
        Docs.update person_id,
            $pull: tags: tag
            , ->
                $('#add_tag').val(tag)

    'click #save_person': ->
        name = $('#name').val()
        bio = $('#bio').val()
        website = $('#website').val()
        twitter = $('#twitter').val()
        facebook = $('#facebook').val()
        linkedin = $('#linkedin').val()
        position = $('#position').val()
        company = $('#company').val()
        Docs.update FlowRouter.getParam('person_id'),
            $set:
                name: name
                bio: bio
                website: website
                twitter: twitter
                facebook: facebook
                linkedin: linkedin
                position: position
                company: company
        selected_people_tags.clear()
        for tag in @tags
            selected_people_tags.push tag
        FlowRouter.go "/person/view/#{@_id}"

