import { NextResponse } from 'next/server'
import { prisma } from '@DB'

export async function GET() {
  try {
    const response = await fetch('http://localhost:3001/users')
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
