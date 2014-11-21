module Timepad
  class Mail < Base
    MAIL_PARAMS_MAPPING = {
      subject: :name,
      event: :e_id
    }.freeze

    MAIL_COMMON_PARAMS = [:e_id, :name, :text, :reply_to, :template, :org_info]

    def initialize(timepad_client)
      @client = timepad_client
    end

    # Create and send mail
    #
    # @param attrs [Hash] mail attributes
    # @return [Array]
    def create(attrs)
      params = {}

      params.merge! extract_mail(attrs)
      params.merge! extract_subscribers(attrs)
      params.merge! extract_maillists(attrs)

      request 'create', params
    end

    protected

    def extract_mail(attrs)
      params = {}

      MAIL_PARAMS_MAPPING.each do |from, to|
        params[to] = attrs[from] if attrs.key?(from)
      end

      MAIL_COMMON_PARAMS.each do |key|
        params[key] = attrs[key] if attrs.key?(key)
      end

      params
    end

    def extract_subscribers(attrs)
      params = {}
      if attrs.key?(:subscribers)
        attrs[:subscribers].each_with_index do |email, index|
          params["a#{index}".to_sym] = email
        end
      end

      params
    end

    def extract_maillists(attrs)
      params = {}
      attrs[:maillists] ||= []
      attrs[:maillists] << attrs[:maillist] if attrs.key?(:maillist)

      attrs[:maillists].each_with_index do |maillist_id, index|
        params["m#{index}".to_sym] = maillist_id
      end

      params
    end
  end
end
