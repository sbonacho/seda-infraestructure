# Soprasteria Event Driven Architecture (SEDA) Infrastructure

# Install

Install demo of architecture

./seda.sh install [install directory: default: ../demo]

## Start

./seda.sh start

## Stop

./seda.sh stop

## Watch Logs

./seda.sh watch

# Description

This will clone all microservices for architecture

## ch-create-client

Command Handler for the Create Client functionality

## domain-clients

Clients Domain Service

## domain-portfolios

Portfolio Domain Service

## saga-create-client

Saga that orchestrate all create client functionality

## query-clients

Query clients with portfolio aggregated
