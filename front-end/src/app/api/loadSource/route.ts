// src/app/api/loadSource/route.ts
import fs from 'fs';
import path from 'path';
import { NextResponse } from 'next/server';

export async function GET() {
  const sourcePath = path.join(process.cwd(), 'src', 'utils', 'chainlink', 'source.js');
  const sourceData = fs
    .readFileSync(sourcePath)
    .toString();

    return NextResponse.json(sourceData, {
      headers: {
        'Content-Type': 'text/plain',
      },
    });
  }

export const dynamic = 'force-static';