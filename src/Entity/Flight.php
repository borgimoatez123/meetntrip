<?php

namespace App\Entity;

use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;

use App\Repository\FlightRepository;

#[ORM\Entity(repositoryClass: FlightRepository::class)]
#[ORM\Table(name: 'flights')]
class Flight
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $flight_id = null;

    public function getFlightId(): ?int
    {
        return $this->flight_id;
    }

    public function setFlightId(int $flight_id): self
    {
        $this->flight_id = $flight_id;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: false)]
    private ?string $destination = null;

    public function getDestination(): ?string
    {
        return $this->destination;
    }

    public function setDestination(string $destination): self
    {
        $this->destination = $destination;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $airline = null;

    public function getAirline(): ?string
    {
        return $this->airline;
    }

    public function setAirline(?string $airline): self
    {
        $this->airline = $airline;
        return $this;
    }

    #[ORM\Column(type: 'time', nullable: true)]
    private ?\DateTimeInterface $departure_time = null;

    public function getDepartureTime(): ?\DateTimeInterface
    {
        return $this->departure_time;
    }

    public function setDepartureTime(?\DateTimeInterface $departure_time): static
    {
        $this->departure_time = $departure_time;
        return $this;
    }

    #[ORM\Column(type: 'time', nullable: true)]
    private ?\DateTimeInterface $back_time = null;

    public function getBackTime(): ?\DateTimeInterface
    {
        return $this->back_time;
    }

    public function setBackTime(?\DateTimeInterface $back_time): static
    {
        $this->back_time = $back_time;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $type = null;

    public function getType(): ?string
    {
        return $this->type;
    }

    public function setType(?string $type): self
    {
        $this->type = $type;
        return $this;
    }

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $aeroports = null;

    public function getAeroports(): ?string
    {
        return $this->aeroports;
    }

    public function setAeroports(?string $aeroports): self
    {
        $this->aeroports = $aeroports;
        return $this;
    }

    #[ORM\Column(type: 'decimal', nullable: true)]
    private ?float $price = null;

    public function getPrice(): ?float
    {
        return $this->price;
    }

    public function setPrice(?float $price): self
    {
        $this->price = $price;
        return $this;
    }

    #[ORM\OneToMany(targetEntity: Booking::class, mappedBy: 'flight')]
    private Collection $bookings;

    public function __construct()
    {
        $this->bookings = new ArrayCollection();
    }

    /**
     * @return Collection<int, Booking>
     */
    public function getBookings(): Collection
    {
        if (!$this->bookings instanceof Collection) {
            $this->bookings = new ArrayCollection();
        }
        return $this->bookings;
    }

    public function addBooking(Booking $booking): self
    {
        if (!$this->getBookings()->contains($booking)) {
            $this->getBookings()->add($booking);
        }
        return $this;
    }

    public function removeBooking(Booking $booking): self
    {
        $this->getBookings()->removeElement($booking);
        return $this;
    }
}