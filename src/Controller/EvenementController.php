<?php

namespace App\Controller;

use App\Entity\Evenement;
use App\Repository\EvenementRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class EvenementController extends AbstractController
{
    #[Route('/events', name: 'app_events')]
    public function index(EvenementRepository $evenementRepository): Response
    {
        // Fetch all events from the database
        $events = $evenementRepository->findAll();

        return $this->render('evenement/index.html.twig', [
            'events' => $events,
        ]);
    }

    #[Route('/events/select', name: 'app_event_select')]
    public function selectEvent(Request $request, EvenementRepository $evenementRepository): Response
    {
        // Get the selected event ID from the request
        $eventId = $request->query->get('event_id');

        if (!$eventId) {
            $this->addFlash('error', 'No event selected.');
            return $this->redirectToRoute('app_events');
        }

        // Fetch the selected event
        $event = $evenementRepository->find($eventId);

        if (!$event) {
            $this->addFlash('error', 'Event not found.');
            return $this->redirectToRoute('app_events');
        }

        // Redirect to the flights page with additional query parameters
        return $this->redirectToRoute('app_flights', [
            'city' => $event->getCity(),
            'date_debut' => $event->getDateDebut()->format('Y-m-d'), // Format date for URL
            'date_fin' => $event->getDateFin()->format('Y-m-d'),     // Format date for URL
            'nombre_invite' => $event->getNombreInvite(),
            'userid' => $event->getUser()?->getId(), // Use null-safe operator to avoid errors if user is null
            'id_evenement' => $event->getId(),      // Use the correct field name (`id`)
        ]);
    }
}