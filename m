Content-Type: multipart/mixed; boundary="===============0063912598721385336=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Restore lost hunk
Date: Fri, 23 Aug 2019 20:10:39 +0200
Message-ID: <34f7b9af-820b-9bae-e7cd-d96191454087@tessares.net>
In-Reply-To: 20190822224656.6414-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1692

--===============0063912598721385336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 23/08/2019 00:46, Peter Krystad wrote:
> This chunk from Patch 01 "Extend path manager interface" of
> the Implement outgoing MP_JOIN patchset did not survive
> getting squashed and needs to be restored.
> =

> squashto: Add path manager interface

Thank you for the patch and again good catch for having seen the missing
part (sorry for that)! Just applied the patch:

- 5d51e217f066: "squashed" in "mptcp: Add path manager interface"
- 328298c32eac..3558511b2489: result

Tests and export in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0063912598721385336==--
