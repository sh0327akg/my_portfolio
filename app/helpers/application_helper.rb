module ApplicationHelper
  def page_title(page_title = '')
    base_title = "草刈山雄"
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end

  def default_meta_tags
    {
      site: '草刈山雄',
      title: 'GitHubの草、そのままにしてませんか？今すぐ草を刈ろう!',
      reverse: true,
      separator: '|',
      description: '「草刈山雄」は、GitHubの草から日本にある山の標高と比較し、プログラミングの積み上げを記録するアプリケーションです。生やした草を地図に移植させていこう!',
      keywords:'草刈山雄',
      charset: 'UTF-8',
      canonical: request.original_url,
      noidex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon-icon.png'), sizes: '32x32' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@muramyy1',
        image: image_url('ogp.png')
      }
    }
  end
end
