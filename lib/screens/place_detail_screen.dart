// lib/screens/place_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart' show AppColors, AppGradients;
import '../widgets/tag_badge.dart';
import '../widgets/glow_button.dart';

class PlaceDetailScreen extends StatefulWidget {
  final Venue venue;

  const PlaceDetailScreen({super.key, required this.venue});

   @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  // 2. Add a state variable for the favorite status
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.venue.isFavorite;
  }
  
   Future<void> _launchMaps() async {
    final lat = widget.venue.latitude;
    final lon = widget.venue.longitude;
    final String venueName = Uri.encodeComponent(widget.venue.name);
    
    // Create a universal maps link. This works on both iOS and Android.
    // It will open in Google Maps if installed, otherwise in the browser.
    final String mapUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lon&query_place_id=${widget.venue.id}";

    // For a more native feel, we can check the platform and create specific links
    // final String mapUrl = Platform.isIOS 
    //   ? 'maps://?q=$venueName&ll=$lat,$lon' 
    //   : 'geo:$lat,$lon?q=$venueName';
    
    final Uri url = Uri.parse(mapUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $mapUrl');
      // Optionally show a SnackBar to the user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open maps application.")),
        );
      }
    }
  }

   // This helper function will launch a URL. It includes error handling.
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // You can show a SnackBar or Toast here in a real app
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Stack to place the Book Now button on top of the scrolling content
      body: Stack(
        children: [
          // The main scrolling content
          CustomScrollView(
            slivers: [
              _buildAppBar(context),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildTags(),
                      const SizedBox(height: 24),
                      _buildContactInfo(),
                      const SizedBox(height: 24),
                      const Text(
                        'About this place',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A placeholder description for ${widget.venue.name}. This vibrant ${widget.venue.type} is known for its ${widget.venue.tags.join(", ")} atmosphere and is a popular spot for locals and tourists alike. Enjoy a unique experience with us!',
                        style: TextStyle(color: Colors.grey[400], fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      // --- ADD THE REVIEWS SECTION HERE ---
                      _buildReviewsSection(),
                      const SizedBox(height: 24),
                      _buildMapPlaceholder(),
                      const SizedBox(height: 120), // Extra space to not be hidden by the button
                    ],
                  ),
                ),
              ),
            ],
          ),
          // The "Ride" button positioned at the bottom
          _buildRideButton(),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.darkPrimary,
      actions: [
        IconButton(
          icon: Icon(
            // Show a filled or outlined icon based on the state
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.redAccent : Colors.white,
          ),
          onPressed: () {
            // 4. Toggle the state when the button is pressed
            setState(() {
              isFavorite = !isFavorite;
            });
            // TODO: In the future, save this state to Firestore
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.venue.name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
        background: Hero(
          tag: 'venue-image-${widget.venue.id}',
          child: SvgPicture.asset(
          'assets/images/placeholder.svg', // Using a placeholder for now
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(AppColors.electricCyan.withOpacity(0.3), BlendMode.srcIn),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildHeader() {
    final bool isOpen = widget.venue.status == 'Open';
    final statusColor = isOpen ? AppColors.auroraGreen : AppColors.statusRed;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.venue.type, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: AppColors.sunsetOrange, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${widget.venue.rating} Stars',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        TagBadge(
          text: widget.venue.status,
          icon: Icons.access_time,
          color: statusColor,
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: widget.venue.tags.map((tag) => TagBadge(text: tag, color: AppColors.neonPurple)).toList(),
    );
  }

  Widget _buildMapPlaceholder() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.electricCyan.withOpacity(0.3)),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, size: 48, color: AppColors.electricCyan),
              SizedBox(height: 8),
              Text('Map Preview Coming Soon', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }

   // --- 5. CREATE THE NEW CONTACT INFO WIDGET ---
  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (widget.venue.websiteUrl != null)
            _buildContactIcon(Icons.language, 'Website', () => _launchUrl(widget.venue.websiteUrl!)),
          if (widget.venue.instagramUrl != null)
            _buildContactIcon(Icons.photo_camera_outlined, 'Instagram', () => _launchUrl(widget.venue.instagramUrl!)),
          if (widget.venue.phoneNumber != null)
            _buildContactIcon(Icons.phone_outlined, 'Call to book or inquire', () => _launchUrl('tel:${widget.venue.phoneNumber!}')),
          if (widget.venue.whatsappNumber != null)
            _buildContactIcon(Icons.chat_bubble_outline, 'WhatsApp', () => _launchUrl('https://wa.me/${widget.venue.whatsappNumber!}')),
        ],
      ),
    );
  }

  Widget _buildContactIcon(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: AppColors.electricCyan, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRideButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.darkPrimary.withOpacity(0.0),
              AppColors.darkPrimary.withOpacity(0.9),
              AppColors.darkPrimary,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.3, 0.6],
          ),
        ),
        child: GlowButton(
          onPressed: () {
            _launchMaps(); // Launch maps to the venue location
            // TODO: Integrate with Uber/ Safe boda
          },
          gradient: AppGradients.aurora,
          child: const Text('Order a Ride'),
        ),
      ),
    );
  }

  // In lib/screens/place_detail_screen.dart, inside the State class

Widget _buildReviewsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Reviews (2)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      _buildReviewItem('Alex Ray', 5, 'Absolutely stunning views and great cocktails. A must-visit!'),
      const Divider(color: AppColors.darkSecondary, height: 24),
      _buildReviewItem('Mia Wong', 4, 'Fun place, but it can get a bit crowded on weekends. Go early!'),
    ],
  );
}

Widget _buildReviewItem(String name, int rating, String comment) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: AppColors.sunsetOrange,
                size: 16,
              );
            }),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(comment, style: TextStyle(color: Colors.grey[400], height: 1.4)),
    ],
  );
}
}