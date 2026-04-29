---
description: "Frontend conventions for Next.js 15 App Router — TypeScript strict, Tailwind CSS, shadcn/ui, server components"
applyTo: '**/app/**,**/components/**,**/*.tsx,**/*.ts'
---

# Frontend Specification — Next.js 15 + TypeScript

This file is activated when you work on TypeScript or TSX files, or anything under `app/` or `components/`. It enforces the frontend conventions for the modernized system.

## Stack Summary

| Layer | Technology | Version |
|-------|-----------|---------|
| Framework | Next.js (App Router) | 15 |
| Language | TypeScript (strict mode) | 5+ |
| Styling | Tailwind CSS | 3.4+ |
| Components | shadcn/ui | Latest |
| State (client) | Zustand | 4+ |
| State (server) | React Query / TanStack Query | 5+ |
| Testing | Vitest + Testing Library | Latest |

## App Router Patterns

### Server Components (Default)

Every component is a Server Component unless explicitly marked otherwise. Server Components:

- Run on the server, never ship JS to the client
- Can `await` data fetches directly
- Cannot use hooks, event handlers, or browser APIs

```tsx
// app/payments/page.tsx — Server Component (default)
export default async function PaymentsPage() {
  const payments = await fetch('/api/payments').then(r => r.json());
  return <PaymentList payments={payments} />;
}
```

### Client Components

Add `'use client'` only when you need interactivity:

```tsx
'use client';

import { useState } from 'react';

export function PaymentFilter({ onFilter }: { onFilter: (term: string) => void }) {
  const [term, setTerm] = useState('');
  return (
    <input
      value={term}
      onChange={e => { setTerm(e.target.value); onFilter(e.target.value); }}
      placeholder="Filter payments..."
    />
  );
}
```

Rules:

- **Minimize `'use client'` surface**: Push interactivity to the smallest possible component. A page that fetches data should be a Server Component; only the interactive filter/form inside it should be a Client Component.
- **Never expose secrets in client components**: API keys, tokens, and internal URLs must stay server-side.

### Server Actions for Mutations

Use server actions instead of API route handlers for form submissions:

```tsx
// app/payments/actions.ts
'use server';

export async function createPayment(formData: FormData) {
  const amount = formData.get('amount');
  // Validate and call backend API
  const res = await fetch(`${process.env.API_URL}/payments`, {
    method: 'POST',
    body: JSON.stringify({ amount }),
    headers: { 'Content-Type': 'application/json' },
  });
  if (!res.ok) throw new Error('Payment creation failed');
}
```

## TypeScript Conventions

- **`strict: true`** in `tsconfig.json` — no exceptions, no `// @ts-ignore`
- **No `any`**: Use `unknown` and narrow with type guards
- **Named exports only**: `export function PaymentCard()` — no `export default`
- **Interface over type** for object shapes that may be extended
- **Utility types**: Use `Pick`, `Omit`, `Partial` instead of duplicating interfaces

```tsx
// Good: named export, typed props
export function PaymentCard({ payment }: { payment: PaymentDto }) {
  return <div>{payment.amount}</div>;
}

// Bad: default export, any type
export default function PaymentCard({ payment }: { payment: any }) { ... }
```

## Tailwind CSS + shadcn/ui

- Use Tailwind utility classes directly — no separate CSS files unless absolutely necessary
- Use shadcn/ui components for standard UI elements (Button, Card, Table, Dialog, etc.)
- Follow the design system tokens defined in `design-system/` for colors and spacing
- Responsive by default: mobile-first with `sm:`, `md:`, `lg:` breakpoints

```tsx
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export function PaymentSummary({ total }: { total: number }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Payment Summary</CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-2xl font-bold">{total.toLocaleString('en-US', { style: 'currency', currency: 'BRL' })}</p>
      </CardContent>
    </Card>
  );
}
```

## Accessibility Baseline

Every page and component must meet these minimums:

- All images have `alt` text
- Form inputs have associated `<label>` elements
- Interactive elements are keyboard-navigable
- Color is not the only means of conveying information
- Page has a single `<h1>`, headings follow logical order

## Testing with Vitest

```tsx
import { render, screen } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
import { PaymentCard } from './PaymentCard';

describe('PaymentCard', () => {
  it('should display the payment amount', () => {
    render(<PaymentCard payment={{ id: 1, amount: 100.50 }} />);
    expect(screen.getByText('100.5')).toBeInTheDocument();
  });
});
```

Test naming: `should_[expected behavior]_when_[condition]` or `displays [what] when [condition]`.

## What NOT to Do

- **No `export default`** from component files — use named exports
- **No `any`** — use `unknown` and type guards
- **No `.then()` chains** — use `async/await`
- **No CSS modules or styled-components** — use Tailwind
- **No client-side data fetching in Server Components** — fetch directly with `await`
- **No secrets in `'use client'` files** — environment variables starting with `NEXT_PUBLIC_` are exposed to the browser
