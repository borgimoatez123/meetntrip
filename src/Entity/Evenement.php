<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use App\Repository\EvenementRepository;

#[ORM\Entity(repositoryClass: EvenementRepository::class)]
#[ORM\Table(name: 'evenement')]
class Evenement
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $id = null;

    #[ORM\Column(type: 'string', length: 255)]
    private string $nom;

    #[ORM\Column(type: 'string', length: 255)]
    private string $type;

    #[ORM\Column(type: 'integer')]
    private int $nombreInvite;

    #[ORM\Column(type: 'datetime')]
    private \DateTimeInterface $dateDebut;

    #[ORM\Column(type: 'datetime')]
    private \DateTimeInterface $dateFin;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $description = null;

    #[ORM\Column(type: 'string', length: 255)]
    private string $city;

    #[ORM\Column(type: 'decimal', precision: 10, scale: 2)]
    private float $budgetPrevu;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $activities = null;

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $imagePath = null;

    #[ORM\Column(type: 'boolean', options: ['default' => false])]
    private bool $validated = false;

    #[ORM\Column(type: 'string', length: 50)]
    private string $status;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'evenements')]
    #[ORM\JoinColumn(name: 'userid', referencedColumnName: 'id', nullable: true)]
    private ?User $user = null;

    #[ORM\OneToMany(targetEntity: Booking::class, mappedBy: 'evenement')]
    private Collection $bookings;

    #[ORM\OneToMany(targetEntity: Demandesponsoring::class, mappedBy: 'evenement')]
    private Collection $demandesponsorings;

    #[ORM\OneToMany(targetEntity: Employer::class, mappedBy: 'evenement')]
    private Collection $employers;

    #[ORM\OneToMany(targetEntity: Paiement::class, mappedBy: 'evenement')]
    private Collection $paiements;

    public function __construct()
    {
        $this->bookings = new ArrayCollection();
        $this->demandesponsorings = new ArrayCollection();
        $this->employers = new ArrayCollection();
        $this->paiements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): string
    {
        return $this->nom;
    }

    public function setNom(string $nom): self
    {
        $this->nom = $nom;
        return $this;
    }

    public function getType(): string
    {
        return $this->type;
    }

    public function setType(string $type): self
    {
        $this->type = $type;
        return $this;
    }

    public function getNombreInvite(): int
    {
        return $this->nombreInvite;
    }

    public function setNombreInvite(int $nombreInvite): self
    {
        $this->nombreInvite = $nombreInvite;
        return $this;
    }

    public function getDateDebut(): \DateTimeInterface
    {
        return $this->dateDebut;
    }

    public function setDateDebut(\DateTimeInterface $dateDebut): self
    {
        $this->dateDebut = $dateDebut;
        return $this;
    }

    public function getDateFin(): \DateTimeInterface
    {
        return $this->dateFin;
    }

    public function setDateFin(\DateTimeInterface $dateFin): self
    {
        $this->dateFin = $dateFin;
        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;
        return $this;
    }

    public function getCity(): string
    {
        return $this->city;
    }

    public function setCity(string $city): self
    {
        $this->city = $city;
        return $this;
    }

    public function getBudgetPrevu(): float
    {
        return $this->budgetPrevu;
    }

    public function setBudgetPrevu(float $budgetPrevu): self
    {
        $this->budgetPrevu = $budgetPrevu;
        return $this;
    }

    public function getActivities(): ?string
    {
        return $this->activities;
    }

    public function setActivities(?string $activities): self
    {
        $this->activities = $activities;
        return $this;
    }

    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }

    public function setImagePath(?string $imagePath): self
    {
        $this->imagePath = $imagePath;
        return $this;
    }

    public function isValidated(): bool
    {
        return $this->validated;
    }

    public function setValidated(bool $validated): self
    {
        $this->validated = $validated;
        return $this;
    }

    public function getStatus(): string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;
        return $this;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
    {
        $this->user = $user;
        return $this;
    }

    /**
     * @return Collection<int, Booking>
     */
    public function getBookings(): Collection
    {
        return $this->bookings;
    }

    public function addBooking(Booking $booking): self
    {
        if (!$this->bookings->contains($booking)) {
            $this->bookings->add($booking);
            $booking->setEvenement($this);
        }
        return $this;
    }

    public function removeBooking(Booking $booking): self
    {
        if ($this->bookings->removeElement($booking)) {
            // Set the owning side to null (unless already changed)
            if ($booking->getEvenement() === $this) {
                $booking->setEvenement(null);
            }
        }
        return $this;
    }

    /**
     * @return Collection<int, Demandesponsoring>
     */
    public function getDemandesponsorings(): Collection
    {
        return $this->demandesponsorings;
    }

    public function addDemandesponsoring(Demandesponsoring $demandesponsoring): self
    {
        if (!$this->demandesponsorings->contains($demandesponsoring)) {
            $this->demandesponsorings->add($demandesponsoring);
            $demandesponsoring->setEvenement($this);
        }
        return $this;
    }

    public function removeDemandesponsoring(Demandesponsoring $demandesponsoring): self
    {
        if ($this->demandesponsorings->removeElement($demandesponsoring)) {
            // Set the owning side to null (unless already changed)
            if ($demandesponsoring->getEvenement() === $this) {
                $demandesponsoring->setEvenement(null);
            }
        }
        return $this;
    }

    /**
     * @return Collection<int, Employer>
     */
    public function getEmployers(): Collection
    {
        return $this->employers;
    }

    public function addEmployer(Employer $employer): self
    {
        if (!$this->employers->contains($employer)) {
            $this->employers->add($employer);
            $employer->setEvenement($this);
        }
        return $this;
    }

    public function removeEmployer(Employer $employer): self
    {
        if ($this->employers->removeElement($employer)) {
            // Set the owning side to null (unless already changed)
            if ($employer->getEvenement() === $this) {
                $employer->setEvenement(null);
            }
        }
        return $this;
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): self
    {
        if (!$this->paiements->contains($paiement)) {
            $this->paiements->add($paiement);
            $paiement->setEvenement($this);
        }
        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // Set the owning side to null (unless already changed)
            if ($paiement->getEvenement() === $this) {
                $paiement->setEvenement(null);
            }
        }
        return $this;
    }
}