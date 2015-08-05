include_attribute "ffmpeg"

default.ffmpeg.install_method = :source

default.ffmpeg.compile_flags = [
  "--disable-debug",
  "--enable-pthreads",
  "--enable-nonfree",
  "--enable-gpl",
  "--enable-libfaac",
  "--enable-libmp3lame",
  "--enable-libvorbis",
  "--enable-libfdk_aac"
]

default.ffmpeg.git_revision = "f406bf3fa933be089bd76a95f75ea57b0942f8c5" # 2.2.3

#----------

include_attribute "x264"

default.x264.compile_flags = ["--enable-static","--disable-lavf"]