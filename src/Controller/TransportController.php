<?php

namespace App\Controller;

use App\Entity\Transport;
use App\Repository\TransportRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class TransportController extends AbstractController
{
    #[Route('/transport', name: 'app_transport')]
    public function index(TransportRepository $transportRepository, Request $request): Response
    {
        $transports = $transportRepository->findAll();

        return $this->render('transport/index.html.twig', [
            'transports' => $transports,
            'hotel_id' => $request->query->get('hotel_id'),
            'hotel_price' => $request->query->get('hotel_price'),
            'flight_id' => $request->query->get('flight_id'),
            'flight_price' => $request->query->get('flight_price'),
            'location_id' => $request->query->get('location_id'),
            'userid' => $request->query->get('userid'),
            'id_evenement' => $request->query->get('id_evenement'),
            'date_debut' => $request->query->get('date_debut'),
            'date_fin' => $request->query->get('date_fin'),
            'nombre_invite' => $request->query->get('nombre_invite')
        ]);
    }

    #[Route('/transport/select/{transport_id}', name: 'app_transport_select')]
    public function select(
        Request $request,
        TransportRepository $transportRepository,
        EntityManagerInterface $entityManager,
        int $transport_id
    ): Response {
        $transport = $transportRepository->find($transport_id);
        
        if (!$transport) {
            throw $this->createNotFoundException('Transport not found');
        }

        return $this->redirectToRoute('app_booking', [
            'transport_id' => $transport->getTransportId(),
            'transport_price' => $transport->getPrice(),
            'transport_type' => $transport->getType(),
            'transport_description' => $transport->getDescription(),
            'hotel_id' => $request->query->get('hotel_id'),
            'hotel_price' => $request->query->get('hotel_price'),
            'flight_id' => $request->query->get('flight_id'),
            'flight_price' => $request->query->get('flight_price'),
            'location_id' => $request->query->get('location_id'),
            'userid' => $request->query->get('userid'),
            'id_evenement' => $request->query->get('id_evenement'),
            'date_debut' => $request->query->get('date_debut'),
            'date_fin' => $request->query->get('date_fin'),
            'nombre_invite' => $request->query->get('nombre_invite')
        ]);
    }
}