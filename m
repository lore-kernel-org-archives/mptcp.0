Content-Type: multipart/mixed; boundary="===============6483339498982332055=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] tcp: mptcp: use mptcp receive
 buffer space to select rcv window
Date: Thu, 26 Mar 2020 18:00:14 +0100
Message-ID: <0a7db1a8-a0d4-dbf4-875d-ee5dead75364@tessares.net>
In-Reply-To: 20200319135133.13825-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4083

--===============6483339498982332055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 19/03/2020 14:51, Florian Westphal wrote:
> In MPTCP, the receive windo is shared across all subflows, because it
> refers to the mptcp-level sequence space.
> =

> This commit doesn't change choice of initial window for passive or active
> connections.
> While it would be possible to change those as well, this adds complexity
> (especially when handling MP_JOIN requests).
> =

> However, the MPTCP RFC specifically says that a MPTCP sender
> 'MUST NOT use the RCV.WND field of a TCP segment at the connection level =
if
> it does not also carry a DSS option with a Data ACK field.'
> =

> SYN/SYNACK packets do not carry a DSS option with a Data ACK field.

Thank you for the patch!

As agreed at the last meeting, I just added this patch at the end of the =

series

- 2c2fd841cd0c: tcp: mptcp: use mptcp receive buffer space to select rcv =

window
- cda56df42342..4634f8736a6b: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6483339498982332055==--
