Content-Type: multipart/mixed; boundary="===============0067599584591941571=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: timout delta must be signed
Date: Wed, 09 Oct 2019 19:47:53 +0200
Message-ID: <73b5def2-44e3-1761-c02a-bca57a5a5213@tessares.net>
In-Reply-To: 938ec02702e513154846b2dc9ea9fd9377e26de1.1570628019.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2074

--===============0067599584591941571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 09/10/2019 15:34, Paolo Abeni wrote:
> otherwise later 'tout <=3D 0' check will give unexpected results
> =

> Squash-to "mptcp: introduce MPTCP retransmission timer"
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch, good catch!

Looks good to me!

- cc349836de98: "squashed" in "mptcp: introduce MPTCP retransmission timer"
- signed-off already there
- 4ab3777d5ac7..8b829e9415cf: result

Tests are still OK

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0067599584591941571==--
