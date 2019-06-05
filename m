Content-Type: multipart/mixed; boundary="===============8444838434797293594=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: do not warn when replacing an identical
 mapping.
Date: Wed, 05 Jun 2019 19:42:16 +0200
Message-ID: <243078b8-e0d3-f7f1-e021-68bec0ffdd34@tessares.net>
In-Reply-To: 87926986ed8572ddad3c82230f0cf9b883fbbeb9.1559742173.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1291

--===============8444838434797293594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 05/06/2019 15:53, Paolo Abeni wrote:
> Said event can happen due GSO/TSO, do not warn then.
> =

> Fixes: af798ed636e2 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> Notes:
> - I'm ok squashing this commit into the fixed one
> - I can't reproduce the warn locally, need someone else to verify =

>   this one

Thank you for the patch! It looks good to me but I would prefer to wait
for Mat's review on that as he identified the cause.

I tested it locally with the virtme' script and I no longer have the
warning in dmesg!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8444838434797293594==--
