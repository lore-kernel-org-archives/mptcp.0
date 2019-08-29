Content-Type: multipart/mixed; boundary="===============6237577511879078866=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fall back to tcp when dss checksum are
 requested
Date: Thu, 29 Aug 2019 15:11:48 +0200
Message-ID: <dee26a37-e6b9-c472-b33b-0cfffbd6d31d@tessares.net>
In-Reply-To: 4196b86e8b48e6357f486fbed2c5d7e03a6189b8.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1757

--===============6237577511879078866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Peter, Christoph,

On 27/08/2019 19:57, Peter Krystad wrote:
> =

> Hi Florian - =

> =

> Yeah, this isn't great, I am OK with your original patch. I'll take a to-=
do to
> remove the 'request_cksum' logic, since it doesn't have any purpose until
> checksums are implemented.

Thank you for the patch and the reviews!

Just applied in the repo:
- 87fd3fd5c2fc: "squashed" in "mptcp: Handle MPTCP TCP options"
- 16c36ea3d8e9: signed-off
- 0a3de10b90d9..ca4c26db67e0: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6237577511879078866==--
