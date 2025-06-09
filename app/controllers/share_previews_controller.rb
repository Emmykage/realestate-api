    class SharePreviewsController < ApplicationController
        def press_release
            @blog = Blog.find(params[:id])
            render layout: false

        end

    end