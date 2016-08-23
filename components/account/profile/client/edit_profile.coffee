
Template.edit_profile.onCreated ->
    @autorun -> Meteor.subscribe 'me'



Template.edit_profile.helpers
    # person: -> Meteor.user()

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
    'keydown #add_person_tag': (e,t)->
        if e.which is 13
            tag = $('#add_person_tag').val().toLowerCase().trim()
            if tag.length > 0
                Meteor.users.update Meteor.userId(),
                    $addToSet: tags: tag
                $('#add_person_tag').val('')

    'click .person_tag': (e,t)->
        tag = @valueOf()
        Meteor.users.update Meteor.userId(),
            $pull: tags: tag
        $('#add_person_tag').val(tag)





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
                "profile.name": name
                "profile.bio": bio
                "profile.website": website
                "profile.twitter": twitter
                "profile.facebook": facebook
                "profile.linkedin": linkedin
                "profile.position": position
                "profile.company": company
        FlowRouter.go "/profile/view/#{Meteor.userId()}"



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
                        $set: "profile.image_id": res.public_id
                return

    'click #remove_photo': ->
        # console.log @image_id
        
# 		Cloudinary.delete @image_id, (err,res) ->
# 			console.log "Upload Error: #{err}"
# 			console.log "Upload Result: #{res}"

        # Cloudinary.destroy @image_id, (result) ->
        #     console.log result

        Meteor.users.update Meteor.userId(), 
            $unset: "profile.image_id": 1
