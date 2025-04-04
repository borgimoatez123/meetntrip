<?php

namespace App\Controller;

use App\Entity\Hotel;
use App\Repository\HotelRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HotelController extends AbstractController
{
    #[Route('/hotels', name: 'app_hotels')]
    public function index(HotelRepository $hotelRepository, Request $request): Response
    {
        // Get query parameters from the previous page (flights page)
        $flightId = $request->query->get('flight_id');
        $departureTime = $request->query->get('departure_time');
        $backTime = $request->query->get('back_time');
        $flightPrice = $request->query->get('flight_price');
        $userid = $request->query->get('userid');
        $idEvenement = $request->query->get('id_evenement');
        $dateDebut = $request->query->get('date_debut');
        $dateFin = $request->query->get('date_fin');
        $city = $request->query->get('city');
        $nombreInvite = $request->query->get('nombre_invite');

        // Fetch hotels filtered by city (if provided)
        $hotels = $city
            ? $hotelRepository->findBy(['city' => $city])
            : $hotelRepository->findAll();

        return $this->render('hotel/index.html.twig', [
            'hotels' => $hotels,
            'flight_id' => $flightId,
            'departure_time' => $departureTime,
            'back_time' => $backTime,
            'flight_price' => $flightPrice,
            'userid' => $userid,
            'id_evenement' => $idEvenement,
            'date_debut' => $dateDebut,
            'date_fin' => $dateFin,
            'city' => $city,
            'nombre_invite' => $nombreInvite,
        ]);
    }

    #[Route('/hotels/select', name: 'app_hotel_select')]
    public function selectHotel(Request $request, HotelRepository $hotelRepository): Response
    {
        // Get the selected hotel ID from the request
        $hotelId = $request->query->get('hotel_id');

        if (!$hotelId) {
            $this->addFlash('error', 'No hotel selected.');
            return $this->redirectToRoute('app_hotels');
        }

        // Fetch the selected hotel
        $hotel = $hotelRepository->find($hotelId);

        if (!$hotel) {
            $this->addFlash('error', 'Hotel not found.');
            return $this->redirectToRoute('app_hotels');
        }

        // Get other query parameters from the previous page (flights page)
        $flightId = $request->query->get('flight_id');
        $departureTime = $request->query->get('departure_time');
        $backTime = $request->query->get('back_time');
        $flightPrice = $request->query->get('flight_price');
        $userid = $request->query->get('userid');
        $idEvenement = $request->query->get('id_evenement');
        $dateDebut = $request->query->get('date_debut');
        $dateFin = $request->query->get('date_fin');
        $city = $request->query->get('city');
        $nombreInvite = $request->query->get('nombre_invite');

        // Redirect to the conference location page with all required query parameters
        return $this->redirectToRoute('app_conference_locations', [
            'flight_id' => $flightId,
            'departure_time' => $departureTime,
            'back_time' => $backTime,
            'flight_price' => $flightPrice,
            'hotel_id' => $hotel->getHotelId(),
            'hotel_name' => $hotel->getName(),
            'hotel_price_per_night' => $hotel->getPricePerNight(),
            'userid' => $userid,
            'id_evenement' => $idEvenement,
            'date_debut' => $dateDebut,
            'date_fin' => $dateFin,
            'city' => $city,
            'nombre_invite' => $nombreInvite,
        ]);
    }
}