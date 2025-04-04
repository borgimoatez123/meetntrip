<?php

namespace App\Repository;

use App\Entity\Flight;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class FlightRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Flight::class);
    }

    // Method to fetch all flights
    public function findAllFlights(): array
    {
        return $this->createQueryBuilder('f')
            ->orderBy('f.departure_time', 'ASC') // Optional: Order by departure time
            ->getQuery()
            ->getResult();
    }
}