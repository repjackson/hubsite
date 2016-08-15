Template.footer.helpers
    footer: Docs.find()



# Template.footer.onCreated ->
#     self = @
#     self.autorun ->
#         self.subscribe 'featured_events'


Template.footer.events
    'click #submit_contact_form': ->
        contact_reason = $('input[name="reason"]:checked').val()
        console.log contact_reason
        formData = {}
        #get the captcha data
        captchaData = grecaptcha.getResponse()
        Meteor.call 'formSubmissionMethod', formData, captchaData, (error, result) ->
            # reset the captcha
            grecaptcha.reset()
            if error
                console.log 'There was an error: ' + error.reason
            else
                console.log 'Success!'
            return
        return
