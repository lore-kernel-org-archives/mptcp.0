Content-Type: multipart/mixed; boundary="===============4338493838033163877=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/3] Rename lookup_token() to __token_lookup
Date: Tue, 13 Aug 2019 16:24:38 +0200
Message-ID: <64d11d48-9023-4f84-360c-597477e5c8d2@tessares.net>
In-Reply-To: 20190807234426.13691-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1631

--===============4338493838033163877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat,

On 08/08/2019 01:44, Peter Krystad wrote:
> Naming better aligns with token_lookup_get().
> =

> squashto: Add handling of incoming MP_JOIN requests

Thank you for the patch and the review!

I had to split this in two parts:
- 65afe9b86a32: part 1: "squashed" in "mptcp: Add handling of incoming
MP_JOIN requests"
- 049f8ef19750: part 2: "squashed" in "mptcp: Implement path manager
interface commands"

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4338493838033163877==--
