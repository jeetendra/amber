# Amber

#### A project to change the world.

## Getting Started

```bash
docker build --no-cache -t amber .

docker run -p 8080:8080 amber
```

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

```bash
npx prisma migrate reset
npx prisma migrate dev
npx prisma db seed
npx prisma studio
```

Install shadcn components
```bash
npx shadcn@latest add button #single component
npx shadcn@latest add --all
```