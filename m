Content-Type: multipart/mixed; boundary="===============4954536129271834573=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] MP_JOIN handling: v3 from Peter
Date: Mon, 17 Jun 2019 17:05:19 +0200
Message-ID: <0dcf10a3-2279-d5b6-b719-f31e0cfb90ba@tessares.net>
In-Reply-To: 20190617141142.6782-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1419

--===============4954536129271834573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 17/06/2019 16:11, Matthieu Baerts wrote:
> Peter recently sent a v3 of his patch-set but I had already applied it in=
 the
> repo. Here is what I extracted from the v3 using diff.
> =

> If Paolo (or others) is OK, I can include this in what we are going to se=
nd to
> Eric.
> =

> Peter Krystad (3):
>   squash to: mptcp: Add path manager interface
>   squash to: mptcp: Add ADD_ADDR handling
>   squash to: mptcp: Add handling of incoming MP_JOIN requests

I just added these three patches in the repo:

- f2631ec64309: "squash" in "mptcp: Add path manager interface"
- cc3a76e86281: "squash" in "mptcp: Add ADD_ADDR handling"
- f9740e55ea8f: "squash" in "mptcp: Add handling of incoming MP_JOIN
requests"
- no conflicts
- no signed-off modified.
- 8ea5282ba8cf..e29c0bc9c0c1: result

I can revert them if needed. Don't hesitate to tell me if I merged them
too soon.

They looked good to me and I guess we wanted to have them before sending
everything for review.

Thanks Peter for the new version, I hope I correctly extracted your last
changes.

Cheers,
Matt

> =

>  include/linux/tcp.h  |  9 +++++--
>  include/net/mptcp.h  |  6 +++--
>  net/mptcp/options.c  | 56 +++++++++++++++++++++-----------------------
>  net/mptcp/pm.c       | 23 +++++++++---------
>  net/mptcp/protocol.c |  2 +-
>  net/mptcp/protocol.h |  9 +++++++
>  net/mptcp/subflow.c  |  9 ++++---
>  7 files changed, 65 insertions(+), 49 deletions(-)
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4954536129271834573==--
