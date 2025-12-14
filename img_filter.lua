function RawInline(el)
  -- 只处理 HTML 代码
  if el.format == "html" then
    local html = el.text
    
    -- 1. 提取图片路径 src
    -- 兼容单引号 src='...' 和双引号 src="..."
    local src = html:match('src=["\']([^"\']+)["\']')
    
    -- 如果没找到路径，说明不是图片，直接跳过
    if not src then return nil end

    local attributes = {}

    -- 2. 提取 Typora 的 zoom 比例
    -- 正则解析：寻找 "zoom:" 后面跟着的数字
    -- 例子: style="zoom:50%;" -> 提取出 50
    local zoom = html:match('zoom:%s*(%d+)%%?')

    -- 新增: 提取 style 中的 width (例如 style="width:500px")
    local style_width = html:match('width:%s*([^;\'"]+)')

    if zoom then
      -- 关键点：Pandoc 只要收到 "50%" 这样的字符串属性
      -- 它在转 PDF 时，会自动将其换算为 width=0.5\textwidth
      attributes.width = zoom .. "%"
    elseif style_width then
      -- 如果检测到 style="width:..."，直接使用该宽度
      attributes.width = style_width
    else
      -- 3. 如果没有 zoom 也没有 style width，尝试找找标准的 width 属性作为备选
      local width = html:match('width=["\']([^"\']+)["\']')
      if width then 
        attributes.width = width 
      end
    end

    -- 4. 返回原生图片对象
    -- 我们完全忽略了 align，图片将默认居中或靠左（取决于你的 LaTeX 模板）
    return pandoc.Image(
      {},          -- Caption (空)
      src,         -- src
      "",          -- Title
      attributes   -- 属性列表 (包含 width="50%")
    )
  end
end