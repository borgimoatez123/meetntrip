<?php
namespace App\Service;

use App\Entity\Booking;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;

class BookingEmailService
{
    private $mailer;

    public function __construct(MailerInterface $mailer)
    {
        $this->mailer = $mailer;
    }

    public function sendConfirmationEmail(Booking $booking)
    {
        $userEmail = $booking->getUser()->getEmail();
        $userName = $booking->getUserName() ?? $booking->getUser()->getNom();

        $email = (new TemplatedEmail())
            ->from('admin@yourdomain.com')
            ->to($userEmail)
            ->subject('Your Booking Has Been Confirmed!')
            ->htmlTemplate('emails/booking_confirmed.html.twig')
            ->context([
                'booking' => $booking,
                'userName' => $userName,
            ]);

        $this->mailer->send($email);
    }

    public function sendRejectionEmail(Booking $booking)
    {
        $userEmail = $booking->getUser()->getEmail();
        $userName = $booking->getUserName() ?? $booking->getUser()->getNom();

        $email = (new TemplatedEmail())
            ->from('admin@yourdomain.com')
            ->to($userEmail)
            ->subject('Your Booking Has Been Rejected')
            ->htmlTemplate('emails/booking_rejected.html.twig')
            ->context([
                'booking' => $booking,
                'userName' => $userName,
            ]);

        $this->mailer->send($email);
    }
}