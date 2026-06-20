name: Deploy to Cloud Run

on:
  push:
    branches:
      - main

permissions:
  contents: read
  id-token: write

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Authenticate to GCP
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: ${{ secrets.WIF_PROVIDER }}
          service_account: ${{ secrets.SERVICE_ACCOUNT }}

      - name: Setup GCloud
        uses: google-github-actions/setup-gcloud@v2

      - name: Configure Docker
        run: |
          gcloud auth configure-docker us-central1-docker.pkg.dev --quiet

      - name: Build Image
        run: |
          docker build \
          -t us-central1-docker.pkg.dev/${{ secrets.PROJECT_ID }}/app-repo/demo-app:${{ github.sha }} \
          ./app

      - name: Push Image
        run: |
          docker push \
          us-central1-docker.pkg.dev/${{ secrets.PROJECT_ID }}/app-repo/demo-app:${{ github.sha }}

      - name: Deploy Cloud Run
        run: |
          gcloud run deploy demo-app \
          --image us-central1-docker.pkg.dev/${{ secrets.PROJECT_ID }}/app-repo/demo-app:${{ github.sha }} \
          --region us-central1 \
          --platform managed \
          --allow-unauthenticated
