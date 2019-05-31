Content-Type: multipart/mixed; boundary="===============3062136916796699935=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3] mptcp: Make mptcp initialization part of tcp
 initialization
Date: Fri, 31 May 2019 11:10:43 +0200
Message-ID: <fce1eee0-26e2-3883-c409-a4eca1162e07@tessares.net>
In-Reply-To: 20190528203754.25462-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1268

--===============3062136916796699935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Florian,

On 28/05/2019 22:37, Peter Krystad wrote:
> Remove remnant module initialization of MPTCP and make it
> part of the inet/tcp initialization sequence.
> =

> OK to squash but needs to be split up between
> "mptcp: Add MPTCP socket stubs" and
> "mptcp: Associate MPTCP context with TCP socket"
> =

> v2 - ignore
> v3 - fix function declaration


Thank you for the patch, the new version and the review.

Florian: is this new version OK for you?

Speak to you later,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3062136916796699935==--
