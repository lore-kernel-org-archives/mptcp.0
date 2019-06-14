Content-Type: multipart/mixed; boundary="===============5155437821256603504=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/4] Move MPTCP #defines to internal header
Date: Fri, 14 Jun 2019 16:21:05 +0200
Message-ID: <d51c35d7-c197-665e-522b-d8de90701a21@tessares.net>
In-Reply-To: 20190613222454.10728-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1376

--===============5155437821256603504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 14/06/2019 00:24, Peter Krystad wrote:
> Like it says...
> =

> Peter Krystad (4):
>   mptcp: Move TCPOLEN #defines to protocol.h
>   mptcp: Move TCPOLEN #defines to protocol.h
>   mptcp: Move TCPOLEN #defines to protocol.h
>   mptcp: make flag field naming consistent

Thank you for the patches and the review!

1)
  - 04315cde541a: "squash" in "mptcp: Handle MPTCP TCP options" (with a
small conflict)
  - 24d7971f53d8: conflict
  - 952528707b4d: conflict
2)
  - c8bd7a330237: "squash" in "mptcp: Write MPTCP DSS headers to
outgoing data packets"
  - 7f26de3a2add: conflict
3)
  - cd98bf4f67da: "squash" in "mptcp: Implement MPTCP receive path"
  - no conflict
4)
  - c7a47030a18b: "squash" in "mptcp: Handle MPTCP TCP options"
  - no conflict

9ff7aba894d0..f9b94b899a7f: result

All signed-off were already there.
Tests are all OK.

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5155437821256603504==--
