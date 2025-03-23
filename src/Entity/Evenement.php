<?php

namespace App\Entity;

use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;

use App\Repository\EvenementRepository;

#[ORM\Entity(repositoryClass: EvenementRepository::class)]
#[ORM\Table(name: 'evenement')]
class Evenement
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $id = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function setId(int $id): self
    {
        $this->id = $id;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: false)]
    private ?string $nom = null;

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): self
    {
        $this->nom = $nom;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: false)]
    private ?string $type = null;

    public function getType(): ?string
    {
        return $this->type;
    }

    public function setType(string $type): self
    {
        $this->type = $type;
        return $this;
    }

    #[ORM\Column(type: 'integer', nullable: false)]
    private ?int $nombreInvite = null;

    public function getNombreInvite(): ?int
    {
        return $this->nombreInvite;
    }

    public function setNombreInvite(int $nombreInvite): self
    {
        $this->nombreInvite = $nombreInvite;
        return $this;
    }

    #[ORM\Column(type: 'datetime', nullable: false)]
    private ?\DateTimeInterface $dateDebut = null;

    public function getDateDebut(): ?\DateTimeInterface
    {
        return $this->dateDebut;
    }

    public function setDateDebut(\DateTimeInterface $dateDebut): self
    {
        $this->dateDebut = $dateDebut;
        return $this;
    }

    #[ORM\Column(type: 'datetime', nullable: false)]
    private ?\DateTimeInterface $dateFin = null;

    public function getDateFin(): ?\DateTimeInterface
    {
        return $this->dateFin;
    }

    public function setDateFin(\DateTimeInterface $dateFin): self
    {
        $this->dateFin = $dateFin;
        return $this;
    }

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $description = null;

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): self
    {
        $this->description = $description;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: false)]
    private ?string $city = null;

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(string $city): self
    {
        $this->city = $city;
        return $this;
    }

    #[ORM\Column(type: 'decimal', nullable: false)]
    private ?float $budgetPrevu = null;

    public function getBudgetPrevu(): ?float
    {
        return $this->budgetPrevu;
    }

    public function setBudgetPrevu(float $budgetPrevu): self
    {
        $this->budgetPrevu = $budgetPrevu;
        return $this;
    }

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $activities = null;

    public function getActivities(): ?string
    {
        return $this->activities;
    }

    public function setActivities(?string $activities): self
    {
        $this->activities = $activities;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $imagePath = null;

    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }

    public function setImagePath(?string $imagePath): self
    {
        $this->imagePath = $imagePath;
        return $this;
    }

    #[ORM\Column(type: 'boolean', nullable: false)]
    private ?bool $validated = null;

    public function isValidated(): ?bool
    {
        return $this->validated;
    }

    public function setValidated(bool $validated): self
    {
        $this->validated = $validated;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: false)]
    private ?string $status = null;

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;
        return $this;
    }

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: 'evenements')]
    #[ORM\JoinColumn(name: 'userid', referencedColumnName: 'id')]
    private ?User $user = null;

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
    {
        $this->user = $user;
        return $this;
    }

    #[ORM\OneToMany(targetEntity: Booking::class, mappedBy: 'evenement')]
    private Collection $bookings;

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

    #[ORM\OneToMany(targetEntity: Demandesponsoring::class, mappedBy: 'evenement')]
    private Collection $demandesponsorings;

    /**
     * @return Collection<int, Demandesponsoring>
     */
    public function getDemandesponsorings(): Collection
    {
        if (!$this->demandesponsorings instanceof Collection) {
            $this->demandesponsorings = new ArrayCollection();
        }
        return $this->demandesponsorings;
    }

    public function addDemandesponsoring(Demandesponsoring $demandesponsoring): self
    {
        if (!$this->getDemandesponsorings()->contains($demandesponsoring)) {
            $this->getDemandesponsorings()->add($demandesponsoring);
        }
        return $this;
    }

    public function removeDemandesponsoring(Demandesponsoring $demandesponsoring): self
    {
        $this->getDemandesponsorings()->removeElement($demandesponsoring);
        return $this;
    }

    #[ORM\OneToMany(targetEntity: Employer::class, mappedBy: 'evenement')]
    private Collection $employers;

    /**
     * @return Collection<int, Employer>
     */
    public function getEmployers(): Collection
    {
        if (!$this->employers instanceof Collection) {
            $this->employers = new ArrayCollection();
        }
        return $this->employers;
    }

    public function addEmployer(Employer $employer): self
    {
        if (!$this->getEmployers()->contains($employer)) {
            $this->getEmployers()->add($employer);
        }
        return $this;
    }

    public function removeEmployer(Employer $employer): self
    {
        $this->getEmployers()->removeElement($employer);
        return $this;
    }

    #[ORM\OneToMany(targetEntity: Paiement::class, mappedBy: 'evenement')]
    private Collection $paiements;

    public function __construct()
    {
        $this->bookings = new ArrayCollection();
        $this->demandesponsorings = new ArrayCollection();
        $this->employers = new ArrayCollection();
        $this->paiements = new ArrayCollection();
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        if (!$this->paiements instanceof Collection) {
            $this->paiements = new ArrayCollection();
        }
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): self
    {
        if (!$this->getPaiements()->contains($paiement)) {
            $this->getPaiements()->add($paiement);
        }
        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        $this->getPaiements()->removeElement($paiement);
        return $this;
    }

}
