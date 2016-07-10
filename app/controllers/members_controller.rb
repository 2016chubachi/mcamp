class MembersController < ApplicationController
  # before_action :logged_in_member, only: [:edit, :update]
  before_action :logged_in_member, only: [:edit, :update]
  before_action :correct_member, only: [:edit, :update]
  before_action :admin_member,     only: [:index, :destroy]


  def index
    # @members = Member.all
    @members = Member.page(params[:page])
  end

  # member 新規作成フォーム
  def new
    @member = Member.new
  end

  # member 情報の詳細
  def show
    @member = Member.find(params[:id])
  end

  # 会員の新規登録
    def create
      @member = Member.new(member_params)
      if @member.save
        @member.send_activation_email
        # flash.now[:notice] = "アカウントの有効にするメールを登録したメールに送りました。ご確認下さい。"
        redirect_to root_url
        flash[:notice] = "アカウントの有効にするメールを登録したメールに送りました。ご確認下さい。"
      else
        render "new"
      end
    end

    # 会員情報の編集
      def edit
       @member = Member.find(params[:id])
      end

    # member update
      def update
       @member = Member.find(params[:id])
        if @member.update_attributes(member_params)
            redirect_to root_url
            flash.now[:notice] = "ユーザー情報が更新されました。"
        else
          render 'edit'
        end
      end

    # 会員の削除
     def destroy
       Member.find(params[:id]).destroy
       flash.now[:info] = "ユーザーを削除しました。"
       redirect_to members_path
     end

    private

       def member_params
         params.require(:member).permit(:name, :user_name, :email, :password,
                                   :password_confirmation,  :gender,
                                   :authority_id, :generation_id, :self_introduction,:activation_digest,
                                   :password_digest)
       end

        # def logged_in_member
        #   unless logged_in?
        #     store_location
        #     flash[:danger] = "ログインしてください。"
        #     redirect_to login_url
        #   end
        # end

        def correct_member
          @member = Member.find(params[:id])
          redirect_to(root_url) unless current_member?(@member)
        end

        # def admin_user
        #  redirect_to(root_url) unless current_user.admin?
        # end


end
