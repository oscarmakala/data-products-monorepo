#!/bin/bash
# import-templates.sh - Create a new data product from templates

DOMAIN=$1
PRODUCT=$2

if [ -z "$DOMAIN" ] || [ -z "$PRODUCT" ]; then
  echo "Usage: ./import-template.sh <domain> <product>"
  echo "Example: ./import-template.sh finance revenue-analysis"
  exit 1
fi

# Create domain directory if it doesn't exist
mkdir -p domains/$DOMAIN

# Copy template to domain/product location
cp -r templates/data-product-template domains/$DOMAIN/$PRODUCT

# Replace templates placeholders in metadata.yaml
sed -i "s/domain: domain-name/domain: $DOMAIN/" domains/$DOMAIN/$PRODUCT/metadata.yaml
sed -i "s/name: example-data-product/name: $PRODUCT/" domains/$DOMAIN/$PRODUCT/metadata.yaml

# Update Kubernetes deployment name
sed -i "s/name: data-product/name: $PRODUCT/" domains/$DOMAIN/$PRODUCT/k8s/deployment.yaml

echo "Created new data product: domains/$DOMAIN/$PRODUCT"
echo "You can now edit this data product in Replit by focusing on this directory"