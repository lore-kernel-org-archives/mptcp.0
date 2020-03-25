Content-Type: multipart/mixed; boundary="===============3779353305774713660=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: fix "fn parameter not described"
 warnings
Date: Wed, 25 Mar 2020 17:05:10 +0100
Message-ID: <9b982f3e-8153-4015-5540-96ddbf3f5eba@tessares.net>
In-Reply-To: 17613bfe3e3e6eb6d274b1ccd3dc0e520b0ee24b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4064

--===============3779353305774713660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo

On 24/03/2020 18:16, Paolo Abeni wrote:
> On Tue, 2020-03-24 at 17:57 +0100, Matthieu Baerts wrote:
>> When checking for extra warnings using 'make W=3D1' [1], I saw

(...)

> LGTM, thanks!

Thank you for the review!

- 788529fd0b12: "squashed" patch 1/3 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- I didn't add a co-dev + signoff for such a stupid change :)
- ec1aaf05bfd7..9cd05fa08754: result

The two other patches have been added at the end of the series:

- 8030fda9b40e: mptcp: fix "fn parameter not described" warnings
- 4fe9e0c3242c: mptcp: fix "fn parameter not described" warning

Tests + export are OK

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3779353305774713660==--
