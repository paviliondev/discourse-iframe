# frozen_string_literal: true

# name: discourse-iframe
# about: Allow Discourse to run in an iframe
# version: 0.1
# authors: Angus McLeod
# url: https://github.com/paviliondev/discourse-iframe

enabled_site_setting :discourse_iframe_enabled

after_initialize do
  SiteSetting.allow_embedding_site_in_an_iframe = true
  
  extend_content_security_policy(
    frame_ancestors: SiteSetting.content_security_policy_frame_ancestors.split('|')
  )
  
  module ContentSecurityPolicyBuilderExtension
    private def extendable?(directive)
      super || directive == :frame_ancestors
    end
  end
  
  ContentSecurityPolicy::Builder.prepend ContentSecurityPolicyBuilderExtension
end