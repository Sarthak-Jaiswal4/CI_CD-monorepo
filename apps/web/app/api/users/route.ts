import { NextResponse } from 'next/server'
import { prisma } from '@DB'

export async function GET() {
  try {
    const apiUrl = process.env.NEXT_PUBLIC_API_URL?.trim() || 'http://backend:3001';
    const response = await fetch(`${apiUrl}/users`);
    const users = await response.json()
    return NextResponse.json(users)
  } catch (error) {
    console.error('Error fetching users:', error)
    return NextResponse.json(
      { error: error },
      { status: 500 }
    )
  }
}
