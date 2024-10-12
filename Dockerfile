name: DOCKER-CD

on:
  push:
    branches: [ "main" ]

jobs:
  ci:
    # Using Environment - prod 환경 사용
    environment: prod
    runs-on: ubuntu-24.04
    env:
      working-directory: .

    # Checkout - 가상 머신에 체크아웃
    steps:
      - name: 체크아웃
        uses: actions/checkout@v3

      # JDK setting - Amazon Corretto JDK 21 설정
      - name: Set up Amazon Corretto JDK 21
        uses: actions/setup-java@v3
        with:
          distribution: 'corretto'
          java-version: '21'

      # Gradle caching - 빌드 시간 향상
      - name: Gradle Caching
        uses: actions/cache@v3
        with:
          path: |
            ~/.gradle/caches
            ~/.gradle/wrapper
          key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*', '**/gradle-wrapper.properties') }}
          restore-keys: |
            ${{ runner.os }}-gradle-

      # create .yml - yml 파일 생성
      - name: application.yml 생성
        run: |
          mkdir -p ./src/main/resources && cd $_
          touch ./application.yml
          echo "${{ secrets.YML }}" > ./application.yml
          cat ./application.yml
        working-directory: ${{ env.working-directory }}

      - name: application-prod.yml 생성
        run: |
          cd ./src/main/resources
          touch ./application-staging.yml
          echo "${{ secrets.YML_PROD }}" > ./application-prod.yml
        working-directory: ${{ env.working-directory }}

      # Gradle build - 테스트 없이 gradle 빌드
      - name: 빌드
        run: |
          chmod +x gradlew
          ./gradlew build -x test
        working-directory: ${{ env.working-directory }}
        shell: bash

      - name: docker 로그인
        uses: docker/setup-buildx-action@v2.9.1

      - name: login docker hub
        uses: docker/login-action@v2.2.0
        with:
          username: ${{ secrets.DOCKER_LOGIN_USERNAME }}
          password: ${{ secrets.DOCKER_LOGIN_ACCESSTOKEN }}

      - name: docker image 빌드 및 푸시
        run: |
          docker build -f Dockerfile-staging --platform linux/amd64 -t jsoonworld/foodiepass .
          docker push jsoonworld/foodiepass
        working-directory: ${{ env.working-directory }}

  cd:
    needs: ci
    runs-on: ubuntu-24.04

    steps:
      - name: docker 컨테이너 실행
        uses: appleboy/ssh-action@master
        with:
          host: ${{ secrets.SERVER_IP }}
          username: ${{ secrets.SERVER_USER }}
          key: ${{ secrets.SERVER_KEY }}
          script: |
            cd ~
            ./deploy.sh
