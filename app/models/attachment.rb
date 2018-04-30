class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true

  mount_uploader :file, FileUploader

  def set_question
    if attachable_type == "Question"
      return Question.find(attachable_id)
    else
      return Answer.find(attachable_id).question
    end
  end
end
