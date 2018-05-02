module QuestionMacros
  def create_question
    visit new_question_path

    fill_in 'Title', with: 'NewTitle'
    fill_in 'Body', with: 'NewBody'

    click_on 'Create question'
  end

  def create_answer(answer)
    fill_in 'answer_body', with: answer

    click_on 'Create answer'
  end
end