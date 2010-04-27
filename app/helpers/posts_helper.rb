module PostsHelper
  
  def post_post_path(post)
    if post.new_document?
      posts_path
    else
      post_path({:id => post.slug})
    end
  end
  
end
