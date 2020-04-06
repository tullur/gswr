# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_article

  def create
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user

    redirect_to article_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy if @comment.user == @current_user

    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
