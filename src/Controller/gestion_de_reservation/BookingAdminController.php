<?php

namespace App\Controller\gestion_de_reservation;

use App\Entity\Booking;
use App\Repository\BookingRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class BookingAdminController extends AbstractController
{
    #[Route('/admin/bookings', name: 'admin_bookings_list')]
    public function list(BookingRepository $bookingRepository): Response
    {
        // Only show bookings that haven't been processed yet
        $bookings = $bookingRepository->findBy(['status' => null]);
        
        return $this->render('/gestion_de_reservation/booking_admin/list.html.twig', [
            'bookings' => $bookings,
        ]);
    }

    #[Route('/admin/bookings/{id}', name: 'admin_booking_show')]
    public function show(Booking $booking): Response
    {
        return $this->render('/gestion_de_reservation/booking_admin/show.html.twig', [
            'booking' => $booking,
        ]);
    }

    #[Route('/admin/bookings/{id}/validate', name: 'admin_booking_validate', methods: ['POST'])]
    public function validate(
        Booking $booking, 
        Request $request, 
        EntityManagerInterface $em,
        MailerInterface $mailer,
        LoggerInterface $logger
    ): Response {
        $action = $request->request->get('action');
        
        if ($action === 'confirm') {
            $booking->setStatus('confirmed');
            $emailSent = $this->sendConfirmationEmail($mailer, $booking, $logger);
            $this->addFlash('success', $emailSent 
                ? 'Booking confirmed and email sent' 
                : 'Booking confirmed (email failed)');
        } elseif ($action === 'reject') {
            $booking->setStatus('not_confirmed');
            $emailSent = $this->sendRejectionEmail($mailer, $booking, $logger);
            $this->addFlash('warning', $emailSent 
                ? 'Booking rejected and email sent' 
                : 'Booking rejected (email failed)');
        }
        
        $em->flush();
        return $this->redirectToRoute('admin_booking_show', ['id' => $booking->getBookingId()]);
    }
        
}