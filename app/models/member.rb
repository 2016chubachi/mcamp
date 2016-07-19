class Member < ActiveRecord::Base
    has_many :loan_items
    has_many :borrow_items
    has_many :borrow_replies
    has_many :posts
    has_many :post_replies
    has_many :requests
    belongs_to :authority
    belongs_to :generation
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save { email.downcase! }
    before_create :create_activation_digest


    ##### validate name, email
    validates :name,  presence: true, length: { maximum: 20 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum: 40 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }


    has_secure_password
    validates :password, presence: true, length: { in: 6..16 }, allow_nil: true
    ##### validate user_name
    validates :user_name, presence: true, length: { maximum: 20 },
                           uniqueness: true
    validates :self_introduction, length: { maximum: 200}

    validates :agreement,  acceptance: true

     class << self
      def digest(string)
       cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end


      def new_token
       SecureRandom.urlsafe_base64
      end
    end


     def remember
      self.remember_token = Member.new_token
       update_attribute(:remember_digest, Member.digest(remember_token))
     end

     def authenticated?(attribute, token)
       digest = send("#{attribute}_digest")
       return false if digest.nil?
       BCrypt::Password.new(digest).is_password?(token)
     end

     def forget
      update_attribute(:remember_digest, nil)
     end

     def activate
       update_attribute(:activated,    true)
       update_attribute(:activated_at, Time.zone.now)
     end

     def send_activation_email
        MemberMailer.account_activation(self).deliver_now
     end

     def create_reset_digest
       self.reset_token = Member.new_token
       update_attribute(:reset_digest, Member.digest(reset_token))
       update_attribute(:reset_sent_at, Time.zone.now)
     end

     def send_password_reset_email
       MemberMailer.password_reset(self).deliver_now
     end

      def password_reset_expired?
        reset_sent_at < 2.hours.ago
      end


    private

      def downcase_email
        self.email = email.downcase
      end

      def create_activation_digest
        self.activation_token = Member.new_token
        self.activation_digest = Member.digest(activation_token)
      end
end
