Grover.configure do |config|
  config.options = {
    format: 'A3',
    margin: {
      top: '20px',
      bottom: '20px'
    },
    viewport: {
      width: 1280,
      height: 800
    },
    landscape: true,
    prefer_css_page_size: true,
    emulate_media: 'screen',
    cache: false,
    timeout: 0, # Timeout in ms. A value of `0` means 'no timeout'
    wait_until: 'domcontentloaded' 
  }
end
