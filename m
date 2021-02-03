Content-Type: multipart/mixed; boundary="===============6985304162119508971=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/2] mptcp: handle socket errors
Date: Wed, 03 Feb 2021 12:24:01 +0100
Message-ID: <55e7a762-e819-b2f0-ca44-dc66da6192f6@tessares.net>
In-Reply-To: cover.1612201708.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7606

--===============6985304162119508971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 01/02/2021 19:12, Paolo Abeni wrote:
> This introduces the initial support for msk-level socket error
> handling.
> =

> Currently subflow socket errors are always ignored. That is almost
> correct - I think - because the single subflow status does not
> affect the msk-level connection.
> =

> There a couple of notable exceptions:
> - fallen-back msk
> - error at connect time on the MPC subflow
> both should be propagated at msk level.
> =

> patch 1 implement the relevant infra
> patch 2 is actuall a bug fix, for some edge cases that become
> apparent testing the above.
> =

> I'll push a bunch of pktdrill test case which will cover the above.

Thank you for your patches, new pktdrill tests and the reviews! I just =

added them in our tree with Mat's RvB tags (and slightly modified the =

commit message of patch 2/2 as discussed on IRC).

- d55492a9942b: mptcp: deliver ssk errors to msk
- 330d6265d893: mptcp: fix poll after shutdown
- Results: 130bfe7ce033..f3a1a5d5ef41

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6985304162119508971==--
