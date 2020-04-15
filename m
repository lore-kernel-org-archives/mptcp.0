Content-Type: multipart/mixed; boundary="===============0462606434169265712=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 0/7] mptcp: fix splats and crashes
Date: Wed, 15 Apr 2020 19:19:47 +0200
Message-ID: <20200415171954.15321-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4179

--===============0462606434169265712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series resolves a number of crashes in MPTCP.
I'm not 100% sure yet that I managed to fix all of them (I will run
the selftest again over night), but I wanted to send it out anyway
because its unlikely that any of the fixes is flat out wrong.
If anything, there is a different/better solution that I missed so far
or another fix needs to be placed on top of this pile.

Florian Westphal (7):
      mptcp: fix splat when incoming connection is never accepted before ex=
it/close
      mptcp: fix 'Attempt to release TCP socket in state' warnings
      mptcp: handle mptcp listener destruction via rcu
      mptcp: avoid callback invocation when mptcp parent socket doesn't exi=
st
      mptcp: use rcu helpers to fetch ulp subflow context
      mptcp: reverse order of sk_state_change and is_mptcp check
      mptcp: prevent null deref crash on normal tcp sockets

 protocol.c |   29 +++++++++++++----
 protocol.h |   14 +-------
 subflow.c  |  103 +++++++++++++++++++++++++++++++++++++++++++++++---------=
-----
 3 files changed, 105 insertions(+), 41 deletions(-)

--===============0462606434169265712==--
