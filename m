Content-Type: multipart/mixed; boundary="===============2277208431124092223=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20190210: a few conflicts
Date: Mon, 10 Feb 2020 11:16:16 +0100
Message-ID: <e898d046-8cc8-f59a-6448-3aae1cc65f06@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3607

--===============2277208431124092223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Recently, 'net-next' has been synced with Linus tree including recent =

changes in 'net'.

We then had a few conflicts with two patches from Florian:
- b0519de8b3f1 (mptcp: fix use-after-free for ipv6)
- 2c22c06ce426 (mptcp: fix use-after-free on tcp fallback)

The resolution were quite simple, only because new functions have been =

added or removed. Here are the resolution:

- 6c8b03547162: conflict in =

t/mptcp-queue-data-for-mptcp-level-retransmission
- d7940fab2c95: conflict in =

t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue

Tests and export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2277208431124092223==--
