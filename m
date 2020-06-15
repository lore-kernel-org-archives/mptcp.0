Content-Type: multipart/mixed; boundary="===============0649796003925236706=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] mptcp: fix some mp_join error paths
Date: Mon, 15 Jun 2020 17:02:01 +0200
Message-ID: <5827f1e1-0f57-bd38-8a6c-9e2d63fe4501@tessares.net>
In-Reply-To: cover.1591895765.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4678

--===============0649796003925236706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/06/2020 19:20, Paolo Abeni wrote:
> Currently we do not handle correctly MP_JOIN + syncookie and MP_JOIN
> failure due to passive socket being already closed.
> =

> First patch place the infrastructure needed, the 2nd one addresses the is=
sues.
> Note: in such error path, we will end-up creating the child socket just to
> reset the connection. I don't see an easy way to avoid such allocation and
> doing differently (reset on syn) could be dangerous (attacker can use the=
 mptcp
> server to target a victim using spoofed bogus mp_join syn)

Thank you for the patches and the reviews!

I added the two patches before "mptcp: add __init annotation on setup =

functions".

I had a bit of conflicts when applying the first one and later:
- 0adf8b763a86: mptcp: cache msk on MP_JOIN init_req
- 30896dd8f6df: mptcp: drop MP_JOIN request sock on syn cookies
- 9640eebdb4ff: conflict in t/mptcp-refactor-token-container

Tests are going to be launched soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0649796003925236706==--
