<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Repository\EvenementRepository;

#[ORM\Entity(repositoryClass: EvenementRepository::class)]
class Evenement
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $id = null;

    #[ORM\Column(type: 'string', length: 255)]
    private string $nom;

    #[ORM\Column(type: 'string', length: 100)]
    private string $type;

    #[ORM\Column(name: 'nombreInvite', type: 'integer')]
    private int $nombreInvite;

    #[ORM\Column(name: 'dateDebut', type: 'datetime')]
    private \DateTimeInterface $dateDebut;

    #[ORM\Column(name: 'dateFin', type: 'datetime')]
    private \DateTimeInterface $dateFin;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $description = null;

    #[ORM\Column(name: 'lieuEvenement', type: 'string', length: 255, nullable: true)]
    private ?string $lieuEvenement = null;

    #[ORM\Column(name: 'budgetPrevu', type: 'float', nullable: true)]
    private ?float $budgetPrevu = null;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $activities = null;

    #[ORM\Column(name: 'imagePath', type: 'string', length: 255, nullable: true)]
    private ?string $imagePath = null;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private ?string $validated = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(name: 'user_id', referencedColumnName: 'id')]
    private ?User $user = null;

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

    public function getLieuEvenement(): ?string
    {
        return $this->lieuEvenement;
    }

    public function setLieuEvenement(?string $lieuEvenement): self
    {
        $this->lieuEvenement = $lieuEvenement;
        return $this;
    }

    public function getBudgetPrevu(): ?float
    {
        return $this->budgetPrevu;
    }

    public function setBudgetPrevu(?float $budgetPrevu): self
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

    public function getValidated(): ?string
    {
        return $this->validated;
    }

    public function setValidated(?string $validated): self
    {
        $this->validated = $validated;
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
}