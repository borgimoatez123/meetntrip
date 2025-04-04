<?php

namespace App\Controller;

use App\Entity\Booking;
use App\Entity\Flight;
use App\Entity\Hotel;
use App\Entity\Transport;
use App\Entity\ConferenceLocation;
use App\Entity\Evenement;
use App\Entity\User;
use App\Repository\FlightRepository;
use App\Repository\HotelRepository;
use App\Repository\TransportRepository;
use App\Repository\ConferenceLocationRepository;
use App\Repository\EvenementRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class BookingController extends AbstractController
{
    #[Route('/booking', name: 'app_booking')]
    public function index(
        Request $request,
        FlightRepository $flightRepository,
        HotelRepository $hotelRepository,
        TransportRepository $transportRepository,
        ConferenceLocationRepository $conferenceLocationRepository,
        EvenementRepository $evenementRepository,
        UserRepository $userRepository
    ): Response {
        // Get all parameters from previous steps
        $flightId = $request->query->get('flight_id');
        $flightPrice = $request->query->get('flight_price');
        $departureTime = $request->query->get('departure_time');
        $backTime = $request->query->get('back_time');
        
        $hotelId = $request->query->get('hotel_id');
        $hotelPrice = $request->query->get('hotel_price');
        
        $locationId = $request->query->get('location_id');
        $conferencePrice = $request->query->get('conference_price');
        
        $transportId = $request->query->get('transport_id');
        $transportPrice = $request->query->get('transport_price');
        
        $userId = $request->query->get('userid');
        $idEvenement = $request->query->get('id_evenement');
        $dateDebut = $request->query->get('date_debut');
        $dateFin = $request->query->get('date_fin');
        $nombreInvite = $request->query->get('nombre_invite');

        // Fetch related entities
        $flight = $flightId ? $flightRepository->find($flightId) : null;
        $hotel = $hotelId ? $hotelRepository->find($hotelId) : null;
        $transport = $transportId ? $transportRepository->find($transportId) : null;
        $conferenceLocation = $locationId ? $conferenceLocationRepository->find($locationId) : null;
        $evenement = $idEvenement ? $evenementRepository->find($idEvenement) : null;
        $user = $userId ? $userRepository->find($userId) : null;

        // Calculate total price
        $totalPrice = 0;
        if ($flightPrice) $totalPrice += floatval($flightPrice);
        if ($hotelPrice) $totalPrice += floatval($hotelPrice);
        if ($transportPrice) $totalPrice += floatval($transportPrice);
        if ($conferencePrice) $totalPrice += floatval($conferencePrice);

        return $this->render('booking/index.html.twig', [
            'flight' => $flight,
            'hotel' => $hotel,
            'transport' => $transport,
            'conferenceLocation' => $conferenceLocation,
            'evenement' => $evenement,
            'user' => $user,
            
            'flight_id' => $flightId,
            'flight_price' => $flightPrice,
            'departure_time' => $departureTime,
            'back_time' => $backTime,
            'airline' => $flight ? $flight->getAirline() : null,
            
            'hotel_id' => $hotelId,
            'hotel_price' => $hotelPrice,
            
            'location_id' => $locationId,
            'conference_price' => $conferencePrice,
            
            'transport_id' => $transportId,
            'transport_price' => $transportPrice,
            
            'userid' => $userId,
            'id_evenement' => $idEvenement,
            'date_debut' => $dateDebut,
            'date_fin' => $dateFin,
            'nombre_invite' => $nombreInvite,
            
            'price_total' => $totalPrice,
        ]);
    }
    
    #[Route('/booking/save', name: 'app_booking_save', methods: ['POST'])]
    public function save(
        Request $request,
        EntityManagerInterface $entityManager,
        FlightRepository $flightRepository,
        HotelRepository $hotelRepository,
        TransportRepository $transportRepository,
        ConferenceLocationRepository $conferenceLocationRepository,
        EvenementRepository $evenementRepository,
        UserRepository $userRepository
    ): Response {
        $booking = new Booking();
        
        // Set basic booking info
        $booking->setBookingDate(new \DateTime());
        $booking->setStatus('pending');
        $booking->setSpecialRequests($request->request->get('special_requests'));
        
        // Set flight details
        $flightId = $request->request->get('flight_id');
        if ($flightId) {
            $flight = $flightRepository->find($flightId);
            if ($flight) {
                $booking->setFlight($flight);
                $booking->setAirlines($flight->getAirline());
                // Pass DateTime objects directly without formatting
                $booking->setDepartureTime($flight->getDepartureTime());
                $booking->setBackTime($flight->getBackTime());
                $booking->setFlightPrice($flight->getPrice());
            }
        }
        
        // Set hotel details
        $hotelId = $request->request->get('hotel_id');
        if ($hotelId) {
            $hotel = $hotelRepository->find($hotelId);
            if ($hotel) {
                $booking->setHotel($hotel);
                $booking->setHotelName($hotel->getName());
                $booking->setHotelLocation($hotel->getLocation());
                $booking->setHotelPricePerNight($hotel->getPricePerNight());
                $booking->setHotelRating($hotel->getRating());
            }
        }
        
        // Set transport details
        $transportId = $request->request->get('transport_id');
        if ($transportId) {
            $transport = $transportRepository->find($transportId);
            if ($transport) {
                $booking->setTransport($transport);
                $booking->setTransportType($transport->getType());
                $booking->setTransportPrice($transport->getPrice());
                $booking->setTransportDescription($transport->getDescription());
            }
        }
        
        // Set conference location details
        $locationId = $request->request->get('location_id');
        if ($locationId) {
            $conferenceLocation = $conferenceLocationRepository->find($locationId);
            if ($conferenceLocation) {
                $booking->setConferenceLocation($conferenceLocation);
                $booking->setConferenceName($conferenceLocation->getName());
                $booking->setConferencePricePerDay($conferenceLocation->getPricePerDay());
            }
        }
        
        // Set event details
        $idEvenement = $request->request->get('id_evenement');
        if ($idEvenement) {
            $evenement = $evenementRepository->find($idEvenement);
            if ($evenement) {
                $booking->setEvenement($evenement);
                $booking->setNameEvement($evenement->getNom());
                $booking->setNumberofInvites($request->request->get('nombre_invite'));
                if ($request->request->get('date_debut')) {
                    $booking->setStartEvement(new \DateTime($request->request->get('date_debut')));
                }
                if ($request->request->get('date_fin')) {
                    $booking->setEndEvement(new \DateTime($request->request->get('date_fin')));
                }
            }
        }
        
        // Set user - FIXED: Handle different User entity methods
        $userId = $request->request->get('userid');
        if ($userId) {
            $user = $userRepository->find($userId);
            if ($user) {
                $booking->setUser($user);
                // Try common user identifier methods
                if (method_exists($user, 'getEmail')) {
                    $booking->setUserName($user->getEmail());
                } elseif (method_exists($user, 'getFullName')) {
                    $booking->setUserName($user->getFullName());
                } elseif (method_exists($user, 'getNom')) {
                    $booking->setUserName($user->getNom());
                } else {
                    $booking->setUserName('User #' . $user->getId());
                }
            }
        }
        
        // Calculate and set total price
        $totalPrice = 0;
        if ($booking->getFlightPrice()) $totalPrice += floatval($booking->getFlightPrice());
        if ($booking->getHotelPricePerNight()) $totalPrice += floatval($booking->getHotelPricePerNight());
        if ($booking->getTransportPrice()) $totalPrice += floatval($booking->getTransportPrice());
        if ($booking->getConferencePricePerDay()) $totalPrice += floatval($booking->getConferencePricePerDay());
        $booking->setPriceTotal($totalPrice);
        
        // Persist and flush
        $entityManager->persist($booking);
        $entityManager->flush();
        
        $this->addFlash('success', 'Booking successfully created with ID: ' . $booking->getBookingId());
        
        return $this->redirectToRoute('app_booking_confirmation', [
            'id' => $booking->getBookingId()
        ]);
    }
    
    #[Route('/booking/confirmation/{id}', name: 'app_booking_confirmation')]
    public function confirmation(Booking $booking): Response
    {
        return $this->render('booking/confirmation.html.twig', [
            'booking' => $booking
        ]);
    }
}