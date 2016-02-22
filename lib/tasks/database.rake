namespace :db do
  desc "Migrates data from the old notes DB structure into Forem. Idempotent (hopefully)."
  task migrate_notes: :environment do
    # Hack to get around the way Forem handles the first poster
    Forem::Topic.module_eval do
      def set_first_post_user
        post = posts.first
        post.try :user=, user
      end
    end

    ActiveRecord::Base.transaction do
      board = Forem::Forum.first
      MainBoard.find_each do |old_topic|
        topic = Forem::Topic.create_with(
          forum: board,
          user: old_topic.account,
          subject: old_topic.title,
          created_at: old_topic.created,
          last_post_at: old_topic.lastupdated,
        ).find_or_create_by!(slug: old_topic.id)
        # Forem wants to subscribe the first poster to the thread
        topic.subscriptions.destroy_all

        old_topic.sub_boards.each do |old_post|
          Forem::Post.create_with(
            text: old_post.contents,
          ).find_or_create_by!(topic: topic, user_id: old_post.userid, created_at: old_post.created)
        end
      end
    end
  end
end
