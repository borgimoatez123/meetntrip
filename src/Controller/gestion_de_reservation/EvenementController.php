<?php

namespace App\Controller\gestion_de_reservation;

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
        $events = $evenementRepository->findAll();

        return $this->render('gestion_de_reservation/evenement/index.html.twig', [
            'events' => $events,
        ]);
    }

    #[Route('/events/select', name: 'app_event_select')]
    public function selectEvent(Request $request, EvenementRepository $evenementRepository): Response
    {
        $eventId = $request->query->get('event_id');

        if (!$eventId) {
            $this->addFlash('error', 'No event selected.');
            return $this->redirectToRoute('app_events');
        }

        $event = $evenementRepository->find($eventId);

        if (!$event) {
            $this->addFlash('error', 'Event not found.');
            return $this->redirectToRoute('app_events');
        }

        return $this->redirectToRoute('app_flights', [
            'lieuEvenement' => $event->getLieuEvenement(),
            'date_debut' => $event->getDateDebut()->format('Y-m-d'),
            'date_fin' => $event->getDateFin()->format('Y-m-d'),
            'nombre_invite' => $event->getNombreInvite(),
            'userid' => $event->getUser()?->getId(),
            'id_evenement' => $event->getId(),
        ]);
    }
}