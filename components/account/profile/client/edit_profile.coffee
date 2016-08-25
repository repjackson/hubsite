
Template.edit_profile.onCreated ->
    @autorun -> Meteor.subscribe 'my_profile'



Template.edit_profile.helpers
    person: -> Meteor.users.findOne FlowRouter.getParam('user_id')

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
    'click #save_profile': ->
        name = $('#name').val()
        bio = $('#bio').val()
        website = $('#website').val()
        twitter = $('#twitter').val()
        facebook = $('#facebook').val()
        linkedin = $('#linkedin').val()
        position = $('#position').val()
        company = $('#company').val()
        Meteor.users.update Meteor.userId(),
            $set:
                "name": name
                "bio": bio
                "website": website
                "linkedin": linkedin
                "twitter": twitter
                "facebook": facebook
                "position": position
                "company": company
        FlowRouter.go "/profile/view/#{Meteor.userId()}"

    'keydown #add_tag': (e,t)->
        if e.which is 13
            tag = $('#add_tag').val().toLowerCase().trim()
            if tag.length > 0
                Meteor.users.update Meteor.userId(),
                    $addToSet: tags: tag
                $('#add_tag').val('')

    'click .profile_tag': (e,t)->
        tag = @valueOf()
        Meteor.users.update Meteor.userId(),
            $pull: tags: tag
        $('#add_tag').val(tag)


    'click #make_published': ->
        Meteor.users.update Meteor.userId(),
            $set: published: true

    'click #make_unpublished': ->
        Meteor.users.update Meteor.userId(),
            $set: published: false



    "change input[type='file']": (e) ->
        files = e.currentTarget.files

        Cloudinary.upload files[0],
            # folder:"secret" # optional parameters described in http://cloudinary.com/documentation/upload_images#remote_upload
            # type:"private" # optional: makes the image accessible only via a signed url. The signed url is available publicly for 1 hour.
            (err,res) -> #optional callback, you can catch with the Cloudinary collection as well
                # console.log "Upload Error: #{err}"
                # console.dir res
                if err
                    console.error 'Error uploading', err
                else
                    Meteor.users.update Meteor.userId(), 
                        $set: image_id: res.public_id
                return

    'click #remove_photo': ->
        Meteor.users.update Meteor.userId(), 
            $unset: image_id: 1
