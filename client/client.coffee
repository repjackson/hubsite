Meteor.startup ->
    reCAPTCHA.config
        publickey: Meteor.settings.public.recaptcha_public

