Meteor.startup ->
    reCAPTCHA.config
        publickey: Meteor.settings.public.recaptcha_public

$.cloudinary.config
    cloud_name:"facet"
