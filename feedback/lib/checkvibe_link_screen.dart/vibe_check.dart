class VibeCheck {
  final String? url;
  final String? type; // Can be "video" or "image" to differentiate the type
  final String? title;

  VibeCheck({
    required this.url,
    this.type = "video",
    this.title,
  });
}

final List<VibeCheck> vibeCheckDataList = [
  VibeCheck(
    url:
        'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // Rick Astley - Never Gonna Give You Up
    title: 'Never Gonna Give You Up',
  ),
  VibeCheck(
    url: 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ', // Alan Walker - Faded
    title: 'Faded',
  ),
  VibeCheck(
    url: 'https://www.youtube.com/watch?v=9bZkp7q19f0', // PSY - Gangnam Style
    title: 'Gangnam Style',
  ),
  VibeCheck(
    url:
        'https://www.youtube.com/watch?v=60ItHLz5WEA', // The Chainsmokers - Closer
    title: 'Closer',
  ),
  VibeCheck(
    url:
        'https://www.youtube.com/watch?v=RgKAFK5djSk', // Wiz Khalifa - See You Again
    title: 'See You Again',
  ),
  VibeCheck(
    url:
        'https://youtu.be/izGwDsrQ1eQ?si=AOXklYkP5_nDAmaG', // Ed Sheeran - Shape of You
    title: 'Shape of You',
  ),
  VibeCheck(
    url: 'https://www.youtube.com/watch?v=LsoLEjrDogU', // Maroon 5 - Sugar
    title: 'Sugar',
  ),
];
