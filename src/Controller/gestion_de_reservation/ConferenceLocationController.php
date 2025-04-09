<?php

namespace App\Controller\gestion_de_reservation;

use App\Entity\ConferenceLocation;
use App\Repository\ConferenceLocationRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ConferenceLocationController extends AbstractController
{
    #[Route('/conference-locations', name: 'app_conference_locations')]
    public function index(ConferenceLocationRepository $repository, Request $request): Response
    {
        // Retrieve parameters from previous step (hotel selection)
        $hotelId = $request->query->get('hotel_id');
        $hotelPrice = $request->query->get('hotel_price');
        $flightId = $request->query->get('flight_id');
        $flightPrice = $request->query->get('flight_price');
        $userid = $request->query->get('userid');
        $idEvenement = $request->query->get('id_evenement');
        $dateDebut = $request->query->get('date_debut');
        $dateFin = $request->query->get('date_fin');
        $city = $request->query->get('city');
        $nombreInvite = $request->query->get('nombre_invite');

        // Fetch conference locations filtered by city
        $locations = $city
            ? $repository->findBy(['city' => $city])
            : $repository->findAll();

        return $this->render('/gestion_de_reservation/conference_location/index.html.twig', [
            'locations' => $locations,
            'hotel_id' => $hotelId,
            'hotel_price' => $hotelPrice,
            'flight_id' => $flightId,
            'flight_price' => $flightPrice,
            'userid' => $userid,
            'id_evenement' => $idEvenement,
            'date_debut' => $dateDebut,
            'date_fin' => $dateFin,
            'city' => $city,
            'nombre_invite' => $nombreInvite,
        ]);
    }

    #[Route('/conference-locations/select', name: 'app_conference_location_select')]
    public function selectLocation(Request $request, ConferenceLocationRepository $repository): Response
    {
        // Get selected conference location ID
        $locationId = $request->query->get('location_id');
        if (!$locationId) {
            $this->addFlash('error', 'No conference location selected.');
            return $this->redirectToRoute('app_conference_locations');
        }

        // Fetch selected conference location
        $location = $repository->find($locationId);
        if (!$location) {
            $this->addFlash('error', 'Invalid conference location.');
            return $this->redirectToRoute('app_conference_locations');
        }

        // Redirect to transport selection with all parameters
        return $this->redirectToRoute('app_transport', [
            'location_id' => $location->getLocationId(),
            'location_name' => $location->getName(),
            'city' => $location->getCity(),
            'hotel_id' => $request->query->get('hotel_id'),
            'hotel_price' => $request->query->get('hotel_price'),
            'flight_id' => $request->query->get('flight_id'),
            'flight_price' => $request->query->get('flight_price'),
            'userid' => $request->query->get('userid'),
            'id_evenement' => $request->query->get('id_evenement'),
            'date_debut' => $request->query->get('date_debut'),
            'date_fin' => $request->query->get('date_fin'),
            'nombre_invite' => $request->query->get('nombre_invite'),
        ]);
    }
}
