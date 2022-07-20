# coffee-matching-app

# 環境構築

## 初回セットアップ

以下 setup shell を実行 第一引数に任意の db パスワードを渡す

```
./setup.sh DB_PASSWORD
```

### front

http://localhost:8000

### graphql

http://localhost:3000/graphql

## データベース GUI

ブラウザで DB を操作する

```
make prisma-studio
```

### prisma studio

http://localhost:5555
