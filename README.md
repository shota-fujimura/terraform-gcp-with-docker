# Terraform プロジェクト - README

このプロジェクトは、Terraformを使用してインフラストラクチャを管理するためのリポジトリです。Google Cloud Platform (GCP) でのリソースプロビジョニングを自動化し、環境ごとに構成を管理します。

## 目次
- [ディレクトリ構成](#ディレクトリ構成)
- [環境の設定と使用方法](#環境の設定と使用方法)
- [主要なファイルとディレクトリ](#主要なファイルとディレクトリ)
- [Makefileの使用方法](#makefileの使用方法)
- [Docker構成](#docker構成)
- [エイリアスの使用方法](#エイリアスの使用方法)

## ディレクトリ構成
```
.
├── Makefile                   # Docker操作やGCP認証などのコマンドをまとめたファイル
├── README.md                  # プロジェクトの概要と使用方法を記載したファイル
├── cloud-sql-proxy            # Cloud SQLに接続するためのプロキシ設定（詳細はプロジェクト固有）(gitignore)
├── compose.yml                # Docker Composeの設定ファイル
├── gcloud-config              # Google Cloud SDKの認証情報と設定を管理
│   └── gcloud
│       ├── access_tokens.db   # GCPアクセス用トークンのデータベース
│       ├── active_config      # 現在のアクティブなgcloud構成
│       ├── application_default_credentials.json # GCPのデフォルト認証情報(gitignore)
│       ├── configurations     # gcloud構成ファイルを保存
│       │   └── config_default # デフォルトのgcloud設定
│       ├── default_configs.db # gcloudのデフォルト設定データベース
│       ├── gce                # Google Compute Engine関連の設定
│       └── logs               # gcloudコマンドの操作ログ (gitignore)
│
└── terraform                  # Terraformを使用したインフラ構成管理
    ├── Dockerfile             # Terraformを実行するDockerイメージの設定
    ├── home
    │   └── entrypoint.sh      # Dockerコンテナ起動時のエントリーポイントスクリプト
    ├── root                   # Dockerコンテナ内のルート設定ファイル
    │   └── .bashrc            # Dockerコンテナ起動時のbashコマンドのエイリアス
    └── src                    # Terraform構成ファイルを格納
        ├── environment        # 環境ごとのTerraform設定
        │   ├── dev            # 開発環境の設定ファイル
        │   │   ├── backend.tf                 # tfsateをGCPのcloud-storageに保管するための設定を記述
        │   │   ├── dev.tfvars                 # 開発環境用の変数定義(gitignore)
        │   │   ├── errored.tfstate            # エラー発生時のTerraform状態ファイル
        │   │   ├── locals.tf                  # ローカル変数定義
        │   │   ├── main.tf                    # 開発環境の主要Terraform構成
        │   │   ├── outputs.tf                 # 出力変数定義
        │   │   ├── terraform.tfstate          # 現在のTerraform状態
        │   │   ├── terraform.tfstate.backup   # Terraform状態のバックアップ
        │   │   └── variables.tf               # 変数定義ファイル
        │   ├── prod           # 本番環境の設定ファイル
        │   │   └── prod.tfvars                 # 本番環境用の変数定義
        │   └── staging        # ステージング環境の設定ファイル
        │       └── staging.tfvars              # ステージング環境用の変数定義
        └── shared             # 共有モジュールと設定
            └── modules        # 共有モジュールディレクトリ
                ├── app-engine                   # App EngineリソースのTerraform設定
                │   ├── main.tf
                │   ├── outputs.tf
                │   └── variables.tf
                ├── artifact-registry            # Artifact Registryリソースの設定
                ├── cloud-run-v2                 # Cloud Runリソースの設定
                ├── cloud-sql                    # Cloud SQLリソースの設定
                ├── cloud-storage                # Cloud Storageリソースの設定
                ├── cloud-storage-tfstate        # Terraform状態管理用Cloud Storage設定
                ├── service-account              # Service Accountリソースの設定
                ├── service-networking           # VPCネットワーキングの設定
                ├── vpc                          # VPCリソースの設定
                └── (add other modules)
```

## 環境の設定と使用方法

### 初期セットアップ

1. Google Cloud SDKで認証を行います。（Google Cloud上のプロジェクトにアクセスする権限が必要です。管理者に連絡してください。）
    ```bash
    make auth-{environment_name}
    ```
    （例)
    ```bash
    make auth-dev
    ```

2. `Makefile`を使用してDockerコンテナを起動し、TerraformのBashシェルに入ります。
    ```bash
    make bash
    ```
3. 各環境（dev、staging、prod）でTerraformの初期化、計画、適用を行います。

## 主要なファイルとディレクトリ

- **Makefile**: Dockerコンテナの起動、停止、認証などを管理するためのコマンドを含むファイル。
- **compose.yml**: Docker Composeの設定ファイル。TerraformとGCloud SDK用のコンテナを定義。
- **cloud-sql-proxy**: Cloud SQLに接続するためのプロキシ設定（詳細はプロジェクト固有の設定に依存）。
- **gcloud-config**: Google Cloud SDKの認証情報や設定ファイルを保持するディレクトリ。（gitignoreされている認証情報ファイルやlogsフォルダは、`make auth-dev`　を実行後に自動生成されます）
  - `access_tokens.db`, `active_config`, `application_default_credentials.json`: Google Cloudへのアクセスに必要な設定ファイル。
  - `logs`: gcloudコマンドの操作ログ。

### terraform ディレクトリ

- **Dockerfile**: Terraformを実行するためのDockerイメージの設定ファイル。
- **home/entrypoint.sh**: Dockerコンテナ起動時に実行されるエントリポイントスクリプト。
- **root**: Dockerコンテナ内のルート設定ファイル。bashコマンドのエイリアスを定義したファイルを含む。
- **src/environment**: 環境ごとのTerraform設定を管理。
  - `dev/`, `staging/`, `prod/`: 各環境（開発、ステージング、本番）のTerraform構成ファイル。
- **src/shared**: 共有モジュール。環境間で共通のリソース設定を管理。
  - `modules/`: 各種クラウドリソース（App Engine、Cloud Run、Cloud SQLなど）のTerraformモジュール。

## Makefileの使用方法

- `make bash`: Dockerコンテナを起動し、TerraformのBashシェルにアクセスします。
- `make stop`: Dockerコンテナを停止します。
- `make down`: Dockerコンテナを削除し、リソースをクリーンアップします。
- `make rm_images`: 使用したDockerイメージを削除します。
- `make auth-dev`, `make auth-staging`, `make auth-prod`: 各環境でGoogle Cloudに認証します。

## Docker構成

`compose.yml`では、TerraformとGoogle Cloud SDKを実行するための2つのサービスが定義されています。

- **terraform**: Terraformの操作を行うためのコンテナ。
- **gcloud**: Google Cloud SDKを使用してGCPの操作を行うためのコンテナ。

## エイリアスの使用方法

`root/.bashrc`に以下のエイリアスが定義されています。これにより、Terraformの操作を簡単に行えます。

### 一般的なエイリアス
- `ll`: カラーでディレクトリ内容を詳細表示します。
- `tf`: `terraform`コマンドの短縮。

### 環境ごとのTerraform操作エイリアス
- `init:dev`, `init:staging`, `init:prod`: 各環境のTerraform初期化。
- `plan:dev`, `plan:staging`, `plan:prod`: 各環境のTerraformプラン作成。
- `apply:dev`, `apply:staging`, `apply:prod`: 各環境のTerraformプラン適用。
- `destroy:dev`, `destroy:staging`, `destroy:prod`: 各環境のTerraformリソース破棄。