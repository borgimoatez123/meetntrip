<?php

namespace App\Controller\gestion_de_reservation;

use App\Entity\Flight;
use App\Repository\FlightRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class FlightController extends AbstractController
{
    #[Route('/flights', name: 'app_flights')]
    public function index(FlightRepository $flightRepository, Request $request): Response
    {
        // Get query parameters from the previous page (events page)
        $city = $request->query->get('lieuEvenement');
        $dateDebut = $request->query->get('date_debut');
        $dateFin = $request->query->get('date_fin');
        $nombreInvite = $request->query->get('nombre_invite');
        $userid = $request->query->get('userid');
        $idEvenement = $request->query->get('id_evenement'); // Get the event ID

        // Fetch flights filtered by city (if provided)
        $flights = $city
            ? $flightRepository->findBy(['destination' => $city])
            : $flightRepository->findAll();

        return $this->render('/gestion_de_reservation/flight/index.html.twig', [
            'flights' => $flights,
            'city' => $city,
            'date_debut' => $dateDebut,
            'date_fin' => $dateFin,
            'nombre_invite' => $nombreInvite,
            'userid' => $userid,
            'id_evenement' => $idEvenement, // Pass the event ID to the template
        ]);
    }

    #[Route('/flights/select', name: 'app_flight_select')]
    public function selectFlight(Request $request, FlightRepository $flightRepository): Response
    {
        // Get the selected flight ID from the request
        $flightId = $request->query->get('flight_id');

        if (!$flightId) {
            $this->addFlash('error', 'No flight selected.');
            return $this->redirectToRoute('app_flights');
        }

        // Fetch the selected flight
        $flight = $flightRepository->find($flightId);

        if (!$flight) {
            $this->addFlash('error', 'Flight not found.');
            return $this->redirectToRoute('app_flights');
        }

        // Get other query parameters from the previous page (events page)
        $city = $request->query->get('city');
        $dateDebut = $request->query->get('date_debut');
        $dateFin = $request->query->get('date_fin');
        $nombreInvite = $request->query->get('nombre_invite');
        $userid = $request->query->get('userid');
        $idEvenement = $request->query->get('id_evenement'); // Get the event ID

        // Redirect to the hotels page with all required query parameters
        return $this->redirectToRoute('app_hotels', [
            'flight_id' => $flight->getFlightId(),
            'departure_time' => $flight->getDepartureTime()->format('H:i'),
            'back_time' => $flight->getBackTime()->format('H:i'),
            'flight_price' => $flight->getPrice(),
            'userid' => $userid,
            'id_evenement' => $idEvenement, // Pass the event ID
            'date_debut' => $dateDebut,
            'date_fin' => $dateFin,
            'city' => $city,
            'nombre_invite' => $nombreInvite,
        ]);
    }
}