require_relative('../models/artist.rb')
require_relative('../models/album.rb')

eminem = Artist.new({
  'name' => 'Eminem'
  })

green_day = Artist.new({
  'name' => 'Green Day'
  })

# eminem.save()
# green_day.save()

curtain_call_album = Album.new({
    'title' => 'Curtain Call',
    'genre' => 'Rap',
    'artist_id' => eminem.id
    })

american_idiot_album = Album.new({
    'title' => 'American Idiot',
    'genre' => 'Pop Rock',
    'artist_id' => green_day.id
    })

century_breakdown_album = Album.new({
    'title' => '21st Century Breakdown',
    'genre' => 'Pop Rock',
    'artist_id' => green_day.id
    })

# curtain_call_album.save()
# american_idiot_album.save()
# century_breakdown_album.save()

# eminem.name = 'Marshall Mathers'
# eminem.update()

# eminem.delete()

# curtain_call_album.genre = 'Hip Hop'
# curtain_call_album.update()

# century_breakdown_album.delete()

# p Artist.list_all

# p Album.list_all

# p green_day.albums

# p curtain_call_album.artist

# p Artist.find_by_id(1)
#
# p Album.find_by_id(1)
