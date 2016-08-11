
# Template.edit_profile.onCreated ->
#     @autorun -> Meteor.subscribe 'people'
#     @autorun -> Meteor.subscribe 'myTags', selectedtags.array()



Template.edit_profile.helpers
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


Template.edit_profile.events
    'keydown #addtag': (e,t)->
        e.preventDefault
        tag = $('#addtag').val().toLowerCase().trim()
        switch e.which
            when 13
                if tag.length > 0
                    Meteor.call 'addtag', tag, ->
                        $('#addtag').val('')

    'keydown #name': (e,t)->
        e.preventDefault
        name = $('#name').val().trim()
        switch e.which
            when 13
                if name.length > 0
                    Meteor.call 'update_name', name, (err,res)->
                        swal "Updated name to #{name}."
    
    'change [name="upload_picture"]': (event, template) ->
        # template.uploading.set true
        console.log event.target.files
        uploader = new (Slingshot.Upload)('myFileUploads')
        uploader.send event.target.files[0], (error, download_url) ->
            if error
                # Log service detailed response.
                console.error 'Error uploading', uploader.xhr.response
                console.error 'Error uploading', error
                alert error
            else
                Meteor.users.update Meteor.userId(), 
                    $set: 'profile.profile_image_url': download_url
                # Docs.update post_id, $set: featured_image_url: download_url
            return

    'click #remove_photo': ->
        Meteor.users.update Meteor.userId(), 
            $unset: 'profile.profile_image_url': 1
    
    'keydown #company': (e,t)->
        e.preventDefault
        if e.which is 13
            company = $('#company').val().trim()
            if company.length > 0
                Meteor.users.update Meteor.userId(),
                    $set: "profile.company": company
                , (err, res)->
                    swal "Updated Company to #{company}"

    'click .tag': ->
        tag = @valueOf()
        Meteor.call 'removetag', tag, ->
            $('#addtag').val(tag)
