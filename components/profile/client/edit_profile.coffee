
Template.edit_profile.onCreated ->
    @autorun -> Meteor.subscribe 'user_profile'



Template.edit_profile.helpers
    # person: -> Meteor.users.findOne FlowRouter.getParam('user_id')
    profile_doc: -> Docs.findOne()

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
    # 'click #save_profile': ->
    #     name = $('#name').val()
    #     profile_doc_id = Docs.findOne()
    #     Docs.update profile_doc_id,
    #         $set:
    #             "profile.name": name
    #             "profile.bio": bio
    #             "profile.website": website
    #             "profile.position": position
    #             "profile.company": company
    #     FlowRouter.go "/profile/view/#{Meteor.userId()}"

    'blur #name': ->
        name = $('#name').val()
        profile_doc_id = Docs.findOne()._id
        Docs.update profile_doc_id,
            $set: title: name
            



    'keydown #add_tag': (e,t)->
        if e.which is 13
            tag = $('#add_tag').val().toLowerCase().trim()
            if tag.length > 0
                profile_doc_id = Docs.findOne()._id
                Docs.update profile_doc_id,
                    $addToSet: tags: tag
                $('#add_tag').val('')

    'click .profile_tag': (e,t)->
        tag = @valueOf()
        profile_doc_id = Docs.findOne()._id
        Docs.update profile_doc_id,
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
        console.log files
        Cloudinary.upload files[0],
            # folder:"secret" # optional parameters described in http://cloudinary.com/documentation/upload_images#remote_upload
            # type:"private" # optional: makes the image accessible only via a signed url. The signed url is available publicly for 1 hour.
            (err,res) -> #optional callback, you can catch with the Cloudinary collection as well
                # console.log "Upload Error: #{err}"
                # console.dir res
                if err
                    console.error 'Error uploading', err
                else
                    profile_doc_id = Docs.findOne()._id
                    Docs.update profile_doc_id,
                        $set: "image_id": res.public_id
                return

    'click #pick_google_image': ->
        picture = Meteor.user().profile.google_image
        Meteor.call 'download_image', picture, (err, res)->
            if err
                console.error err
            else
                console.log typeof res
                Cloudinary.upload res,
                    # folder:"secret" # optional parameters described in http://cloudinary.com/documentation/upload_images#remote_upload
                    # type:"private" # optional: makes the image accessible only via a signed url. The signed url is available publicly for 1 hour.
                    (err,res) -> #optional callback, you can catch with the Cloudinary collection as well
                        # console.log "Upload Error: #{err}"
                        # console.dir res
                        if err
                            console.error 'Error uploading', err
                        else
                            console.log 'i think this worked'
                            Meteor.users.update Meteor.userId(), 
                                $set: "profile.image_id": res.public_id
                        return


    'click #remove_photo': ->
        profile_doc_id = Docs.findOne()._id
        Docs.update profile_doc_id,
            $unset: "image_id": 1
