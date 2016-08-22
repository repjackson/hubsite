Template.edit_image.events
    "change input[type='file']": (e) ->
        doc_id = FlowRouter.getParam('doc_id')
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
                    Docs.update doc_id, $set: image_id: res.public_id
                return

    'click #remove_photo': ->
        # console.log @image_id
        
# 		Cloudinary.delete @image_id, (err,res) ->
# 			console.log "Upload Error: #{err}"
# 			console.log "Upload Result: #{res}"

        # Cloudinary.destroy @image_id, (result) ->
        #     console.log result

        Docs.update FlowRouter.getParam('doc_id'), 
            $unset: image_id: 1

Template.edit_image.helpers
    log: -> console.log @