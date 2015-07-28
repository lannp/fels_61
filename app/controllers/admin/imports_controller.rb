class Admin::ImportsController < ApplicationController
  def create
    import_csv_file params[:file]
    flash[:success] = t "import_successfull_message"
    redirect_to admin_words_path
  end

  private
  def import_csv_file file
    CSV.open(file.path, headers: true).each do |row|
      category_name = row["category_name"]
      word_content = row["word"]
      answer = row["answer"]
      answer_status = row["answer_status"]
      category = save_data(Category, {name: category_name}, {name: category_name})
      word = save_data(Word, {content: word_content}, {content: word_content, category_id: category.id})
      save_data(Answer, {content: answer, word_id: word.id},
        {word_id: word.id, content: answer, status: answer_status})
    end
  end

  def save_data model, check_fields, data
    existedModel = model.find_by check_fields
    if existedModel
      flash.now[:danger] = "update_failed_message" unless existedModel.update_attributes data
      existedModel   
    else
      model.create! data
    end
  end
end
