<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;

use App\Repository\EmployerRepository;

#[ORM\Entity(repositoryClass: EmployerRepository::class)]
#[ORM\Table(name: 'employer')]
class Employer
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
    private ?string $fullname = null;

    public function getFullname(): ?string
    {
        return $this->fullname;
    }

    public function setFullname(string $fullname): self
    {
        $this->fullname = $fullname;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $phone = null;

    public function getPhone(): ?string
    {
        return $this->phone;
    }

    public function setPhone(?string $phone): self
    {
        $this->phone = $phone;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $job = null;

    public function getJob(): ?string
    {
        return $this->job;
    }

    public function setJob(?string $job): self
    {
        $this->job = $job;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $cin_image = null;

    public function getCin_image(): ?string
    {
        return $this->cin_image;
    }

    public function setCin_image(?string $cin_image): self
    {
        $this->cin_image = $cin_image;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $passport_image = null;

    public function getPassport_image(): ?string
    {
        return $this->passport_image;
    }

    public function setPassport_image(?string $passport_image): self
    {
        $this->passport_image = $passport_image;
        return $this;
    }

    #[ORM\Column(type: 'string', nullable: true)]
    private ?string $nationality = null;

    public function getNationality(): ?string
    {
        return $this->nationality;
    }

    public function setNationality(?string $nationality): self
    {
        $this->nationality = $nationality;
        return $this;
    }

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $age = null;

    public function getAge(): ?int
    {
        return $this->age;
    }

    public function setAge(?int $age): self
    {
        $this->age = $age;
        return $this;
    }

    #[ORM\ManyToOne(targetEntity: Evenement::class, inversedBy: 'employers')]
    #[ORM\JoinColumn(name: 'id_evement', referencedColumnName: 'id')]
    private ?Evenement $evenement = null;

    public function getEvenement(): ?Evenement
    {
        return $this->evenement;
    }

    public function setEvenement(?Evenement $evenement): self
    {
        $this->evenement = $evenement;
        return $this;
    }

    public function getCinImage(): ?string
    {
        return $this->cin_image;
    }

    public function setCinImage(?string $cin_image): static
    {
        $this->cin_image = $cin_image;

        return $this;
    }

    public function getPassportImage(): ?string
    {
        return $this->passport_image;
    }

    public function setPassportImage(?string $passport_image): static
    {
        $this->passport_image = $passport_image;

        return $this;
    }

}
