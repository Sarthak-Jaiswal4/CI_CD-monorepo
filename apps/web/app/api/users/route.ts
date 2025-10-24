import { NextResponse } from 'next/server'
import { prismaClient } from '@DB'

export async function GET() {
  try {
    const users = await prismaClient.user.findMany()
    return NextResponse.json(users)
  } catch (error) {
    console.error('Error fetching users:', error)
    return NextResponse.json(
      { error: 'Failed to fetch users' },
      { status: 500 }
    )
  }
}
