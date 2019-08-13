Content-Type: multipart/mixed; boundary="===============6661359721516115901=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Add sock_put() call on error path
Date: Tue, 13 Aug 2019 17:16:08 +0200
Message-ID: <403d4547-4d93-33e7-d821-255112d43ebf@tessares.net>
In-Reply-To: 20190812235758.8530-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1635

--===============6661359721516115901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Peter,

On 13/08/2019 01:57, Peter Krystad wrote:
> Per final review comment
> =

> squashto: Add handling of outgoing MP_JOIN requests

Thank you for finding the issue and fixing it!

- 527d1a3ee6a8: "squashed" in "mptcp: Add handling of outgoing MP_JOIN
requests"
- 6e195bff312b..a873cedf4afa: result

Tests are still OK.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6661359721516115901==--
